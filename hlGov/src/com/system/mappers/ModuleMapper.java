package com.system.mappers;

import com.system.pojo.Module;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * Module: cxx
 * Date: 14-7-22
 * Time: 下午4:47
 * To change this template use File | Settings | File Templates.
 */
public interface ModuleMapper {

    public List<Module> queryModuleListByBean(Module module);

    public Module queryModuleListById(Module module);

    public void insertModule(Module module);

    public void updateModule(Module module);

    public void deleteModule(Module module);

    public List<Module> queryRoleModule(Module module);

    public List<Module> queryUserModule(Module module);
}
