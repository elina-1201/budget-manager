package org.artso.budget_manager.invitation;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.auth.dto.RegisterRequest;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.invitation.dto.InvitationRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.HashSet;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.httpBasic;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@DisplayName("Invitation Controller Integration Tests")
public class InvitationControllerTest {
    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Autowired
    private AppUserService appUserService;

    @Autowired
    private GroupRepo groupRepo;

    @Autowired
    private InvitationRepo invitationRepo;

    private ObjectMapper objectMapper;

    private String senderEmail;
    private String senderPassword;
    private String recipientEmail;
    private String recipientPassword;

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext)
                .apply(springSecurity())
                .build();

        objectMapper = new ObjectMapper();

        long ts = System.currentTimeMillis();
        senderEmail = "sender" + ts + "@example.com";
        senderPassword = "SenderPass123!";
        recipientEmail = "recipient" + ts + "@example.com";
        recipientPassword = "RecipientPass123!";

        appUserService.addUser(new RegisterRequest("Sender", senderEmail, senderPassword));
        appUserService.addUser(new RegisterRequest("Recipient", recipientEmail, recipientPassword));

        // Clean up any leftover invitations
        invitationRepo.deleteAll();
    }

    @Test
    @DisplayName("Should create invitation, get it as recipient, accept it and then decline another one")
    void testInvitationFlows() throws Exception {
        // Create a group
        UserGroup group = new UserGroup();
        group.setName("testgroup" + System.currentTimeMillis());
        group.setUsers(new HashSet<>());
        group = groupRepo.save(group);

        // Get sender's access token
        MvcResult tokenResult = mockMvc.perform(post("/auth/token")
                        .with(httpBasic(senderEmail, senderPassword)))
                .andExpect(status().isOk())
                .andReturn();

        String tokenResponse = tokenResult.getResponse().getContentAsString();
        String senderAccessToken = objectMapper.readTree(tokenResponse).get("access_token").asText();

        // Create an invitation as sender
        InvitationRequest inviteRequest = new InvitationRequest(recipientEmail, group.getId());
        MvcResult createResult = mockMvc.perform(post("/invitation")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(inviteRequest))
                        .header("Authorization", "Bearer " + senderAccessToken))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.recipientEmail").value(recipientEmail))
                .andReturn();

        Long invitationId = objectMapper.readTree(createResult.getResponse().getContentAsString()).get("id").asLong();

        // Get recipient's access token
        MvcResult recipientTokenResult = mockMvc.perform(post("/auth/token")
                        .with(httpBasic(recipientEmail, recipientPassword)))
                .andExpect(status().isOk())
                .andReturn();

        String recipientAccessToken = objectMapper.readTree(recipientTokenResult.getResponse().getContentAsString())
                .get("access_token").asText();

        // Retrieve invitations as recipient
        mockMvc.perform(get("/invitation")
                        .header("Authorization", "Bearer " + recipientAccessToken))
                .andExpect(status().isOk())
                .andExpect(jsonPath("[0].id").value(invitationId));

        // Accept the invitation
        mockMvc.perform(post("/invitation/" + invitationId + "/accept")
                        .header("Authorization", "Bearer " + recipientAccessToken))
                .andExpect(status().isOk());

        // Invitation should be deleted after accept
        assertThat(invitationRepo.findById(invitationId)).isEmpty();

        // Verify recipient is now in the group
        boolean added = groupRepo.existsByIdAndUsersEmailIgnoreCase(group.getId(), recipientEmail);
        assertThat(added).isTrue();

        // Create another invitation to test decline flow
        MvcResult createSecond = mockMvc.perform(post("/invitation")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(new InvitationRequest(recipientEmail, group.getId())))
                        .header("Authorization", "Bearer " + senderAccessToken))
                .andExpect(status().isConflict()) // should conflict because user is already in the group
                .andReturn();

        // To test decline properly, create a fresh group and invite again
        UserGroup group2 = new UserGroup();
        group2.setName("testgroup2" + System.currentTimeMillis());
        group2.setUsers(new HashSet<>());
        group2 = groupRepo.save(group2);

        MvcResult createThird = mockMvc.perform(post("/invitation")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(new InvitationRequest(recipientEmail, group2.getId())))
                        .header("Authorization", "Bearer " + senderAccessToken))
                .andExpect(status().isCreated())
                .andReturn();

        Long invitationToDecline = objectMapper.readTree(createThird.getResponse().getContentAsString()).get("id").asLong();

        // Decline the invitation
        mockMvc.perform(post("/invitation/" + invitationToDecline + "/decline")
                        .header("Authorization", "Bearer " + recipientAccessToken))
                .andExpect(status().isOk());

        assertThat(invitationRepo.findById(invitationToDecline)).isEmpty();
    }
}
