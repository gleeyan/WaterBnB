package com.codingdojo.waterbnb.controllers;

import java.security.Principal;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.waterbnb.models.Review;
import com.codingdojo.waterbnb.models.User;
import com.codingdojo.waterbnb.services.ApiService;
import com.codingdojo.waterbnb.validator.UserValidator;

@Controller
public class Users {
	
	private ApiService as;
	private UserValidator uv;
	
	public Users(ApiService as,
			UserValidator uv) {
		this.as = as;
		this.uv = uv;
	}

	@RequestMapping("/")
	public String index(Principal prince,
			Model model) {
		if (prince != null) {
			model.addAttribute("user", as.findUserByEmail(prince.getName()));
		}
		return "index.jsp";
	}
	
	@RequestMapping("/guest/signin")
	public String login(@Valid @ModelAttribute("user") User user,
			@RequestParam(value="error", required=false) String error,
			@RequestParam(value="logout", required=false) String logout,
			Model model) {
		if (error != null) {
			model.addAttribute("errorMessage", "Unable to sign in, please try again");
		}
		if (logout != null) {
			model.addAttribute("logoutMessage", "Successfully logged out");
		}
		return "loginReg.jsp";
	}
	
	@PostMapping("/register")
	public String register(
			@Valid @ModelAttribute("user") User user,
			BindingResult result,
			@RequestParam("role") String role,
			Model model,
			HttpSession session) {
		model.addAttribute("role", role);
		uv.validate(user, result);
		if (result.hasErrors()) {
			return "loginReg.jsp";
		}
		if (model.asMap().containsValue("Guest")) {
			as.saveGuestWithUserRole(user);
		} else if (model.asMap().containsValue("Host")) {
			as.saveHostWithUserRole(user);
		}
		return "redirect:/";
	}
	
	@RequestMapping("/default")
	public String defaultLogin(Principal prince) {
		User user = as.findUserByEmail(prince.getName());
		if (user.getRoles().contains(as.findRoleByName("ROLE_HOST"))) {
			return "redirect:/host/dashboard";
		}
		return "redirect:/search";
	}
	
	@RequestMapping("/search")
	public String showSearchResults(@RequestParam(value = "q", required = false) String query,
			Principal prince,
			Model model) {
		if (prince != null) {
			model.addAttribute("user", as.findUserByEmail(prince.getName()));
		}
		if (query != null) {
			model.addAttribute("results", as.searchListingsByAddress(query));
		}
		return "showSearch.jsp";
	}

}
