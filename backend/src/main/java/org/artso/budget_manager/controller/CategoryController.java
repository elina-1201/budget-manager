package org.artso.budget_manager.controller;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.service.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import java.util.Map;

@RestController
@RequestMapping("/category")
@AllArgsConstructor
public class CategoryController {
    private final CategoryService service;

    @PostMapping
    public ResponseEntity<?> addCategory(@RequestBody Map<String, String> categoryName, Authentication auth) {
        try {
            service.addCategory(categoryName.get("name"), auth);
            return new ResponseEntity<>(HttpStatus.CREATED);
        } catch (
                ResponseStatusException e) {
            return new ResponseEntity<>(e.getReason(), e.getStatusCode());
        }
    }
}
