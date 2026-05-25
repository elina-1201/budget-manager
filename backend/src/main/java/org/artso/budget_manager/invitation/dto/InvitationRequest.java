package org.artso.budget_manager.invitation.dto;

import jakarta.validation.constraints.NotBlank;

public record InvitationRequest(
        @NotBlank String email,
        @NotBlank String group
){}
