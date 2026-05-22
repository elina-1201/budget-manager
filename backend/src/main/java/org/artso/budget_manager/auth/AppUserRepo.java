package org.artso.budget_manager.auth;

import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface AppUserRepo extends CrudRepository<AppUser, Long> {
     Optional<AppUser> findByEmail(String email);
     Boolean existsByEmail(String email);
}
