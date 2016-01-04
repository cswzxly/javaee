package com.system.services;

import com.system.pojo.User;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:45
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface UserRoleServices {

    public boolean addUserRole(Integer userId, String roleIdStr);

    public boolean removeUserRole(Integer userId, String roleIdStr);

    public Integer countByRoleID(Integer roleID);

    public void deleteUserRoleByUser(User user);
}
