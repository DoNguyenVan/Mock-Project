package com.fpt.webapp.utils;

import java.util.List;

import com.fpt.webapp.entity.Employee;
import com.fpt.webapp.model.EmployeeModel;

public interface EmployeeDAO {
	
	public List<EmployeeModel> listEmployees();
	
	public void save (Employee e);
	
	public Employee findEmployee(String id);
	
	public void delete(String id);

}
