package com.system.services;

import com.system.mappers.RoleMapper;
import com.system.mappers.RoleModuleMapper;
import com.system.pojo.Role;
import com.system.pojo.RoleModule;
import com.system.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-26
 * Time: 上午11:15
 * To change this template use File | Settings | File Templates.
 */
@Service("roleServices")
public class RoleServicesImpl implements RoleServices{


    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RoleModuleMapper roleModuleMapper;

    @Override
    public Role queryRoleById(Role role) {
        return roleMapper.queryRoleById(role);
    }

    @Override
    public List<Role> queryAllRoleList() {
        return roleMapper.queryAllRoleList();
    }

    @Override
    public void insertRole(Role role) {
        roleMapper.insertRole(role);
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateRole(role);
    }

    @Override
    public void deleteRole(Role role) {
        roleMapper.deleteRole(role);
        //级联删除角色权限分配表中该角色的权限
        RoleModule roleModule = new RoleModule();
        roleModule.setRoleId(role.getId());
        roleModuleMapper.deleteRoleModule(roleModule);
    }

    @Override
    public List<Role> queryUserRoleList(Role role){
         return roleMapper.queryUserRoleList(role);
    }

    @Override
    public Integer countRoleByAdmin(User user) {
        return roleMapper.countRoleByAdmin(user);
    }

    public RoleMapper getRoleMapper() {
        return roleMapper;
    }

    public void setRoleMapper(RoleMapper roleMapper) {
        this.roleMapper = roleMapper;
    }

    public RoleModuleMapper getRoleModuleMapper() {
        return roleModuleMapper;
    }

    public void setRoleModuleMapper(RoleModuleMapper roleModuleMapper) {
        this.roleModuleMapper = roleModuleMapper;
    }
}
