package org.artso.budget_manager.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

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
        return name.toUpperCase(Locale.ROOT);
    }
    public void setName(String name) {
        this.name = name.toUpperCase(Locale.ROOT);
    }

    @ManyToMany(mappedBy = "groups")
    private Set<AppUser> users;
}
