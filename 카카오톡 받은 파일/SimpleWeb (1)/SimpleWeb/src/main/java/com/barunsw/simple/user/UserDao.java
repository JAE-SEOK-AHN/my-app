package com.barunsw.simple.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserDao {
	
	public List<UserVo> selectUserList(UserVo userVo);

	public UserVo selectUserOne(String userId);
	
	public int insertUser(UserVo userVo);
	
	public int updateUser(UserVo userVo);
	
	public int deleteUser(String userId);
	
}
