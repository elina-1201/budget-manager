package org.artso.budget_manager.group;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

@RestController
@AllArgsConstructor
public class   GroupController {
    private final GroupService service;

    @PostMapping("/group")
    public ResponseEntity<?> createGroup(UserGroup request, Authentication auth) {
        try {
            service.createGroup(request, auth);
            return new ResponseEntity<>(request, HttpStatus.CREATED);
        } catch (
                ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }
}
