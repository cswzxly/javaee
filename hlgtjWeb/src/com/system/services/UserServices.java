package com.system.services;

import com.system.pojo.User;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-22
 * Time: 下午4:53
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface UserServices {

    public User queryUserByBean(User user);

    public List<User> queryAllUserList();

    public void insertUser(User user);

    public void updateUser(User user);

    public void deleteUser(User user);

    void hideUser(User user);

    Integer countUserByCreatePid(Integer id);
}
