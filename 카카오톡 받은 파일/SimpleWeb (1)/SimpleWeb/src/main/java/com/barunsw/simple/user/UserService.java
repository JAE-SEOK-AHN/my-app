package com.barunsw.simple.user;

import java.util.List;

public interface UserService {
	
	public List<UserVo> selectUserList(UserVo userVo);

	public UserVo selectUserOne(String userId);
	
	public int insertUser(UserVo userVo);
	
	public int updateUser(UserVo userVo);
	
	public int deleteUser(String userId);
	
}
