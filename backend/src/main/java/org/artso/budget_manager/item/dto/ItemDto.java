package org.artso.budget_manager.item.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.artso.budget_manager.item.Item;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
public class ItemDto {
    private Long id;
    private String name;
    private String description;
    private BigDecimal amount;
    private String category;

    public static ItemDto toDto(Item item) {
        return new ItemDto(
                item.getId(),
                item.getName(),
                item.getDescription(),
                item.getAmount(),
                item.getCategory()
        );
    }

    public static List<ItemDto> toDtoList(List<Item> items) {
        return items.stream().map(ItemDto::toDto).toList();
    }
}
