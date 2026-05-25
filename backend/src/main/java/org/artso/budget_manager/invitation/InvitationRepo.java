package org.artso.budget_manager.invitation;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface InvitationRepo extends CrudRepository<Invitation, Long> {
    boolean existsByRecipientEmailAndSenderEmail(String recipientEmail, String senderEmail);
    List<Invitation> findAllByRecipientEmailIgnoreCase(String recipientEmail);
}
