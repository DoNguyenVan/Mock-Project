package com.fpt.webapp.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.fpt.webapp.entity.Employee;
import com.fpt.webapp.utils.EmployeeDAO;

@Controller
@Transactional
@EnableWebMvc
public class IndexController {
	
	@Autowired
	private EmployeeDAO employeedao;
	
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public String commitDatabase(Model model, @ModelAttribute("employeeForm")Employee e){
		
		if(!"".equals(e.getId())){			
			employeedao.save(e);
		}
		
		return "redirect:/list";
	}
	
	@RequestMapping(value="/list")
	public String getListEmployees(Model model){
		model.addAttribute("employeeForm", new Employee());
		model.addAttribute("emplist", employeedao.listEmployees());
		return "index";
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.GET)
	public String deleteEmployee(Model model, @RequestParam("id") String id){
		
		employeedao.delete(id);
		return "redirect:/list";
	}

}
