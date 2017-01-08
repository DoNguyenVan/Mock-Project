package com.fpt.webapp.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.fpt.webapp.entity.Employee;
import com.fpt.webapp.model.EmployeeModel;
import com.fpt.webapp.utils.EmployeeDAO;

public class EmployeeDaoImpl implements EmployeeDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Employee e) {
				
		boolean isNew = false;
		Employee efind = this.findEmployee(e.getId());	
		if(efind == null){
			efind = new Employee();
			efind.setId(e.getId());
			isNew = true;
		}
		
		efind.setEmail(e.getEmail());
		efind.setDob(e.getDob());
		efind.setFirstname(e.getFirstname());
		efind.setPhone(e.getPhone());
		efind.setLastname(e.getLastname());
		
		if(isNew){
			Session session = sessionFactory.getCurrentSession();
			session.persist(efind);
		}
		
	}

	@Override
	public Employee findEmployee(String id) {
		
		Session session = sessionFactory.getCurrentSession();
		Criteria crit = session.createCriteria(Employee.class);
		crit.add(Restrictions.eq("id", id));		
		return (Employee) crit.uniqueResult();
	
	}

	@Override
	public List<EmployeeModel> listEmployees() {
		
		String sql = "Select new "+EmployeeModel.class.getName() //
				    +"(e.id, e.firstname, e.lastname, e.email, e.phone, e.dob)"//
				    +" from "+ Employee.class.getName() +" e ";
		
		Session session = this.sessionFactory.getCurrentSession();
		Query query = session.createQuery(sql);
		return query.list();
	
	}

	@Override
	public void delete(String id) {
		
		Employee efind = this.findEmployee(id);
		
		if(efind != null){
			Session session = sessionFactory.getCurrentSession();
			session.delete(efind);
		}
		
	}

}
