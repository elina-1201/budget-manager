package org.artso.budget_manager.group;

import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.group.dto.GroupDto;
import org.artso.budget_manager.group.dto.GroupRequest;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class GroupService {
    final GroupRepo groupRepo;
    final AppUserService userService;

    @Transactional
    public void createGroup(GroupRequest request, Authentication auth) {
        if (groupRepo.existsByName(request.name())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT);
        }
        AppUser author = userService.requireUserByEmail(auth.getName());

        Set<AppUser> users = new HashSet<>();
        users.add(author);

        UserGroup group = new UserGroup();
        group.setName(request.name());
        group.setUsers(users);
        groupRepo.save(group);
    }

    public List<GroupDto> getAll(Authentication auth) {
        List<UserGroup> groups = groupRepo.findAllByUsersEmailIgnoreCase(auth.getName());
        return GroupDto.toDtoList(groups);
    }
}
