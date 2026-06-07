package org.artso.budget_manager.invitation;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.invitation.dto.InvitationDto;
import org.artso.budget_manager.invitation.dto.InvitationRequest;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class InvitationService {
    final InvitationRepo repo;
    final AppUserService userService;
    final GroupRepo groupRepo;

    Invitation getInvitation(Long invitationId) {
        return repo.findById(invitationId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Invitation does not exist"));
    }

    void checkIfRecipient(Invitation invitation, String email) {
        if (!invitation.getRecipientEmail().equalsIgnoreCase(email)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "You are not the recipient of this invitation");
        }
    }

    @Transactional
    public void save(InvitationRequest invitationRequest, Authentication auth) {
        Long groupId = invitationRequest.groupId();
        UserGroup group = groupRepo.findById(groupId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Group does not exist"));

        String recipientEmail = userService.requireUserByEmail(invitationRequest.email()).getEmail();
        if (groupRepo.existsByIdAndUsersEmailIgnoreCase(groupId, recipientEmail)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "User is already in the group");
        }
        String senderEmail = userService.requireUserByEmail(auth.getName()).getEmail();

        if (repo.existsByRecipientEmailAndSenderEmail(recipientEmail, senderEmail)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Invitation already has been sent");
        }

        Invitation invitation = Invitation.builder()
                .recipientEmail(recipientEmail)
                .senderEmail(senderEmail)
                .group(group)
                .invitationDate(java.time.LocalDate.now())
                .build();

        repo.save(invitation);
    }

    public List<InvitationDto> getInvitationsByRecipientEmail(Authentication auth) {
        String email = auth.getName();
        List<Invitation> invitations = repo.findAllByRecipientEmailIgnoreCase(email);
        return InvitationDto.toDtoList(invitations);
    }

    @Transactional
    public void acceptInvitation(Long invitationId, Authentication auth) {
        AppUser user = userService.requireUserByEmail(auth.getName());
        Invitation invitation = getInvitation(invitationId);
        checkIfRecipient(invitation, user.getEmail());
        UserGroup updatedGroup = invitation.getGroup();
        Set<AppUser> groupUsers = updatedGroup.getUsers();
        groupUsers.add(user);
        updatedGroup.setUsers(groupUsers);
        groupRepo.save(updatedGroup);
        repo.delete(invitation);
    }

    public void declineInvitation(Long invitationId, Authentication auth) {
        String email = auth.getName();
        Invitation invitation = getInvitation(invitationId);
        checkIfRecipient(invitation, email);
        repo.delete(invitation);
    }
}
