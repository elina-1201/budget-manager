package org.artso.budget_manager.category;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.category.dto.CategoryProjection;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
@AllArgsConstructor
public class CategoryService {
    private final CategoryRepo categoryRepo;
    private final AppUserService userService;

    public void addCategory(String categoryName, Authentication auth) {
        AppUser owner = userService.requireUserByEmail(auth.getName());

        if(categoryRepo.existsByName(categoryName)) { throw new ResponseStatusException(HttpStatus.CONFLICT); }

        Category category = new Category();
        category.setName(categoryName.toLowerCase());
        category.setOwner(owner);

        categoryRepo.save(category);
    }

    public List<CategoryProjection> getCategories(Authentication auth) {
        AppUser owner = userService.requireUserByEmail(auth.getName());

        return categoryRepo.findAllByOwner(owner);
    }
}
