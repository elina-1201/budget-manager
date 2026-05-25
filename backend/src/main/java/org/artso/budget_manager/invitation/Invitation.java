package org.artso.budget_manager.invitation;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.artso.budget_manager.invitation.enums.InvintationStatus;
import java.time.LocalDate;

@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor()
public class Invitation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank
    @Email
    private String recipientEmail;
    @NotBlank
    @Email
    private String senderEmail;
    @NotBlank
    @Column(name = "group_name")
    private String group;

    @JsonFormat(pattern = "MM/dd/yyyy")
    private LocalDate invitationDate;
    @Enumerated(EnumType.STRING)
    private InvintationStatus status;
}
