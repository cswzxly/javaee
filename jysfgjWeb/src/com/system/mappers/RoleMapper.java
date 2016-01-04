package com.system.mappers;

import com.system.pojo.Role;
import com.system.pojo.User;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-22
 * Time: 下午4:47
 * To change this template use File | Settings | File Templates.
 */
public interface RoleMapper {

    public Role queryRoleById(Role role);

    public List<Role> queryAllRoleList();

    public void insertRole(Role role);

    public void updateRole(Role role);

    public void deleteRole(Role role);

    public List<Role> queryUserRoleList(Role role);

    public Integer countRoleByAdmin(User user);
}
