package org.artso.budget_manager.invitation;

import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.invitation.dto.InvitationRequest;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@SpringBootTest
@DisplayName("Invitation Service Edge Case Tests")
class InvitationServiceTest {
    @MockitoBean
    private InvitationRepo invitationRepo;

    @MockitoBean
    private AppUserService userService;

    @MockitoBean
    private GroupRepo groupRepo;

    @Autowired
    private InvitationService invitationService;

    @Test
    @DisplayName("Should reject invitation creation when recipient is already in the group")
    void save_whenRecipientAlreadyInGroup_throwsConflict() {
        Authentication auth = auth("sender@example.com");

        UserGroup group = new UserGroup();
        group.setName("team");
        group.setUsers(Collections.emptySet());

        AppUser recipient = new AppUser();
        recipient.setEmail("recipient@example.com");

        when(groupRepo.findById(7L)).thenReturn(Optional.of(group));
        when(userService.requireUserByEmail("recipient@example.com")).thenReturn(recipient);
        when(groupRepo.existsByIdAndUsersEmailIgnoreCase(7L, "recipient@example.com")).thenReturn(true);

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> invitationService.save(new InvitationRequest("recipient@example.com", 7L), auth));

        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(ex.getReason()).isEqualTo("User is already in the group");
        verify(invitationRepo, never()).save(any());
        verifyNoInteractions(invitationRepo);
        verify(groupRepo, never()).save(any());
    }

    @Test
    @DisplayName("Should reject invitation creation when the invitation was already sent")
    void save_whenInvitationAlreadySent_throwsConflict() {
        Authentication auth = auth("sender@example.com");

        UserGroup group = new UserGroup();
        group.setName("team");
        group.setUsers(Collections.emptySet());

        AppUser sender = new AppUser();
        sender.setEmail("sender@example.com");

        AppUser recipient = new AppUser();
        recipient.setEmail("recipient@example.com");

        when(groupRepo.findById(7L)).thenReturn(Optional.of(group));
        when(userService.requireUserByEmail("recipient@example.com")).thenReturn(recipient);
        when(groupRepo.existsByIdAndUsersEmailIgnoreCase(7L, "recipient@example.com")).thenReturn(false);
        when(userService.requireUserByEmail("sender@example.com")).thenReturn(sender);
        when(invitationRepo.existsByRecipientEmailAndSenderEmail("recipient@example.com", "sender@example.com"))
                .thenReturn(true);

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> invitationService.save(new InvitationRequest("recipient@example.com", 7L), auth));

        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(ex.getReason()).isEqualTo("Invitation already has been sent");
        verify(invitationRepo, never()).save(any());
        verify(groupRepo, never()).save(any());
    }

    @Test
    @DisplayName("Should reject acceptance when authenticated user is not the recipient")
    void acceptInvitation_whenWrongRecipient_throwsForbidden() {
        Authentication auth = auth("other@example.com");

        AppUser authUser = new AppUser();
        authUser.setEmail("other@example.com");

        Invitation invitation = new Invitation();
        invitation.setId(11L);
        invitation.setRecipientEmail("recipient@example.com");
        UserGroup group = new UserGroup();
        group.setName("team");
        group.setUsers(Collections.emptySet());
        invitation.setGroup(group);

        when(userService.requireUserByEmail("other@example.com")).thenReturn(authUser);
        when(invitationRepo.findById(11L)).thenReturn(Optional.of(invitation));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> invitationService.acceptInvitation(11L, auth));

        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(ex.getReason()).isEqualTo("You are not the recipient of this invitation");
        verify(groupRepo, never()).save(any());
        verify(invitationRepo, never()).delete(any());
    }

    @Test
    @DisplayName("Should reject decline when authenticated user is not the recipient")
    void declineInvitation_whenWrongRecipient_throwsForbidden() {
        Authentication auth = auth("other@example.com");

        Invitation invitation = new Invitation();
        invitation.setId(12L);
        invitation.setRecipientEmail("recipient@example.com");

        when(invitationRepo.findById(12L)).thenReturn(Optional.of(invitation));

        ResponseStatusException ex = assertThrows(ResponseStatusException.class,
                () -> invitationService.declineInvitation(12L, auth));

        assertThat(ex.getStatusCode()).isEqualTo(HttpStatus.FORBIDDEN);
        assertThat(ex.getReason()).isEqualTo("You are not the recipient of this invitation");
        verify(invitationRepo, never()).delete(any());
        verifyNoInteractions(userService, groupRepo);
    }

    private Authentication auth(String email) {
        return new UsernamePasswordAuthenticationToken(email, "password");
    }
}


