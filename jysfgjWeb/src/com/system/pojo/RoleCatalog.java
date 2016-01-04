package com.system.pojo;

/**
 * Created by LinK on 2014/11/20.
 * 角色栏目关联实体
 */
public class RoleCatalog {
    private Integer id;
    private Integer roleId;// 角色ID
    private Integer catalogId;// 栏目ID

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

    public Integer getCatalogId() {
        return catalogId;
    }

    public void setCatalogId(Integer catalogId) {
        this.catalogId = catalogId;
    }
}
