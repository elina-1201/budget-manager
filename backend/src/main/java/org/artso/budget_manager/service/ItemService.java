package org.artso.budget_manager.service;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.dto.ItemDto;
import org.artso.budget_manager.dto.ItemRequest;
import org.artso.budget_manager.entity.AppUser;
import org.artso.budget_manager.entity.Category;
import org.artso.budget_manager.entity.UserGroup;
import org.artso.budget_manager.entity.Item;
import org.artso.budget_manager.mapper.RequestItemToEntityMapper;
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
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class ItemService {
    private final ItemRepo itemRepo;
    private final AppUserRepo userRepo;
    private final GroupRepo groupRepo;
    private final CategoryRepo categoryRepo;
    private final RequestItemToEntityMapper requestToEntityMapper;

    @PreAuthorize("@itemAuth.canCreate(authentication, #request)")
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
        Item item = new Item();
        requestToEntityMapper.mapFromRequestToEntity(request, item);
        item.setAuthor(author);
        item.setCategory(category.getName());
        item.setSharedGroups(sharedGroups);

        itemRepo.save(item);
        return ItemDto.toDto(item);
    }

    public List<ItemDto> getPrivateItems(Authentication auth) {
        AppUser user = userRepo.findByEmail(auth.getName().toLowerCase())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        List<Item> items = itemRepo.findAllByAuthor(user);
        return ItemDto.toDTOList(items);
    }

//    /**
//     * View an item (user must have access)
//     */
//    @PreAuthorize("@itemAuth.canAccess(authentication, #itemId)")
//    public Item getItem(Long itemId) {
//        return itemRepo.findById(itemId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
//    }

//    /**
//     * Edit an item (only author can edit)
//     */
//    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId)")
//    public Item editItem(Long itemId, Item request) {
//        Item item = itemRepo.findById(itemId)
//            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
//
//        item.setName(request.getName());
//        item.setCategory(request.getCategory());
//        item.setAmount(request.getAmount());
//        // Don't change author or shared groups here (separate endpoint for that)
//
//        return itemRepo.save(item);
//    }

//    /**
//     * Delete an item (only author can delete)
//     */
//    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId)")
//    public void deleteItem(Long itemId) {
//        itemRepo.deleteById(itemId);
//    }

    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId) and @groupAuth.isMemberOfGroups(authentication, #groupIds)")
    public Item shareItem(Long itemId, Set<Long> groupIds) {
        Item item = itemRepo.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Set<UserGroup> sharedGroups = (Set<UserGroup>) groupRepo.findAllById(groupIds);

        item.setSharedGroups(sharedGroups);
        return itemRepo.save(item);
    }
}