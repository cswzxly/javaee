package com.system.services;

import com.system.pojo.RoleModule;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:45
 * To change this template use File | Settings | File Templates.
 */
@Transactional
public interface RoleModuleServices {

    public boolean addRoleModule(Integer roleId,String moduleIdStr);

    public boolean removeRoleModule(Integer roleId,String moduleIdStr);

    public Integer count(RoleModule roleModule);

}
