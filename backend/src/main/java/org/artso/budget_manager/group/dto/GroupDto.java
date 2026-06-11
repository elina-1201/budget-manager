package org.artso.budget_manager.group.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.category.dto.CategoryProjection;
import org.artso.budget_manager.group.UserGroup;

import java.util.List;
import java.util.Set;

@Getter
@Setter
@AllArgsConstructor
public class GroupDto {
    private Long id;
    private String name;
    private List<CategoryUser> users;

    public static GroupDto toDto(UserGroup group) {
        List<CategoryUser> users = CategoryUser.toDtoList(group.getUsers());
        return new GroupDto(
                group.getId(),
                group.getName(),
                users
        );
    }

    public static List<GroupDto> toDtoList(List<UserGroup> groups) {
        return groups.stream().map(GroupDto::toDto).toList();
    }
}

@Getter
@Setter
@AllArgsConstructor
class CategoryUser {
    private String name;
    private List<CategoryProjectionImpl> category;

    private record CategoryProjectionImpl(Long id, String name) implements CategoryProjection {
        public Long getId() { return id; }
        public String getName() { return name; }
    }


    public static CategoryUser toDto(AppUser user) {
        List<CategoryProjectionImpl> categories = user.getCategories().stream()
                .map(c -> new CategoryProjectionImpl(c.getId(), c.getName()))
                .toList();

        return new CategoryUser(
                user.getName(),
                categories
        );
    }

    public static List<CategoryUser> toDtoList(Set<AppUser> users) {
        return users.stream().map(CategoryUser::toDto).toList();
    }
}
