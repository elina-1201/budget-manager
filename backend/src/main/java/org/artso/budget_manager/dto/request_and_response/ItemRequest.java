package org.artso.budget_manager.dto.request_and_response;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

import java.math.BigDecimal;
import java.util.Set;

public record ItemRequest(@NotBlank String name,
                          String description,
                          @Min(0) BigDecimal amount,
                          Set<Long> sharedGroupIds,
                          Long categoryId
) {}
