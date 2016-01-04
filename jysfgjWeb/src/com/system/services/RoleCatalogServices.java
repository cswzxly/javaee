package com.system.services;

import com.system.pojo.RoleCatalog;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by LinK on 2014/11/21.
 */
@Transactional
public interface RoleCatalogServices {
    void insertRoleCatalog(RoleCatalog roleCatalog);

    void deleteRoleCatalog(RoleCatalog roleCatalog);

    void deleteByRoleID(Integer roleID);
}
