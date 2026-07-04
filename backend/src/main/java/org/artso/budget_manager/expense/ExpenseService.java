package org.artso.budget_manager.expense;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.expense.dto.ExpenseDto;
import org.artso.budget_manager.expense.dto.ExpenseRequest;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.expense.mapper.RequestToExpenseMapper;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.category.CategoryRepo;
import org.artso.budget_manager.group.GroupRepo;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class ExpenseService {
    private final ExpenseRepo expenseRepo;
    private final AppUserService userService;
    private final GroupRepo groupRepo;
    private final CategoryRepo categoryRepo;
    private final RequestToExpenseMapper requestToEntityMapper;

    @PreAuthorize("@expenseAuth.canCreate(authentication, #request)")
    @Transactional
    public ExpenseDto createExpense(ExpenseRequest request, Authentication auth) {
        Set<UserGroup> sharedGroups;

        AppUser author = userService.requireUserByEmail(auth.getName());

        Category category = categoryRepo.findById(request.categoryId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category with id: " + request.categoryId() + " not found"));

        if (request.sharedGroupIds() == null || request.sharedGroupIds().isEmpty()) {
            sharedGroups = Collections.emptySet();
        } else {
            sharedGroups = (Set<UserGroup>) groupRepo.findAllById(request.sharedGroupIds());
        }
        Expense expense = new Expense();
        requestToEntityMapper.mapFromRequestToEntity(request, expense);
        expense.setAuthor(author);
        expense.setCategory(category.getName());
        expense.setSharedGroups(sharedGroups);

        expenseRepo.save(expense);
        return ExpenseDto.toDto(expense);
    }

    public List<ExpenseDto> getAllExpenses(Authentication auth) {
        AppUser user = userService.requireUserByEmail(auth.getName());

        List<Expense> expenses = expenseRepo.findAllByAuthorOrderByDateDesc(user);
        return ExpenseDto.toDtoList(expenses);
    }

    @PreAuthorize("@expenseAuth.canEdit(authentication, #itemId) and @groupAuth.isMemberOfGroups(authentication, #groupIds)")
    @Transactional
    public Expense shareExpense(Long itemId, Set<Long> groupIds) {
        Expense expense = expenseRepo.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Set<UserGroup> sharedGroups = (Set<UserGroup>) groupRepo.findAllById(groupIds);

        expense.setSharedGroups(sharedGroups);
        return expenseRepo.save(expense);
    }

    @PreAuthorize("@expenseAuth.canEdit(authentication, #itemId)")
    public void deleteExpense(Long itemId) {
        Expense expense = expenseRepo.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
        expenseRepo.delete(expense);
    }
}