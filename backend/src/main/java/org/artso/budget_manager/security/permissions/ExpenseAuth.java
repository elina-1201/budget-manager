package org.artso.budget_manager.security.permissions;

import lombok.RequiredArgsConstructor;
import org.artso.budget_manager.expense.dto.ExpenseRequest;
import org.artso.budget_manager.expense.Expense;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.expense.ExpenseRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component("expenseAuth")
@RequiredArgsConstructor
public class ExpenseAuth {
    private final ExpenseRepo expenseRepo;
    private final GroupRepo groupRepo;
    private final GroupAuth groupAuth;

    public boolean canCreate(Authentication auth, ExpenseRequest request) {
        if (auth == null || !auth.isAuthenticated() || request == null) {
            return false;
        }

        Set<Long> sharedGroupIds = request.sharedGroupIds();
        return sharedGroupIds == null || sharedGroupIds.isEmpty() || groupAuth.isMemberOfGroups(auth, sharedGroupIds);
    }

    public boolean canAccess(Authentication auth, Long itemId) {
        if (auth == null || !auth.isAuthenticated()) {
            return false;
        }

        Expense expense = expenseRepo.findById(itemId).orElse(null);
        if (expense == null) {
            return false;
        }

        String email = auth.getName().toLowerCase();

        // Own it? → access
        if (expense.getAuthor().getEmail().equalsIgnoreCase(email)) {
            return true;
        }

        // Shared to any of my groups?
        if (expense.getSharedGroups() != null && !expense.getSharedGroups().isEmpty()) {
            return expense.getSharedGroups().stream()
                .anyMatch(group -> groupRepo.existsByIdAndUsersEmailIgnoreCase(group.getId(), email));
        }

        return false;
    }

    public boolean canEdit(Authentication auth, Long itemId) {
        if (auth == null || !auth.isAuthenticated()) {
            return false;
        }

        Expense expense = expenseRepo.findById(itemId).orElse(null);
        if (expense == null) {
            return false;
        }

        return expense.getAuthor().getEmail().equalsIgnoreCase(auth.getName().toLowerCase());
    }
}
