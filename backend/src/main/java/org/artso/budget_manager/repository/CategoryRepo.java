package org.artso.budget_manager.repository;

import org.artso.budget_manager.entity.Category;
import org.springframework.data.repository.CrudRepository;

public interface CategoryRepo extends CrudRepository<Category, Long> {
     boolean existsByName(String name);
//     boolean existsByIdAndGroupsUsersEmailIgnoreCase(Long id, String email);
}
