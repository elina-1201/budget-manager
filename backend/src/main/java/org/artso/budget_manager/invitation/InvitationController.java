package org.artso.budget_manager.invitation;

import lombok.AllArgsConstructor;
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
    public ResponseEntity<Invitation> createInvite(@RequestBody InvitationRequest request, Authentication auth) {
        return new ResponseEntity<>(service.save(request, auth), HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<Invitation>> getInvitations(Authentication auth) {
        return new ResponseEntity<>(service.getInvitationsByRecipientEmail(auth), HttpStatus.OK);
    }
}

