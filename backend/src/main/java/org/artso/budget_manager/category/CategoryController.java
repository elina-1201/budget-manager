package org.artso.budget_manager.category;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.category.dto.CategoryProjection;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/category")
@AllArgsConstructor
public class CategoryController {
    private final CategoryService service;

    @PostMapping
    public ResponseEntity<Void> addCategory(@RequestBody Map<String, String> categoryName, Authentication auth) {
        service.addCategory(categoryName.get("name"), auth);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<CategoryProjection>> getCategories(Authentication auth) {
        return new ResponseEntity<>(service.getCategories(auth), HttpStatus.OK);
    }
}
