package com.barunsw.simple.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	@Override
	public List<UserVo> selectUserList(UserVo userVo) {
		return userDao.selectUserList(userVo);
	}

	@Override
	public UserVo selectUserOne(String userId) {
		return userDao.selectUserOne(userId);
	}

	@Override
	public int insertUser(UserVo userVo) {
		return userDao.insertUser(userVo);
	}

	@Override
	public int updateUser(UserVo userVo) {
		return userDao.updateUser(userVo);
	}

	@Override
	public int deleteUser(String userId) {
		return userDao.deleteUser(userId);
	}

}
