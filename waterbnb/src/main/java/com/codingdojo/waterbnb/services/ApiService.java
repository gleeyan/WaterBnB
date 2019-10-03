package com.codingdojo.waterbnb.services;

import java.util.List;
import java.util.Optional;


import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.codingdojo.waterbnb.models.Listing;
import com.codingdojo.waterbnb.models.Review;
import com.codingdojo.waterbnb.models.Role;
import com.codingdojo.waterbnb.models.User;
import com.codingdojo.waterbnb.repositories.ListingRepo;
import com.codingdojo.waterbnb.repositories.ReviewRepo;
import com.codingdojo.waterbnb.repositories.RoleRepo;
import com.codingdojo.waterbnb.repositories.UserRepo;

@Service
public class ApiService {

	private ListingRepo lr;
	private ReviewRepo rr;
	private RoleRepo ror;
	private UserRepo ur;
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	public ApiService(ListingRepo lr,
			ReviewRepo rr,
			RoleRepo ror,
			UserRepo ur,
			BCryptPasswordEncoder bCryptPasswordEncoder) {
		this.lr = lr;
		this.rr = rr;
		this.ror = ror;
		this.ur = ur;
		this.bCryptPasswordEncoder = bCryptPasswordEncoder;
	}
	
	public void saveGuestWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(ror.findRolesByName("ROLE_USER", "ROLE_GUEST"));
		ur.save(user);
	}
	
	public void saveHostWithUserRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(ror.findRolesByName("ROLE_USER", "ROLE_HOST"));
		ur.save(user);
	}
	
	public void saveGuestWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(ror.findRolesByName("ROLE_ADMIN", "ROLE_GUEST"));
		ur.save(user);
	}
	
	public void saveHostWithAdminRole(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
		user.setRoles(ror.findRolesByName("ROLE_ADMIN", "ROLE_HOST"));
		ur.save(user);
	}
	
	public User findUserByEmail(String email) {
		return ur.findByEmail(email);
	}
	
	public Role findRoleByName(String name) {
		List<Role> results = ror.findByName(name);
		if (results.size() == 1) {
			return results.get(0);
		}
		return null;
	}
	
	public void saveListing(Listing listing) {
		lr.save(listing);
	}
	
	public List<Listing> findAllListings() {
		return lr.findAll();
	}
	
	public List<Listing> findAllListingsByUser(User user) {
		return lr.findAllByUser(user);
	}
	
	public List<Listing> searchListingsByAddress(String query) {
		return lr.findByAddressContaining(query);
	}
	
	public Listing findListingById(Long id) {
		Optional<Listing> listing = lr.findById(id);
		if (listing != null) {
			return listing.get();
		}
		return null;
	}
	
	public void saveReview(Review review) {
		rr.save(review);
	}
	 
}
