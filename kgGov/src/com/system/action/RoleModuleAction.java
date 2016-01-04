package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Module;
import com.system.services.ModuleServices;
import com.system.services.RoleModuleServices;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-26
 * Time: 下午3:54
 * To change this template use File | Settings | File Templates.
 */
public class RoleModuleAction extends BaseAction{


    @Autowired
    private ModuleServices moduleServices;

    @Autowired
    private RoleModuleServices roleModuleServices;

    private Integer id;
    private Integer pid;
    private Integer roleId;
    private Integer moduleId;

    private String moduleLevel;

    private String moduleIdStr;

    public String roleModulePage(){
        this.getRequest().setAttribute("roleId",roleId);
        return SUCCESS;
    }


    public void roleModuleList(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            Module module = new Module();
            module.setPid(pid);
            module.setRoleId(roleId);
            module.setModuleLevel(moduleLevel);
            List<Module> list = moduleServices.queryRoleModule(module);
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

    public void addRoleModule(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            boolean flag = roleModuleServices.addRoleModule(roleId,moduleIdStr);
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

    public void removeRoleModule(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            boolean flag = roleModuleServices.removeRoleModule(roleId, moduleIdStr);
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

    public ModuleServices getModuleServices() {
        return moduleServices;
    }

    public void setModuleServices(ModuleServices moduleServices) {
        this.moduleServices = moduleServices;
    }

    public RoleModuleServices getRoleModuleServices() {
        return roleModuleServices;
    }

    public void setRoleModuleServices(RoleModuleServices roleModuleServices) {
        this.roleModuleServices = roleModuleServices;
    }

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

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getModuleLevel() {
        return moduleLevel;
    }

    public void setModuleLevel(String moduleLevel) {
        this.moduleLevel = moduleLevel;
    }

    public String getModuleIdStr() {
        return moduleIdStr;
    }

    public void setModuleIdStr(String moduleIdStr) {
        this.moduleIdStr = moduleIdStr;
    }
}
