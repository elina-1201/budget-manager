package org.artso.budget_manager.expense.mapper;

import org.artso.budget_manager.expense.Expense;
import org.artso.budget_manager.expense.dto.ExpenseRequest;
import org.artso.budget_manager.common.mapper.GenericRequestToEntityMapper;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.mapstruct.ReportingPolicy;

@Mapper(
        componentModel = "spring",
        unmappedSourcePolicy = ReportingPolicy.IGNORE,
        unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL
)
public interface RequestToExpenseMapper extends GenericRequestToEntityMapper<ExpenseRequest, Expense> {
    void mapFromRequestToEntity(ExpenseRequest request, @MappingTarget Expense entity);
}
