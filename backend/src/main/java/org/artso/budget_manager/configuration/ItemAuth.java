package org.artso.budget_manager.configuration;

import lombok.RequiredArgsConstructor;
import org.artso.budget_manager.entity.Item;
import org.artso.budget_manager.repository.GroupRepo;
import org.artso.budget_manager.repository.ItemRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component("itemAuth")
@RequiredArgsConstructor
public class ItemAuth {
    private final ItemRepo itemRepo;
    private final GroupRepo groupRepo;

    public boolean canAccess(Authentication auth, Long itemId) {
        if (auth == null || !auth.isAuthenticated()) {
            return false;
        }

        Item item = itemRepo.findById(itemId).orElse(null);
        if (item == null) {
            return false;
        }

        String email = auth.getName().toLowerCase();

        // Own it? → access
        if (item.getAuthor().getEmail().equalsIgnoreCase(email)) {
            return true;
        }

        // Shared to any of my groups?
        if (item.getSharedGroups() != null && !item.getSharedGroups().isEmpty()) {
            return item.getSharedGroups().stream()
                .anyMatch(group -> groupRepo.existsByIdAndUsersEmailIgnoreCase(group.getId(), email));
        }

        return false;
    }

    /**
     * Can user edit/delete this item?
     * Only if they are the author
     */
    public boolean canEdit(Authentication auth, Long itemId) {
        if (auth == null || !auth.isAuthenticated()) {
            return false;
        }

        Item item = itemRepo.findById(itemId).orElse(null);
        if (item == null) {
            return false;
        }

        return item.getAuthor().getEmail().equalsIgnoreCase(auth.getName().toLowerCase());
    }
}
