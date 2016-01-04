package com.system.services;

import com.system.pojo.Module;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-25
 * Time: 上午11:42
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface ModuleServices {

    public List<Module> queryModuleListByBean(Module module);

    public Module queryModuleListById(Module module);

    public void insertModule(Module module);

    public void updateModule(Module module);

    public void deleteModule(Module module);

    public List<Module> queryRoleModule(Module module);

    public List<Module> queryUserModule(Module module);
}
