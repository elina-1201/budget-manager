package org.artso.budget_manager.expense;

import org.artso.budget_manager.expense.dto.ExpenseDto;
import org.artso.budget_manager.expense.dto.ExpenseRequest;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.category.CategoryRepo;
import org.artso.budget_manager.group.GroupRepo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
class ExpenseServiceTest {
    @MockitoBean
    private ExpenseRepo repo;

    @MockitoBean
    private AppUserService userService;

    @MockitoBean
    private CategoryRepo categoryRepo;

    @MockitoBean
    private GroupRepo groupRepo;

    @Autowired
    private ExpenseService expenseService;

    @Test
    @WithMockUser(username = "user@example.com")
    @DisplayName("Should return expected ExpenseDto when given valid request and authenticated user")
    void createExpense_returnsExpectedDto() {
        Authentication auth = new UsernamePasswordAuthenticationToken("user@example.com", "password");

        AppUser author = new AppUser();
        author.setEmail("user@example.com");
        when(userService.requireUserByEmail("user@example.com")).thenReturn(author);

        Category category = new Category();
        category.setName("Food");
        when(categoryRepo.findById(7L)).thenReturn(Optional.of(category));

        when(repo.save(any(Expense.class))).thenAnswer(invocation -> {
            Expense expense = invocation.getArgument(0);
            expense.setId(42L);
            return expense;
        });

        ExpenseRequest request = new ExpenseRequest(
                "Lunch",
                "Team lunch",
                new BigDecimal("12.50"),
                Collections.emptySet(),
                7L,
                LocalDate.now().minusDays(1)
        );

        ExpenseDto result = expenseService.createExpense(request, auth);

        assertAll(
                () -> assertEquals(42L, result.getId()),
                () -> assertEquals("Lunch", result.getName()),
                () -> assertEquals("Team lunch", result.getDescription()),
                () -> assertEquals(new BigDecimal("12.50"), result.getAmount()),
                () -> assertEquals("Food", result.getCategory())
        );
    }
}
