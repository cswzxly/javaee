package com.system.services;

import com.system.mappers.UserMapper;
import com.system.mappers.UserRoleMapper;
import com.system.pojo.User;
import com.system.pojo.UserRole;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-22
 * Time: 下午4:54
 * To change this template use File | Settings | File Templates.
 */
@Service("userServices")
public class UserServicesImpl implements UserServices{

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public User queryUserByBean(User user){
        return userMapper.queryUserByBean(user);
    }

    @Override
    public List<User> queryAllUserList(){
        return userMapper.queryAllUserList();
    }

    @Override
    public void insertUser(User user){
        userMapper.insertUser(user);
    }

    @Override
    public void updateUser(User user){
        userMapper.updateUser(user);
    }

    @Override
    public void deleteUser(User user){
        this.userMapper.deleteUser(user);
        //级联删除用户角色配置
        UserRole userRole = new UserRole();
        userRole.setUserId(user.getId());
        userRoleMapper.deleteUserRole(userRole);
    }
    @Override
	public void hideUser(User user) {
    	userMapper.hideUser(user);
	}

	@Override
	public Integer countUserByCreatePid(Integer id) {
		return userMapper.countUserByCreatePid(id);
	}
    public UserMapper getUserMapper() {
        return userMapper;
    }

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public UserRoleMapper getUserRoleMapper() {
        return userRoleMapper;
    }

    public void setUserRoleMapper(UserRoleMapper userRoleMapper) {
        this.userRoleMapper = userRoleMapper;
    }

}
