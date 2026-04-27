package org.artso.budget_manager.repository;

import org.artso.budget_manager.entity.Group;
import org.springframework.data.repository.CrudRepository;

public interface GroupRepo extends CrudRepository<Group, Long> {
    boolean existsByName(String name);
}
