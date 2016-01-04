package com.system.pojo;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-23
 * Time: 上午11:54
 * To change this template use File | Settings | File Templates.
 */
//角色模块关系
public class RoleModule {
    private Integer id;//id
    private Integer roleId;//角色id
    private Integer moduleId;//模块id

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }
}
