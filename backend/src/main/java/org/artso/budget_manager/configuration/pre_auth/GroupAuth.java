package org.artso.budget_manager.configuration.pre_auth;

import lombok.RequiredArgsConstructor;
import org.artso.budget_manager.repository.GroupRepo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component("groupAuth")
@RequiredArgsConstructor
public class GroupAuth {
    private final GroupRepo groupRepo;

    public boolean isGroupMember(Authentication auth, Long groupId) {
        if(auth == null || !auth.isAuthenticated()) {
            return false;
        }
        String email = auth.getName().toLowerCase();
        return groupRepo.existsByIdAndUsersEmailIgnoreCase(groupId, email);
    }

    public boolean isMemberOfGroups(Authentication auth, Set<Long> groupIds) {
        if(auth == null || !auth.isAuthenticated()) {
            return false;
        }
        for(Long groupId : groupIds) {
            if(!isGroupMember(auth, groupId)) {
                return false;
            }
        }
        return true;
    }
}
