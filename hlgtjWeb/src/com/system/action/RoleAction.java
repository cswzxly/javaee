package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Role;
import com.system.services.RoleServices;
import com.system.services.UserRoleServices;
import com.system.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * Role: cxx
 * Date: 14-7-23
 * Time: 下午3:33
 * To change this template use File | Settings | File Templates.
 */
public class RoleAction extends BaseAction {

    @Autowired
    private RoleServices roleServices;
    @Autowired
    private UserRoleServices userRoleServices;

    private Integer id;
    private String roleName;
    private String description;

    public String rolePage() {
        return SUCCESS;
    }

    public void roleList() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String, Object> map = new HashMap<String, Object>();
            List<Role> list = roleServices.queryAllRoleList();
            map.put("total", list.size());
            map.put("rows", list);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public void saveNewRole() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Role role = new Role();
            role.setRoleName(roleName);
            role.setDescription(description);
            role.setCreateTime(DateUtils.getNowTime());
            roleServices.insertRole(role);
            result = "success";
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    public void saveEditRole() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Role role = new Role();
            role.setId(id);
            role = roleServices.queryRoleById(role);
            if (role != null) {
                role.setRoleName(roleName);
                role.setDescription(description);
                roleServices.updateRole(role);
                result = "success";
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public void deleteRole() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Role role = new Role();
            role.setId(id);
            role = roleServices.queryRoleById(role);
            Integer roleIsBind = userRoleServices.countByRoleID(id);
            if (role != null) {
                if (role.getId() == 1) {
                    result = "admin";
                } else if (roleIsBind > 0) {
                    result = "isBind";
                } else {
                    this.roleServices.deleteRole(role);
                    result = "success";
                }
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public RoleServices getRoleServices() {
        return roleServices;
    }

    public void setRoleServices(RoleServices roleServices) {
        this.roleServices = roleServices;
    }

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
}
