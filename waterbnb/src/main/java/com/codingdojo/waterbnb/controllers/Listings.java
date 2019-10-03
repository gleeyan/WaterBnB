package com.codingdojo.waterbnb.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codingdojo.waterbnb.models.Listing;
import com.codingdojo.waterbnb.models.User;
import com.codingdojo.waterbnb.services.ApiService;

@Controller
public class Listings {

	private ApiService as;
	private String[] poolSizes = new String[] {"Small", "Medium", "Large", "Olympic"};
	
	public Listings(ApiService as) {
		this.as = as;
	}
	
	@RequestMapping("/host/dashboard")
	public String hostDashboard(@Valid @ModelAttribute("listing") Listing listing,
			Principal principal,
			Model model) {
		User user = as.findUserByEmail(principal.getName());
		model.addAttribute("allListings", as.findAllListingsByUser(user));
		model.addAttribute("user", user);
		model.addAttribute("poolSizes", poolSizes);
		return "newListing.jsp";
	}
	
	@PostMapping("/host/create")
	public String createListing(@Valid @ModelAttribute("listing") Listing listing,
			BindingResult res,
			Principal prince,
			Model model) {
		if (res.hasErrors()) {
			model.addAttribute("poolSizes", poolSizes);
			return "newListing.jsp";
		}
		listing.setUser(as.findUserByEmail(prince.getName()));
		as.saveListing(listing);
		return "redirect:/host/dashboard";
	}
	
	@RequestMapping("/host/update/{id}")
	public String editListing(@PathVariable("id") Long id,
			Model model) {
		model.addAttribute("listing", as.findListingById(id));
		model.addAttribute("poolSizes", poolSizes);
		return "editListing.jsp";
	}
	
	@PostMapping("/host/update/{id}")
	public String updateListing(@Valid @ModelAttribute("listing") Listing listing,
			BindingResult res,
			Principal prince,
			Model model) {
		if (res.hasErrors()) {
			model.addAttribute("poolSizes", poolSizes);
			return "editListing.jsp";
		}
		listing.setUser(as.findUserByEmail(prince.getName()));
		as.saveListing(listing);
		return "redirect:/host/dashboard";
	}
	
	@RequestMapping("/pools/{id}")
	public String showPool(@PathVariable("id") Long id,
			Model model) {
		model.addAttribute("listing", as.findListingById(id));
		return "showListing.jsp";
	}
	
}
