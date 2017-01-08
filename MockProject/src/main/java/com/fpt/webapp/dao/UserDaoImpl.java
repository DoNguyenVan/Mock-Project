package com.fpt.webapp.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;

import com.fpt.webapp.entity.User;
import com.fpt.webapp.utils.UserDAO;

public class UserDaoImpl implements UserDAO{
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public User findUser(String id, String password) {
		
		Session session = sessionFactory.getCurrentSession();
		Criteria crit = session.createCriteria(User.class);
		crit.add(Restrictions.eq("id", id));
		crit.add(Restrictions.eq("password", password));
		
		return (User) crit.uniqueResult();
	}

}
