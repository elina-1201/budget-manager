package org.artso.budget_manager.expense.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.artso.budget_manager.expense.Expense;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class ExpenseDto {
    private Long id;
    private String name;
    private String description;
    private BigDecimal amount;
    private String category;
    private LocalDate date;

    public static ExpenseDto toDto(Expense expense) {
        return new ExpenseDto(
                expense.getId(),
                expense.getName(),
                expense.getDescription(),
                expense.getAmount(),
                expense.getCategory(),
                expense.getDate()
        );
    }

    public static List<ExpenseDto> toDtoList(List<Expense> expenses) {
        return expenses.stream().map(ExpenseDto::toDto).toList();
    }
}
