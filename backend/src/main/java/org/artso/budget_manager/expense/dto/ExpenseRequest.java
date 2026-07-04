package org.artso.budget_manager.expense.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Set;

public record ExpenseRequest(@NotBlank String name,
                             String description,
                             @Min(0) BigDecimal amount,
                             Set<Long> sharedGroupIds,
                             Long categoryId,
                             LocalDate date
) {}
