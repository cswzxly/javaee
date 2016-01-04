package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Module;
import com.system.pojo.User;
import com.system.services.ModuleServices;
import com.system.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-25
 * Time: 上午11:47
 * To change this template use File | Settings | File Templates.
 */
public class ModuleAction extends BaseAction{

    @Autowired
    private ModuleServices moduleServices;

    private Integer id;
    private Integer pid;
    private String moduleCode;
    private String moduleName;
    private String moduleUrl;
    private String moduleLevel;


    public String modulePage(){
        return SUCCESS;
    }

    public void moduleList(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            Module module = new Module();
            module.setPid(pid);
            module.setModuleLevel(moduleLevel);
            List<Module> list = moduleServices.queryModuleListByBean(module);
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


    public void saveNewModule(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Module module = new Module();
            module.setPid(pid);
            module.setModuleCode(moduleCode);
            module.setModuleName(moduleName);
            module.setModuleUrl(moduleUrl);
            module.setModuleLevel(moduleLevel);
            module.setCreateTime(DateUtils.getNowTime());
            moduleServices.insertModule(module);
            String result = "success";
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public void saveEditModule(){

        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Module module = new Module();
            module.setId(id);
            module = moduleServices.queryModuleListById(module);
            if(module!=null){
                module.setModuleName(moduleName);
                module.setModuleCode(moduleCode);
                module.setModuleUrl(moduleUrl);
                moduleServices.updateModule(module);
                result = "success";
            }else {
                result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();

    }


    public void deleteModule(){
        PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            Module module = new Module();
            module.setId(id);
            module = moduleServices.queryModuleListById(module);
            if(module!=null){
                this.moduleServices.deleteModule(module);
                result = "success";
            }else{
                result = "fail";
            }
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public String subModulePage(){
        this.getRequest().setAttribute("pid",id);
        return SUCCESS;
    }


    public ModuleServices getModuleServices() {
        return moduleServices;
    }

    public void setModuleServices(ModuleServices moduleServices) {
        this.moduleServices = moduleServices;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getModuleCode() {
        return moduleCode;
    }

    public void setModuleCode(String moduleCode) {
        this.moduleCode = moduleCode;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getModuleUrl() {
        return moduleUrl;
    }

    public void setModuleUrl(String moduleUrl) {
        this.moduleUrl = moduleUrl;
    }

    public String getModuleLevel() {
        return moduleLevel;
    }

    public void setModuleLevel(String moduleLevel) {
        this.moduleLevel = moduleLevel;
    }
}
