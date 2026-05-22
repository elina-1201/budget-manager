package org.artso.budget_manager.category;

import org.artso.budget_manager.category.dto.CategoryProjection;
import org.artso.budget_manager.auth.AppUser;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CategoryRepo extends CrudRepository<Category, Long> {
     boolean existsByName(String name);
     List<CategoryProjection> findAllByOwner(AppUser owner);
}
