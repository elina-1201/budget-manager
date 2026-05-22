package org.artso.budget_manager.group;

import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
public class   GroupController {
    private final GroupService service;

    @PostMapping("/group")
    public ResponseEntity<UserGroup> createGroup(UserGroup request, Authentication auth) {
        service.createGroup(request, auth);
        return new ResponseEntity<>(request, HttpStatus.CREATED);
    }
}
