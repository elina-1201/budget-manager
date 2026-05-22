package org.artso.budget_manager.item;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.item.dto.ItemDto;
import org.artso.budget_manager.item.dto.ItemRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/item")
public class ItemController {
    private final ItemService service;

    @PostMapping
    public ResponseEntity<ItemDto> createItem(@RequestBody @Valid ItemRequest requestItem, Authentication auth) {
        ItemDto itemDto = service.createItem(requestItem, auth);
        return new ResponseEntity<>(itemDto, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<ItemDto>> getItems(Authentication auth) {
        return new ResponseEntity<>(service.getAllItems(auth), HttpStatus.OK);
    }
}
