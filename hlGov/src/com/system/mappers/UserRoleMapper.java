package com.system.mappers;

import com.system.pojo.User;
import com.system.pojo.UserRole;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:51
 * To change this template use File | Settings | File Templates.
 */
public interface UserRoleMapper {

    public void insertUserRole(UserRole userRole);

    public void deleteUserRole(UserRole userRole);
    
    public Integer countByRoleID(Integer roleID);

    public void deleteUserRoleByUser(User user);

}
