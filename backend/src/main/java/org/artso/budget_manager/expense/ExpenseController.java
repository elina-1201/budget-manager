package org.artso.budget_manager.expense;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.expense.dto.ExpenseDto;
import org.artso.budget_manager.expense.dto.ExpenseRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/expense")
public class ExpenseController {
    private final ExpenseService service;

    @PostMapping
    public ResponseEntity<ExpenseDto> createExpense(@RequestBody @Valid ExpenseRequest requestItem, Authentication auth) {
        ExpenseDto itemDto = service.createExpense(requestItem, auth);
        return new ResponseEntity<>(itemDto, HttpStatus.CREATED);
    }

    @GetMapping
    public ResponseEntity<List<ExpenseDto>> getExpenses(Authentication auth) {
        return new ResponseEntity<>(service.getAllExpenses(auth), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteExpense(@PathVariable Long id) {
        service.deleteExpense(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
