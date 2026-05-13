package org.artso.budget_manager.service;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.repository.AppUserRepo;
import org.artso.budget_manager.repository.CategoryRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class CategoryService {
    private final CategoryRepo repository;
    private final AppUserRepo userRepo;

    public void addCategory(String categoryName, Authentication auth) {
        AppUser owner = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new RuntimeException("User not found"));
        Category category = new Category();
        category.setName(categoryName.toLowerCase());
        category.setOwner(owner);

        repository.save(category);
    }
}
