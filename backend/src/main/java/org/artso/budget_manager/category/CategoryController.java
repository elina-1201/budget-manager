package org.artso.budget_manager.category;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.category.dto.CategoryProjection;
import org.artso.budget_manager.category.dto.CategoryRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/category")
@AllArgsConstructor
public class CategoryController {
    private final CategoryService service;

    @PostMapping
    public ResponseEntity<Void> addCategory(@RequestBody @Valid CategoryRequest request, Authentication auth) {
        service.addCategory(request.name(), auth);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<CategoryProjection>> getCategories(Authentication auth) {
        return new ResponseEntity<>(service.getCategories(auth), HttpStatus.OK);
    }
}
