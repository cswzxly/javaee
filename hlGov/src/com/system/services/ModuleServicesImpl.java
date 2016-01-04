package com.system.services;

import com.system.mappers.ModuleMapper;
import com.system.mappers.RoleModuleMapper;
import com.system.pojo.Module;
import com.system.pojo.RoleModule;
import org.springframework.beans.factory.annotation.Autowire;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-25
 * Time: 上午11:43
 * To change this template use File | Settings | File Templates.
 */
@Service("moduleServices")
public class ModuleServicesImpl implements ModuleServices{

    @Autowired
    private ModuleMapper moduleMapper;

    @Autowired
    private RoleModuleMapper roleModuleMapper;

    @Override
    public List<Module> queryModuleListByBean(Module module) {
        return moduleMapper.queryModuleListByBean(module);
    }

    @Override
    public Module queryModuleListById(Module module){
        return moduleMapper.queryModuleListById(module);
    }

    @Override
    public void insertModule(Module module) {
        moduleMapper.insertModule(module);
    }

    @Override
    public void updateModule(Module module) {
        moduleMapper.updateModule(module);
    }

    @Override
    public void deleteModule(Module module) {
        moduleMapper.deleteModule(module);
        Module moduleTmp = new Module();
        moduleTmp.setPid(module.getId());
        List<Module> list = moduleMapper.queryModuleListByBean(moduleTmp);
        if(list!=null&&list.size()>0){
            RoleModule roleModule = new RoleModule();
            for(int i=0;i<list.size();i++){
                moduleMapper.deleteModule(list.get(i));
                //级联删除角色中分配该模块的权限
                roleModule.setModuleId(list.get(i).getId());
                roleModuleMapper.deleteRoleModule(roleModule);
            }
        }
    }

    @Override
    public List<Module> queryRoleModule(Module module){
        return moduleMapper.queryRoleModule(module);
    }

    @Override
    public List<Module> queryUserModule(Module module){
        return moduleMapper.queryUserModule(module);
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
