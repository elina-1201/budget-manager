package org.artso.budget_manager.repository;

import org.artso.budget_manager.entity.UserGroup;
import org.springframework.data.repository.CrudRepository;

public interface GroupRepo extends CrudRepository<UserGroup, Long> {
    boolean existsByName(String name);
    boolean existsByIdAndUsersEmailIgnoreCase(Long id, String email);
}
