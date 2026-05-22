package org.artso.budget_manager.security.permissions;

import lombok.RequiredArgsConstructor;
import org.artso.budget_manager.item.dto.ItemRequest;
import org.artso.budget_manager.item.Item;
import org.artso.budget_manager.group.GroupRepo;
import org.artso.budget_manager.item.ItemRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component("itemAuth")
@RequiredArgsConstructor
public class ItemAuth {
    private final ItemRepo itemRepo;
    private final GroupRepo groupRepo;
    private final GroupAuth groupAuth;

    public boolean canCreate(Authentication auth, ItemRequest request) {
        if (auth == null || !auth.isAuthenticated() || request == null) {
            return false;
        }

        Set<Long> sharedGroupIds = request.sharedGroupIds();
        return sharedGroupIds == null || sharedGroupIds.isEmpty() || groupAuth.isMemberOfGroups(auth, sharedGroupIds);
    }

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
