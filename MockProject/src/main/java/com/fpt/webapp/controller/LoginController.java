package com.fpt.webapp.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.fpt.webapp.entity.Employee;
import com.fpt.webapp.entity.User;
import com.fpt.webapp.utils.EmployeeDAO;
import com.fpt.webapp.utils.UserDAO;

@Controller
@Transactional
@EnableWebMvc
public class LoginController {
	
	@Autowired
	private UserDAO logindao;
	@Autowired
	private EmployeeDAO employeedao;
	
	@RequestMapping("/")
	public String getLoginPage(Model model){
		
		model.addAttribute("LoginForm", new User());

		return "login";
	}
	
	@RequestMapping(value="/home",method=RequestMethod.POST)
	public String LoginAccess(Model model,@ModelAttribute("LoginForm") User account,
			HttpServletRequest  request){
		
		User user = logindao.findUser(account.getId(), account.getPassword());
		
		if(user == null){
			
			model.addAttribute("message", "Username or password is incorrect !");
			return "login";
		
		}		
		else {
			
			HttpSession session = request.getSession();
			session.setAttribute("account", user);
			return this.FormIndex(model);
		}		
	}
	
	private String FormIndex(Model model){
		model.addAttribute("employeeForm", new Employee());
		model.addAttribute("emplist", employeedao.listEmployees());
		return "index";
	}
	
	@RequestMapping("/logout")
	public String logoutProcess(HttpServletRequest request){	
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
}
