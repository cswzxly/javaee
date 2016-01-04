package com.system.services;

import com.system.mappers.RoleCatalogMapper;
import com.system.pojo.RoleCatalog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by LinK on 2014/11/21.
 */
@Service("roleCatalogServices")
public class RoleCatalogServicesImpl implements RoleCatalogServices {
    @Autowired(required = false)
    private RoleCatalogMapper roleCatalogMapper;

    @Override
    public void insertRoleCatalog(RoleCatalog roleCatalog) {
        roleCatalogMapper.insertRoleCatalog(roleCatalog);
    }

    @Override
    public void deleteRoleCatalog(RoleCatalog roleCatalog) {
        roleCatalogMapper.deleteRoleCatalog(roleCatalog);
    }

    @Override
    public void deleteByRoleID(Integer roleID) {
        roleCatalogMapper.deleteByRoleID(roleID);
    }
}
