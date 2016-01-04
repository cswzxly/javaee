package com.system.mappers;

import com.system.pojo.RoleModule;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:51
 * To change this template use File | Settings | File Templates.
 */
public interface RoleModuleMapper {

    public void insertRoleModule(RoleModule roleModule);

    public void deleteRoleModule(RoleModule roleModule);
    
    Integer count(RoleModule roleModule);

}
