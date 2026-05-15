package org.artso.budget_manager.service;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.dto.CategoryProjection;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.repository.AppUserRepo;
import org.artso.budget_manager.repository.CategoryRepo;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@AllArgsConstructor
public class CategoryService {
    private final CategoryRepo categoryRepo;
    private final AppUserRepo userRepo;

    public void addCategory(String categoryName, Authentication auth) {
        AppUser owner = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        if(categoryRepo.existsByName(categoryName)) { throw new ResponseStatusException(HttpStatus.CONFLICT); }

        Category category = new Category();
        category.setName(categoryName.toLowerCase());
        category.setOwner(owner);

        categoryRepo.save(category);
    }

    public List<CategoryProjection> getCategories(Authentication auth) {
        AppUser owner = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));

        return categoryRepo.findAllByOwner(owner);
    }
}
