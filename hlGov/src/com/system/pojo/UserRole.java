package com.system.pojo;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-23
 * Time: 上午11:53
 * To change this template use File | Settings | File Templates.
 */
//用户角色关系
public class UserRole {
    private Integer id;//id
    private Integer userId;//用户ID
    private Integer roleId;//角色ID

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}
