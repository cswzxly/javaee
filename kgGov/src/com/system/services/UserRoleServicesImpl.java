package com.system.services;

import com.system.mappers.UserRoleMapper;
import com.system.pojo.User;
import com.system.pojo.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:46
 * To change this template use File | Settings | File Templates.
 */
@Service("userRoleServices")
public class UserRoleServicesImpl implements UserRoleServices {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public boolean addUserRole(Integer userId, String roleIdStr) {
        if (roleIdStr != null && !"".equals(roleIdStr)) {
            String[] arr = roleIdStr.split(",");
            for (int i = 0; i < arr.length; i++) {
                Integer roleId = Integer.parseInt(arr[i]);
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                userRoleMapper.insertUserRole(userRole);
            }
        }
        return true;
    }

    @Override
    public boolean removeUserRole(Integer userId, String roleIdStr) {
        if (roleIdStr != null && !"".equals(roleIdStr)) {
            String[] arr = roleIdStr.split(",");
            for (int i = 0; i < arr.length; i++) {
                Integer roleId = Integer.parseInt(arr[i]);
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                userRoleMapper.deleteUserRole(userRole);
            }
        }
        return true;
    }

    @Override
    public Integer countByRoleID(Integer roleID) {
        return userRoleMapper.countByRoleID(roleID);
    }

    @Override
    public void deleteUserRoleByUser(User user) {
        userRoleMapper.deleteUserRoleByUser(user);
    }

    public UserRoleMapper getUserRoleMapper() {
        return userRoleMapper;
    }

    public void setUserRoleMapper(UserRoleMapper userRoleMapper) {
        this.userRoleMapper = userRoleMapper;
    }
}
