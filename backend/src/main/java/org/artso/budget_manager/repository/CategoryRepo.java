package org.artso.budget_manager.repository;

import org.artso.budget_manager.dto.CategoryProjection;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CategoryRepo extends CrudRepository<Category, Long> {
     boolean existsByName(String name);
     List<CategoryProjection> findAllByOwner(AppUser owner);
}
