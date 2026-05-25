package org.artso.budget_manager.auth;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.ToString;
import lombok.EqualsAndHashCode;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.item.Item;

import java.util.List;
import java.util.Set;

@Data
@Entity
public class AppUser {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @NotBlank
    private String name;
    @Email
    private String email;
    @Size(min = 8)
    private String password;

    @OneToMany(mappedBy = "owner")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Category> categories;

    @ManyToMany(mappedBy = "users")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Set<UserGroup> groups;

    @OneToMany(mappedBy = "author")
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<Item> items;
}
