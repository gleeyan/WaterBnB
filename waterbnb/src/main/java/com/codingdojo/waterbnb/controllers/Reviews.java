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

import com.codingdojo.waterbnb.models.Review;
import com.codingdojo.waterbnb.services.ApiService;

@Controller
public class Reviews {

	private ApiService as;
	
	public Reviews(ApiService as) {
		this.as = as;
	}
	
	@RequestMapping("/pools/{id}/review")
	public String newReview(@Valid @ModelAttribute("review") Review review,
			@PathVariable("id") Long id,
			Principal prince,
			Model model) {
		if (prince == null) {
			return "redirect:/guest/signin";
		}
		model.addAttribute("listing", as.findListingById(id));
		return "newReview.jsp";
	}
	
	@PostMapping("/pools/{id}/review")
	public String createReview(@Valid @ModelAttribute("review") Review review,
			BindingResult res,
			@PathVariable("id") Long id,
			Principal prince,
			Model model) {
		if (res.hasErrors()) {
			model.addAttribute("listing", as.findListingById(id));
			return "newReview.jsp";
		}
		review.setAuthor(as.findUserByEmail(prince.getName()));
		review.setListing(as.findListingById(id));
		as.saveReview(review);
		return "redirect:/pools/" + id;
	}
}
