package org.artso.budget_manager.controller;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.dto.ItemDto;
import org.artso.budget_manager.dto.ItemRequest;
import org.artso.budget_manager.service.ItemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@AllArgsConstructor
@RequestMapping("/item")
public class ItemController {
    private final ItemService service;

    @PostMapping
    public ResponseEntity<?> createItem(@RequestBody @Valid ItemRequest requestItem, Authentication auth) {
        try {
            ItemDto itemDto = service.createItem(requestItem, auth);
            return new ResponseEntity<>(itemDto, HttpStatus.CREATED);
        } catch (ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }

    @GetMapping
    public ResponseEntity<?> getItems(Authentication auth) {
        try {
            return new ResponseEntity<>(service.getPrivateItems(auth), HttpStatus.OK);
        } catch (ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }
}
