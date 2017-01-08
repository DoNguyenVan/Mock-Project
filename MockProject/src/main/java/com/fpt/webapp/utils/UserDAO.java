package com.fpt.webapp.utils;

import com.fpt.webapp.entity.User;

public interface UserDAO {
	
	public User findUser(String id, String password);

}
