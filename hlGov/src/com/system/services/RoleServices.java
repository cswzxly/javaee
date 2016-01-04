package com.system.services;

import com.system.pojo.Role;
import com.system.pojo.User;

import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-26
 * Time: 上午11:15
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface RoleServices {

    public Role queryRoleById(Role role);

    public List<Role> queryAllRoleList();

    public void insertRole(Role role);

    public void updateRole(Role role);

    public void deleteRole(Role role);

    public List<Role> queryUserRoleList(Role role);
    
    public Integer countRoleByAdmin(User user);

}
