package org.artso.budget_manager.group;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.group.dto.GroupRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@AllArgsConstructor
public class GroupController {
    private final GroupService service;

    @PostMapping("/group")
    public ResponseEntity<Void> createGroup(@RequestBody GroupRequest request, Authentication auth) {
        service.createGroup(request, auth);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping("/group")
    public ResponseEntity<List<UserGroup>> getAllGroups(Authentication auth) {
        return new ResponseEntity<>(service.getAll(auth), HttpStatus.OK);
    }
}