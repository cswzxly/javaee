package com.system.services;

import com.system.mappers.ModuleMapper;
import com.system.mappers.RoleModuleMapper;
import com.system.pojo.Module;
import com.system.pojo.RoleModule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:46
 * To change this template use File | Settings | File Templates.
 */
@Service("roleModuleServices")
public class RoleModuleServicesImpl implements RoleModuleServices{

    @Autowired
    private ModuleMapper moduleMapper;

    @Autowired
    private RoleModuleMapper roleModuleMapper;

    @Override
    public boolean addRoleModule(Integer roleId,String moduleIdStr){
        if(moduleIdStr!=null&&!"".equals(moduleIdStr)){
            String[] arr = moduleIdStr.split(",");
            for(int i=0;i<arr.length;i++){
                Integer moduleId = Integer.parseInt(arr[i]);
                RoleModule roleModule = new RoleModule();
                roleModule.setRoleId(roleId);
                roleModule.setModuleId(moduleId);
                roleModuleMapper.insertRoleModule(roleModule);
            }
        }
        return true;
    }

    @Override
    public boolean removeRoleModule(Integer roleId,String moduleIdStr){
        if(moduleIdStr!=null&&!"".equals(moduleIdStr)){
            String[] arr = moduleIdStr.split(",");
            for(int i=0;i<arr.length;i++){
                Integer moduleId = Integer.parseInt(arr[i]);
                RoleModule roleModule = new RoleModule();
                roleModule.setRoleId(roleId);
                roleModule.setModuleId(moduleId);
                roleModuleMapper.deleteRoleModule(roleModule);
                Module module = new Module();
                module.setPid(moduleId);
                List<Module> moduleList = moduleMapper.queryModuleListByBean(module);
                if(moduleList!=null&&moduleList.size()>0){
                    for(int j=0;j<moduleList.size();j++){
                        roleModule.setRoleId(roleId);
                        roleModule.setModuleId(moduleList.get(j).getId());
                        roleModuleMapper.deleteRoleModule(roleModule);
                    }
                }
            }
        }
        return true;
    }

    @Override
    public Integer count(RoleModule roleModule) {
        return roleModuleMapper.count(roleModule);
    }

    public ModuleMapper getModuleMapper() {
        return moduleMapper;
    }

    public void setModuleMapper(ModuleMapper moduleMapper) {
        this.moduleMapper = moduleMapper;
    }

    public RoleModuleMapper getRoleModuleMapper() {
        return roleModuleMapper;
    }

    public void setRoleModuleMapper(RoleModuleMapper roleModuleMapper) {
        this.roleModuleMapper = roleModuleMapper;
    }
}
