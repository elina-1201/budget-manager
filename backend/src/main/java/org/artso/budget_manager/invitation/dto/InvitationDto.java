package org.artso.budget_manager.invitation.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.invitation.Invitation;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class InvitationDto {
    private Long id;
    private String recipientEmail;
    private String senderEmail;
    @JsonFormat(pattern = "MM/dd/yyyy")
    private LocalDate invitationDate;
    private String groupName;
    private List<String> groupMembers;

    //TODO: see if there are too many queries and refactor with projections if needed
    public static InvitationDto toDto(Invitation invitation) {
        return new InvitationDto(
                invitation.getId(),
                invitation.getRecipientEmail(),
                invitation.getSenderEmail(),
                invitation.getInvitationDate(),
                invitation.getGroup().getName(),
                invitation.getGroup().getUsers()
                        .stream().map(AppUser::getName)
                        .toList()
        );
    }

    public static List<InvitationDto> toDtoList(List<Invitation> invitations) {
        return invitations.stream().map(InvitationDto::toDto).toList();
    }
}
