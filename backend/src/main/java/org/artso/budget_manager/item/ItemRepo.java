package org.artso.budget_manager.item;

import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.group.UserGroup;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface ItemRepo extends CrudRepository<Item, Long> {
    List<Item> findAllByAuthorOrSharedGroupsContaining(String email, Set<UserGroup> groups);
    List<Item> findAllByAuthor(AppUser author);
}
