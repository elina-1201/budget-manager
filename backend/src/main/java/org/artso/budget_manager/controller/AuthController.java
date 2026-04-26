package org.artso.budget_manager.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.service.AppUserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@AllArgsConstructor
public class AuthController {
    final AppUserService service;

    @PostMapping("/register")
    ResponseEntity<?> registerUser(@Valid @RequestBody AppUser appUser) {
        try {
            service.addUser(appUser);
            return new ResponseEntity<>(appUser, HttpStatus.CREATED);
        } catch (ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }
}
