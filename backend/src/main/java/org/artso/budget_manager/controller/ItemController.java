package org.artso.budget_manager.controller;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.entity.Item;
import org.artso.budget_manager.service.ItemService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.util.Set;

@RestController
@AllArgsConstructor
@RequestMapping("/item")
public class ItemController {
    private final ItemService service;

    @PostMapping
    public ResponseEntity<?> createItem(@RequestBody @Valid  ItemRequest requestItem, Authentication auth) {
        try {
            Item item = new Item();
            if(requestItem.sharedGroupIds().isEmpty()){
                item = service.createPersonalItem(requestItem, auth);
            } else {
                item = service.createSharedItem(requestItem, requestItem.sharedGroupIds(), auth);
            }
            return new ResponseEntity<>(item, HttpStatus.CREATED);
        } catch (ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }

    public record ItemRequest(@NotBlank String name,
                              String description,
                              @Min(0) BigDecimal amount,
                              Set<Long> sharedGroupIds,
                              Long categoryId
    ) {}
}
