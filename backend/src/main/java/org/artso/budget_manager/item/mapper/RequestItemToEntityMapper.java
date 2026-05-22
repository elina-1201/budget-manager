package org.artso.budget_manager.item.mapper;

import org.artso.budget_manager.item.dto.ItemRequest;
import org.artso.budget_manager.item.Item;
import org.artso.budget_manager.common.mapper.GenericRequestToEntityMapper;
import org.mapstruct.Mapper;
import org.mapstruct.MappingTarget;
import org.mapstruct.NullValuePropertyMappingStrategy;
import org.mapstruct.ReportingPolicy;

@Mapper(
        componentModel = "spring",
        unmappedSourcePolicy = ReportingPolicy.IGNORE,
        unmappedTargetPolicy = ReportingPolicy.IGNORE,
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL
)
public interface RequestItemToEntityMapper extends GenericRequestToEntityMapper<ItemRequest, Item> {
    void mapFromRequestToEntity(ItemRequest request, @MappingTarget Item entity);
}
