package org.artso.budget_manager.service;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.controller.ItemController;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.entity.Group;
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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Set;

@Service
@AllArgsConstructor
public class ItemService {
    private final ItemRepo repo;
    private final AppUserRepo userRepo;
    private final GroupRepo groupRepo;
    private final CategoryRepo categoryRepo;

    @PreAuthorize("isAuthenticated()")
    public Item createPersonalItem(ItemController.ItemRequest request,
                                   Authentication auth) {

        AppUser author = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Category category = categoryRepo.findById(request.categoryId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category with id: " + request.categoryId() + " not found"));

        Item item = Item.builder()
                .name(request.name())
                .description(request.description())
                .amount(request.amount())
                .category(category)
                .author(author)
                .sharedGroups(Collections.emptySet())
                .build();
        return repo.save(item);
    }

    /**
     * Create an item and share it to one or more groups
     * User must be a member of all groups they're sharing to
     */
    @PreAuthorize("isAuthenticated() and @groupAuth.isMemberOfGroups(authentication, #groupIds)")
    public Item createSharedItem(ItemController.ItemRequest request, Set<Long> groupIds, Authentication auth) {
        AppUser author = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Set<Group> sharedGroups = (Set<Group>) groupRepo.findAllById(groupIds);
        Category category = categoryRepo.findById(request.categoryId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Category with id: " + request.categoryId() + " not found"));

        Item item = Item.builder()
                .name(request.name())
                .description(request.description())
                .amount(request.amount())
                .category(category)
                .author(author)
                .sharedGroups(sharedGroups)
                .build();


        return repo.save(item);
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

        Set<Group> sharedGroups = (Set<Group>) groupRepo.findAllById(groupIds);

        item.setSharedGroups(sharedGroups);
        return repo.save(item);
    }
}