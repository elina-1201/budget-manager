package org.artso.budget_manager.repository;

import org.artso.budget_manager.entity.Item;
import org.springframework.data.repository.CrudRepository;

public interface ItemRepo extends CrudRepository<Item, Long> {
}
