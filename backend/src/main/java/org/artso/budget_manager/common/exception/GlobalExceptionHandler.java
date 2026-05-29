package org.artso.budget_manager.common.exception;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.server.ResponseStatusException;

//TODO: add handler for all Exceptions
@RestControllerAdvice
@SuppressWarnings("unused")
public class GlobalExceptionHandler {

    public record ErrorResponse(String message) {}

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationExceptions(MethodArgumentNotValidException exception) {
        return new ResponseEntity<>(new ErrorResponse(resolveValidationMessage(exception)), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<ErrorResponse> handleResponseStatusException(ResponseStatusException exception) {
        var status = exception.getStatusCode();
        return ResponseEntity.status(status).body(new ErrorResponse(resolveMessage(exception)));
    }

    @ExceptionHandler(JwtException.class)
    public ResponseEntity<ErrorResponse> handleJwtException(JwtException exception) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new ErrorResponse("Invalid token"));
    }

    private String resolveMessage(ResponseStatusException exception) {
        return Objects.requireNonNullElse(exception.getReason(), exception.getStatusCode().toString());
    }

    private String resolveValidationMessage(MethodArgumentNotValidException exception) {
        List<FieldError> fieldErrors = exception.getBindingResult().getFieldErrors();

        if (fieldErrors.isEmpty()) {
            return "Invalid input data";
        }

        return fieldErrors.stream()
                .map(fieldError -> fieldError.getField() + ": " +
                        Objects.requireNonNullElse(fieldError.getDefaultMessage(), "invalid value"))
                .collect(Collectors.joining("; "));
    }
}

