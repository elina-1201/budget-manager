package org.artso.budget_manager.repository;

import org.artso.budget_manager.entity.Group;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface GroupRepo extends CrudRepository<Group, Long> {
    boolean existsByName(String name);
    boolean existsByIdAndUsersEmailIgnoreCase(Long id, String email);
}
