package org.artso.budget_manager.item;

import org.artso.budget_manager.item.dto.ItemDto;
import org.artso.budget_manager.item.dto.ItemRequest;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.category.CategoryRepo;
import org.artso.budget_manager.group.GroupRepo;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.security.core.Authentication;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertAll;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@SpringBootTest
class ItemServiceTest {
    @MockitoBean
    private ItemRepo repo;

    @MockitoBean
    private AppUserService userService;

    @MockitoBean
    private CategoryRepo categoryRepo;

    @Autowired
    private ItemService itemService;

    @Test
    @WithMockUser(username = "user@example.com")
    @DisplayName("Should return expected ItemDto when given valid request and authenticated user")
    void createItem_returnsExpectedDto() {
        Authentication auth = new UsernamePasswordAuthenticationToken("user@example.com", "password");

        AppUser author = new AppUser();
        author.setEmail("user@example.com");
        when(userService.requireUserByEmail("user@example.com")).thenReturn(author);

        Category category = new Category();
        category.setName("Food");
        when(categoryRepo.findById(7L)).thenReturn(Optional.of(category));

        when(repo.save(any(Item.class))).thenAnswer(invocation -> {
            Item item = invocation.getArgument(0);
            item.setId(42L);
            return item;
        });

        ItemRequest request = new ItemRequest(
                "Lunch",
                "Team lunch",
                new BigDecimal("12.50"),
                Collections.emptySet(),
                7L
        );

        ItemDto result = itemService.createItem(request, auth);

        assertAll(
                () -> assertEquals(42L, result.getId()),
                () -> assertEquals("Lunch", result.getName()),
                () -> assertEquals("Team lunch", result.getDescription()),
                () -> assertEquals(new BigDecimal("12.50"), result.getAmount()),
                () -> assertEquals("Food", result.getCategory())
        );
    }

    @MockitoBean
    private GroupRepo groupRepo;
}
