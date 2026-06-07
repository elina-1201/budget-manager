package org.artso.budget_manager.invitation;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.invitation.dto.InvitationDto;
import org.artso.budget_manager.invitation.dto.InvitationRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/invitation")
public class InvitationController {
    private InvitationService service;

    @PostMapping
    public ResponseEntity<Void> createInvite(@RequestBody InvitationRequest request, Authentication auth) {
        service.save(request, auth);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<InvitationDto>> getInvitations(Authentication auth) {
        return new ResponseEntity<>(service.getInvitationsByRecipientEmail(auth), HttpStatus.OK);
    }

    @PostMapping("/{id}/accept")
    public ResponseEntity<Void> acceptInvitation(@PathVariable Long id, Authentication auth) {
        service.acceptInvitation(id, auth);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @PostMapping("/{id}/decline")
    public ResponseEntity<Void> declineInvitation(@PathVariable Long id, Authentication auth) {
        service.declineInvitation(id, auth);
        return new ResponseEntity<>(HttpStatus.OK);
    }
}

