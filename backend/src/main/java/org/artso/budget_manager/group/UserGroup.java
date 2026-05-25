package org.artso.budget_manager.group;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.ToString;
import lombok.EqualsAndHashCode;
import org.artso.budget_manager.auth.AppUser;

import java.util.Locale;
import java.util.Set;

@Entity
@Data
public class UserGroup {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @NotBlank
    private String name;

    public String getName() {
        return name.toLowerCase(Locale.ROOT);
    }
    public void setName(String name) {
        this.name = name.toLowerCase(Locale.ROOT);
    }

    @ManyToMany
    @JoinTable(
            name = "groups",
            joinColumns = @JoinColumn(name = "group_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private Set<AppUser> users;
}
