package org.artso.budget_manager.service;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.dto.ItemDto;
import org.artso.budget_manager.dto.ItemRequest;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.entity.UserGroup;
import org.artso.budget_manager.entity.Item;
import org.artso.budget_manager.repository.AppUserRepo;
import org.artso.budget_manager.repository.CategoryRepo;
import org.artso.budget_manager.repository.GroupRepo;
import org.artso.budget_manager.repository.ItemRepo;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.Set;

@Service
@AllArgsConstructor
public class ItemService {
    private final ItemRepo repo;
    private final AppUserRepo userRepo;
    private final GroupRepo groupRepo;
    private final CategoryRepo categoryRepo;

//    TODO: refactor this to canCreate in ItemAuth
    @PreAuthorize("isAuthenticated() and (" +
            "#request.sharedGroupIds() == null or #request.sharedGroupIds().isEmpty() or " +
            "@groupAuth.isMemberOfGroups(authentication, #request.sharedGroupIds())" +
            ")"
    )
    public ItemDto createItem(ItemRequest request, Authentication auth) {
        Set<UserGroup> sharedGroups;

        AppUser author = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Category category = categoryRepo.findById(request.categoryId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category with id: " + request.categoryId() + " not found"));

        if(request.sharedGroupIds() == null || request.sharedGroupIds().isEmpty()) {
            sharedGroups = Collections.emptySet();
        }
        else {
            sharedGroups  = (Set<UserGroup>) groupRepo.findAllById(request.sharedGroupIds());
        }

        Item item = Item.builder()
                .name(request.name())
                .description(request.description())
                .amount(request.amount())
                .category(category.getName())
                .author(author)
                .sharedGroups(sharedGroups)
                .build();

        repo.save(item);
        return ItemDto.toDto(item);
    }

//    /**
//     * View an item (user must have access)
//     */
//    @PreAuthorize("@itemAuth.canAccess(authentication, #itemId)")
//    public Item getItem(Long itemId) {
//        return repo.findById(itemId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
//    }

//    /**
//     * Edit an item (only author can edit)
//     */
//    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId)")
//    public Item editItem(Long itemId, Item request) {
//        Item item = repo.findById(itemId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
//
//        item.setName(request.getName());
//        item.setCategory(request.getCategory());
//        item.setAmount(request.getAmount());
//        // Don't change author or shared groups here (separate endpoint for that)
//
//        return repo.save(item);
//    }

//    /**
//     * Delete an item (only author can delete)
//     */
//    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId)")
//    public void deleteItem(Long itemId) {
//        repo.deleteById(itemId);
//    }

    /**
     * Share an existing personal item to groups
     * Only author can do this
     */

    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId) and @groupAuth.isMemberOfGroups(authentication, #groupIds)")
    public Item shareItem(Long itemId, Set<Long> groupIds, Authentication auth) {
        Item item = repo.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Set<UserGroup> sharedGroups = (Set<UserGroup>) groupRepo.findAllById(groupIds);

        item.setSharedGroups(sharedGroups);
        return repo.save(item);
    }
}