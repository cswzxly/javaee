package com.system.mappers;

import com.system.pojo.User;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-22
 * Time: 下午4:47
 * To change this template use File | Settings | File Templates.
 */
public interface UserMapper {

    public User queryUserByBean(User user);

    public List<User> queryAllUserList();

    public void insertUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);
    
    public void hideUser(User user);

    public Integer countUserByCreatePid(Integer id);
}
