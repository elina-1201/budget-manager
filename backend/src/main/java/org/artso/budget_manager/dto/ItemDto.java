package org.artso.budget_manager.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.artso.budget_manager.entity.Item;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Getter
@Setter
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

    public static List<ItemDto> toDTOList(List<Item> items) {
        List<ItemDto> dtos = new ArrayList<>();
        items.forEach(item -> dtos.add(toDto(item)));
        return dtos;
    }
}
