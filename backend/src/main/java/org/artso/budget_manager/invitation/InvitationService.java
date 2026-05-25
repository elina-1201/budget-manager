package org.artso.budget_manager.invitation;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.invitation.dto.InvitationRequest;
import org.artso.budget_manager.invitation.enums.InvintationStatus;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@AllArgsConstructor
public class InvitationService {
    final InvitationRepo repo;
    final AppUserService userService;
    final GroupRepo groupRepo;

     @Transactional
     public Invitation save(InvitationRequest invitationRequest, Authentication auth) {
         String senderEmail = userService.requireUserByEmail(auth.getName()).getEmail();
         String group = invitationRequest.group().toLowerCase();
         if(!groupRepo.existsByNameAndUsersEmailIgnoreCase(group, senderEmail)) {
             throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Group does not exist");
         }

         String recipientEmail = userService.requireUserByEmail(invitationRequest.email()).getEmail();

         if(repo.existsByRecipientEmailAndSenderEmail(recipientEmail, senderEmail)) {
             throw new ResponseStatusException(HttpStatus.CONFLICT, "Invitation already has been sent");
         }

         Invitation invitation = Invitation.builder()
                 .recipientEmail(recipientEmail)
                 .senderEmail(senderEmail)
                 .group(group)
                 .invitationDate(java.time.LocalDate.now())
                 .status(InvintationStatus.PENDING)
                 .build();

        return repo.save(invitation);
    }

    public List<Invitation> getInvitationsByRecipientEmail(Authentication auth) {
        String email = auth.getName();
        return repo.findAllByRecipientEmailIgnoreCase(email);
    }
}
