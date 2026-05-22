package org.artso.budget_manager.group;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserRepo;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashSet;
import java.util.Set;

@Service
@AllArgsConstructor
public class GroupService {
    final GroupRepo groupRepo;
    final AppUserRepo userRepo;

    public void createGroup(UserGroup request, Authentication auth) {
        if (groupRepo.existsByName(request.getName())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT);
        } else {
            AppUser author = userRepo.findByEmail(auth.getName())
                    .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User with email: " + auth.getName() + " not found"));

            Set<AppUser> users = new HashSet<>();
            users.add(author);

            UserGroup group = new UserGroup();
            group.setName(request.getName());
            group.setUsers(users);
            groupRepo.save(group);
        }
    }
}
