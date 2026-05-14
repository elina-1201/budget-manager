package org.artso.budget_manager.mapper;

import org.mapstruct.MappingTarget;

/**
 * Generic mapper interface to map from a request (DTO) to an entity.
 * Concrete mappers should extend this interface with specific types and
 * be annotated with @Mapper so MapStruct can generate implementations.
 */
public interface GenericRequestToEntityMapper<S, T> {
    void mapFromRequestToEntity(S request, @MappingTarget T entity);
}

