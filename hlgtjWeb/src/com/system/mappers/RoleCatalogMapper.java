package com.system.mappers;

import com.system.pojo.RoleCatalog;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-28
 * Time: 上午11:51
 * To change this template use File | Settings | File Templates.
 */
public interface RoleCatalogMapper {

    void insertRoleCatalog(RoleCatalog roleCatalog);

    void deleteRoleCatalog(RoleCatalog roleCatalog);

    void deleteByRoleID(Integer roleID);

}
