package org.artso.budget_manager.item;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.item.dto.ItemDto;
import org.artso.budget_manager.item.dto.ItemRequest;
import org.artso.budget_manager.auth.AppUser;
import org.artso.budget_manager.category.Category;
import org.artso.budget_manager.group.UserGroup;
import org.artso.budget_manager.item.mapper.RequestItemToEntityMapper;
import org.artso.budget_manager.auth.AppUserService;
import org.artso.budget_manager.category.CategoryRepo;
import org.artso.budget_manager.group.GroupRepo;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.List;
import java.util.Set;

@Service
@AllArgsConstructor
public class ItemService {
    private final ItemRepo itemRepo;
    private final AppUserService userService;
    private final GroupRepo groupRepo;
    private final CategoryRepo categoryRepo;
    private final RequestItemToEntityMapper requestToEntityMapper;

    @PreAuthorize("@itemAuth.canCreate(authentication, #request)")
    @Transactional
    public ItemDto createItem(ItemRequest request, Authentication auth) {
        Set<UserGroup> sharedGroups;

        AppUser author = userService.requireUserByEmail(auth.getName());

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

    public List<ItemDto> getAllItems(Authentication auth) {
        AppUser user = userService.requireUserByEmail(auth.getName());

        List<Item> items = itemRepo.findAllByAuthor(user);
        return ItemDto.toDtoList(items);
    }

    @PreAuthorize("@itemAuth.canEdit(authentication, #itemId) and @groupAuth.isMemberOfGroups(authentication, #groupIds)")
    @Transactional
    public Item shareItem(Long itemId, Set<Long> groupIds) {
        Item item = itemRepo.findById(itemId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        Set<UserGroup> sharedGroups = (Set<UserGroup>) groupRepo.findAllById(groupIds);

        item.setSharedGroups(sharedGroups);
        return itemRepo.save(item);
    }
}