package com.system.pojo;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-23
 * Time: 上午11:50
 * To change this template use File | Settings | File Templates.
 */
//角色
public class Role {
    private Integer id; //id
    private String roleName;//角色名称
    private String description;//角色描述
    private String createTime;//创建时间

    private Integer userId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }
}
