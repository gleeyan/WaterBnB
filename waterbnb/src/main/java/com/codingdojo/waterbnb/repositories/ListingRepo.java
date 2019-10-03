package com.codingdojo.waterbnb.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.waterbnb.models.Listing;
import com.codingdojo.waterbnb.models.User;

@Repository
public interface ListingRepo extends CrudRepository<Listing, Long> {
	
	List<Listing> findAll();
	
	@Query("SELECT l FROM Listing l WHERE l.user = ?1")
	List<Listing> findAllByUser(User user);
	
	List<Listing> findByAddressContaining(String query);
	
}
