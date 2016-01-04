package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Module;
import com.system.pojo.Role;
import com.system.services.RoleServices;
import com.system.services.UserRoleServices;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 下午3:49
 * To change this template use File | Settings | File Templates.
 */
public class UserRoleAction extends BaseAction{


    @Autowired
    private RoleServices roleServices;

    @Autowired
    private UserRoleServices userRoleServices;

    private Integer userId;

    private String roleIdStr;

    public String userRolePage(){
        this.getRequest().setAttribute("userId",userId);
        return SUCCESS;
    }

    public void userRoleList(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            Role role = new Role();
            role.setUserId(userId);
            List<Role> list = roleServices.queryUserRoleList(role);
            map.put("total",list.size());
            map.put("rows",list);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public void addUserRole(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            boolean flag = userRoleServices.addUserRole(userId,roleIdStr);
            String result = "fail";
            if(flag){
                result = "success";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    public void removeUserRole(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            boolean flag = userRoleServices.removeUserRole(userId,roleIdStr);
            String result = "fail";
            if(flag){
                result = "success";
            }
            pw.write(result);
        }catch (Exception e){
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

    public UserRoleServices getUserRoleServices() {
        return userRoleServices;
    }

    public void setUserRoleServices(UserRoleServices userRoleServices) {
        this.userRoleServices = userRoleServices;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getRoleIdStr() {
        return roleIdStr;
    }

    public void setRoleIdStr(String roleIdStr) {
        this.roleIdStr = roleIdStr;
    }
}
