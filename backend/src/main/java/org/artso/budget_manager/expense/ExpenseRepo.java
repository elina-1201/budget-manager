package org.artso.budget_manager.expense;

import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.group.UserGroup;
import org.springframework.data.repository.CrudRepository;

import java.util.List;
import java.util.Set;

public interface ExpenseRepo extends CrudRepository<Expense, Long> {
    List<Expense> findAllByAuthorOrSharedGroupsContaining(String email, Set<UserGroup> groups);
    List<Expense> findAllByAuthorOrderByDateDesc(AppUser author);
}
