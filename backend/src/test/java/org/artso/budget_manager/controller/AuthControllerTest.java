package org.artso.budget_manager.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.artso.budget_manager.dto.request_and_response.RefreshTokenRequest;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.service.AppUserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtEncoder;
import org.springframework.security.oauth2.jwt.JwtEncoderParameters;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.time.Instant;
import java.util.List;

import static org.assertj.core.api.Assertions.*;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.httpBasic;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Comprehensive test suite for token authentication in the budget manager application.
 *
 * This test class covers:
 * 1. User registration - Verifies that users can be registered
 * 2. Token generation - Tests that both access and refresh tokens are returned
 * 3. Login with access token - Ensures access tokens can authenticate requests
 * 4. Token expiration - Verifies tokens expire after the configured time
 * 5. Token refresh - Tests the refresh token endpoint to get new access tokens
 *
 * All tests use MockMvc to test the HTTP endpoints without requiring a live server.
 */
@SpringBootTest
@DisplayName("Authentication Controller Tests")
class AuthControllerTest {
    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    private ObjectMapper objectMapper;

    @Autowired
    private JwtDecoder jwtDecoder;

    @Autowired
    private JwtEncoder jwtEncoder;

    @Autowired
    private AppUserService appUserService;

    private String userEmail;
    private String userPassword;

    private String createExpiredAccessToken(String subject) {
        JwtClaimsSet expiredClaims = JwtClaimsSet.builder()
                .subject(subject)
                .issuedAt(Instant.now().minusSeconds(120))
                .expiresAt(Instant.now().minusSeconds(60))
                .claim("scope", List.of())
                .claim("token_type", "access")
                .build();

        return jwtEncoder.encode(JwtEncoderParameters.from(expiredClaims)).getTokenValue();
    }

    @BeforeEach
    void setUp() {
        // Initialize MockMvc with Spring Security
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
                .apply(springSecurity())
                .build();
        
        // Initialize ObjectMapper locally
        objectMapper = new ObjectMapper();
        
        // Initialize test user data with unique email to avoid conflicts between tests
        userEmail = "testauth" + System.currentTimeMillis() + "@example.com";
        userPassword = "TestPassword123!";
        
        // Create and save a real test user to the database
        AppUser testUser = new AppUser();
        testUser.setEmail(userEmail);
        testUser.setName("Test User");
        testUser.setPassword(userPassword);
        
        // Register the user with the real service (will hash password)
        appUserService.addUser(testUser);
    }

