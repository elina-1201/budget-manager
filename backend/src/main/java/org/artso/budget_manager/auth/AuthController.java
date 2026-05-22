package org.artso.budget_manager.auth;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.dto.RefreshTokenRequest;
import org.artso.budget_manager.auth.dto.TokenResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.jwt.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.time.Instant;
import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/auth")
public class AuthController {
    final AppUserService service;
    final JwtEncoder jwtEncoder;
    final JwtDecoder jwtDecoder;
    static final int ACCESS_EXP = 60 * 15; // 15min
    static final int REFRESH_EXP = 60 * 60 * 24 * 14; // 14days

    //for testing
//    static final int ACCESS_EXP = 30;
//    static final int REFRESH_EXP = 50;

    @PostMapping("/register")
    ResponseEntity<?> registerUser(@Valid @RequestBody AppUser appUser) {
        try {
            service.addUser(appUser);
            return new ResponseEntity<>(appUser, HttpStatus.CREATED);
        } catch (ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }

    String getJwtToken(String subject, String type, List<String> authorities) {
        int expirationInSeconds = type.equals("refresh") ? REFRESH_EXP : ACCESS_EXP;

        var accessClaims = JwtClaimsSet.builder()
                .subject(subject)
                .issuedAt(Instant.now())
                .expiresAt(Instant.now().plusSeconds(expirationInSeconds))
                .claim("scope", authorities)
                .claim("token_type", type)
                .build();

        return jwtEncoder.encode(JwtEncoderParameters.from(accessClaims)).getTokenValue();
    }

    @PostMapping("/token")
    public ResponseEntity<TokenResponse> getTokens(Authentication auth) {
        List<String> authorities = auth.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority).toList();

        String accessToken = getJwtToken(auth.getName(), "access", authorities); // 60 * 15 -> 15min
        String refreshToken = getJwtToken(auth.getName(), "refresh", authorities); // 60 * 60 * 24 * 14 -> 14days

        return new ResponseEntity<>(new TokenResponse(accessToken, refreshToken), HttpStatus.OK);
    }

    @PostMapping("/refresh")
    public ResponseEntity<?> getRefreshToken(@Valid @RequestBody RefreshTokenRequest request) {
        try {
            var jwt = jwtDecoder.decode(request.refreshToken());

            String subject = jwt.getSubject();
            List<String> authorities = jwt.getClaimAsStringList("scope");

            String accessToken = getJwtToken(subject, "access", authorities);
            String refreshToken = getJwtToken(subject, "refresh", authorities);

            return new ResponseEntity<>(new TokenResponse(accessToken, refreshToken), HttpStatus.OK);

        } catch (JwtException e) {
            return new ResponseEntity<>("Invalid refresh token", HttpStatus.UNAUTHORIZED);
        }
    }
}