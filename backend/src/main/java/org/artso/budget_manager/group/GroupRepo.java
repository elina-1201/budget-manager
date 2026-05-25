package org.artso.budget_manager.group;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface GroupRepo extends CrudRepository<UserGroup, Long> {
    boolean existsByName(String name);
    //TODO: decide which function to use byId or byName
    boolean existsByIdAndUsersEmailIgnoreCase(Long id, String email);
    boolean existsByNameAndUsersEmailIgnoreCase(String name, String email);
    List<UserGroup> findAllByUsersEmailIgnoreCase(String email);
}