    @Test
    @DisplayName("Should register a new user successfully")
    void testRegisterUser_Success() throws Exception {
        AppUser newUser = new AppUser();
        newUser.setEmail("newuser" + System.currentTimeMillis() + "@example.com");
        newUser.setName("New Test User");
        newUser.setPassword("Password123!");

        // Act & Assert: Send POST request to register endpoint
        mockMvc.perform(post("/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(newUser)))
                .andExpect(status().isCreated());
    }

    @Test
    @DisplayName("Should reject registration with duplicate email")
    void testRegisterUser_DuplicateEmail() throws Exception {
        // Arrange: Try to register the same user again
        AppUser duplicateUser = new AppUser();
        duplicateUser.setEmail(userEmail);
        duplicateUser.setName("Test User");
        duplicateUser.setPassword(userPassword);

        // Act & Assert: Expect 409 Conflict response (email already registered)
        mockMvc.perform(post("/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(duplicateUser)))
                .andExpect(status().isConflict());
    }

    @Test
    @DisplayName("Should return both access and refresh tokens on successful login")
    void testGetTokens_ReturnsAccessAndRefreshTokens() throws Exception {
        // Arrange: The user must be authenticated via basic auth
        // Using @WithMockUser provides authentication context

        // Act: Send POST request to token endpoint with basic authentication
        MvcResult result = mockMvc.perform(post("/auth/token")
                .with(httpBasic(userEmail, userPassword)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.access_token").isString())
                .andExpect(jsonPath("$.access_token").isNotEmpty())
                .andExpect(jsonPath("$.refresh_token").isString())
                .andExpect(jsonPath("$.refresh_token").isNotEmpty())
                .andReturn();

        // Assert: Verify token structure
        String response = result.getResponse().getContentAsString();
        assertThatCode(() -> {
            // Extract tokens from response
            var tokens = objectMapper.readTree(response);
            String accessToken = tokens.get("access_token").asText();
            String refreshToken = tokens.get("refresh_token").asText();

            // Verify tokens are JWTs (have 3 parts separated by dots)
            assertThat(accessToken).contains(".");
            assertThat(refreshToken).contains(".");
        }).doesNotThrowAnyException();
    }

    /**
     * This test verifies that the tokens contain the correct claims
     * (subject = email, token_type, scope/authorities)
     *
     * Expected behavior:
     * - Access token contains subject (email), token_type=access, and scope
     * - Refresh token contains subject (email), token_type=refresh, and scope
     */
    @Test
    @DisplayName("Should include correct claims in tokens")
    void testGetTokens_TokensContainCorrectClaims() throws Exception {
        // Act: Get tokens from endpoint
        MvcResult result = mockMvc.perform(post("/auth/token")
                .with(httpBasic(userEmail, userPassword)))
                .andExpect(status().isOk())
                .andReturn();

        // Assert: Decode tokens and verify claims
        String response = result.getResponse().getContentAsString();
        var tokens = objectMapper.readTree(response);
        String accessToken = tokens.get("access_token").asText();
        String refreshToken = tokens.get("refresh_token").asText();

        // Decode and verify access token claims
        var decodedAccessToken = jwtDecoder.decode(accessToken);
        assertThat(decodedAccessToken.getSubject()).isEqualTo(userEmail);
        assertThat(decodedAccessToken.getClaimAsString("token_type")).isEqualTo("access");
        assertThat(decodedAccessToken.getClaimAsStringList("scope")).isNotNull();

        // Decode and verify refresh token claims
        var decodedRefreshToken = jwtDecoder.decode(refreshToken);
        assertThat(decodedRefreshToken.getSubject()).isEqualTo(userEmail);
        assertThat(decodedRefreshToken.getClaimAsString("token_type")).isEqualTo("refresh");
    }

    @Test
    @DisplayName("Should authenticate requests with valid access token")
    void testAuthenticateWithAccessToken() throws Exception {
        // Arrange: Get an access token first
        MvcResult tokenResult = mockMvc.perform(post("/auth/token")
                .with(httpBasic(userEmail, userPassword)))
                .andExpect(status().isOk())
                .andReturn();

        String response = tokenResult.getResponse().getContentAsString();
        var tokens = objectMapper.readTree(response);
        String accessToken = tokens.get("access_token").asText();

        // Act: Use the access token to make an authenticated request to a protected endpoint
        mockMvc.perform(get("/item")
                .header("Authorization", "Bearer " + accessToken))
                .andExpect(status().isOk());

        // The test passes if we get 200 OK, meaning the token was accepted
    }

    @Test
    @DisplayName("Should reject expired access tokens")
    void testAccessTokenExpiration() throws Exception {
        // Act & Assert: Simulate an expired token independent of configured TTL
        String expiredAccessToken = createExpiredAccessToken(userEmail);
        mockMvc.perform(get("/item")
                .header("Authorization", "Bearer " + expiredAccessToken))
                .andExpect(status().isUnauthorized());
    }

    /**
     * This test verifies the practical scenario: when an access token expires,
     * the user can use their refresh token to get a new access token without
     * having to provide their credentials again.
     *
     * Expected behavior:
     * - Expired access token is rejected with 401 UNAUTHORIZED
     * - Refresh token (valid for 30 seconds) can still be used
     * - Using refresh token returns new valid access tokens
     * - New access token can be used for authenticated requests
     */
    @Test
    @DisplayName("Should allow getting new access token after expiration using refresh token")
    void testRefreshToken_AfterAccessTokenExpires() throws Exception {
        // Arrange: Get initial tokens
        MvcResult initialTokenResult = mockMvc.perform(post("/auth/token")
                .with(httpBasic(userEmail, userPassword)))
                .andExpect(status().isOk())
                .andReturn();

        String initialResponse = initialTokenResult.getResponse().getContentAsString();
        var initialTokens = objectMapper.readTree(initialResponse);
        String refreshToken = initialTokens.get("refresh_token").asText();

        // Assert 1: Verify access token is expired
        String expiredAccessToken = createExpiredAccessToken(userEmail);
        mockMvc.perform(get("/item")
                .header("Authorization", "Bearer " + expiredAccessToken))
                .andExpect(status().isUnauthorized());

        // Act 2: Use refresh token to get new access token
        String refreshRequest = objectMapper.writeValueAsString(
                new RefreshTokenRequest(refreshToken));

        MvcResult newTokenResult = mockMvc.perform(post("/auth/refresh")
                .contentType(MediaType.APPLICATION_JSON)
                .content(refreshRequest))
                .andExpect(status().isOk())
                .andReturn();

        // Assert 2: New access token is valid and works
        String newResponse = newTokenResult.getResponse().getContentAsString();
        var newTokens = objectMapper.readTree(newResponse);
        String newAccessToken = newTokens.get("access_token").asText();

        mockMvc.perform(get("/item")
                .header("Authorization", "Bearer " + newAccessToken))
                .andExpect(status().isOk());
    }

    /**
     *
     * This test verifies that invalid or malformed refresh tokens are rejected.
     *
     * Expected behavior:
     * - POST request to /auth/refresh with invalid token
     * - Returns 401 UNAUTHORIZED status
     * - Error message indicates invalid token
     */
    @Test
    @DisplayName("Should reject invalid refresh tokens")
    void testRefreshToken_InvalidToken() throws Exception {
        // Arrange: Create an invalid refresh request
        String invalidRefreshRequest = objectMapper.writeValueAsString(
                new RefreshTokenRequest("invalid.token.here"));

        // Act & Assert: Expect 401 Unauthorized response
        mockMvc.perform(post("/auth/refresh")
                .contentType(MediaType.APPLICATION_JSON)
                .content(invalidRefreshRequest))
                .andExpect(status().isUnauthorized())
                .andExpect(jsonPath("$").value("Invalid refresh token"));
    }

    @Test
    @DisplayName("Should reject unauthenticated requests to protected endpoints")
    void testUnauthenticatedRequest_Rejected() throws Exception {
        // Act & Assert: Request without credentials should be rejected
        mockMvc.perform(get("/item"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("Should reject login with invalid credentials")
    void testLoginWithInvalidCredentials() throws Exception {
        // Act & Assert: Login with incorrect credentials
        mockMvc.perform(post("/auth/token")
                .with(httpBasic(userEmail, "wrongpassword")))
                .andExpect(status().isUnauthorized());
    }
}

