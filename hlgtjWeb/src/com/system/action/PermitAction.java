package com.system.action;

import com.system.pojo.Catalog;
import com.system.pojo.Role;
import com.system.pojo.RoleCatalog;
import com.system.pojo.RoleModule;
import com.system.services.CatalogServices;
import com.system.services.RoleCatalogServices;
import com.system.services.RoleModuleServices;
import com.web.utils.PropertiesUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * Created by LinK on 2014/8/19.
 */
public class PermitAction extends BaseAction {
    @Autowired
    private CatalogServices catalogServices;
    @Autowired
    private RoleCatalogServices roleCatalogServices;
    @Autowired
    private RoleModuleServices roleModuleServices;

    public String catalogEdit() {
        String roleID = request.getParameter("roleID");

        request.setAttribute("roleID", roleID);
        return SUCCESS;
    }

    public void getFlag() {
        logger.debug(">>>>>>>>>>>>>>>>>判断是否可以分配栏目权限>>>>>>>>>>>>>>>");
        String roleID = request.getParameter("roleID");
        String path = request.getSession().getServletContext().getRealPath("/");
        String propertiesPath = path + "WEB-INF/classes/web_index.properties";
        String moduleID = PropertiesUtils.readValue(propertiesPath, "permitModuleID");

        JSONObject jsonObject = new JSONObject();
        RoleModule roleModuleP1 = new RoleModule();

        if (StringUtils.isNotEmpty(roleID)) {
            if (roleID.equals("1")) {
                jsonObject.put("code", "01");
                jsonObject.put("message", "管理员角色不需要分配栏目权限！");
            } else if(StringUtils.isNotEmpty(moduleID)) {
                roleModuleP1.setRoleId(Integer.valueOf(roleID));
                roleModuleP1.setModuleId(Integer.valueOf(moduleID));
                Integer count = roleModuleServices.count(roleModuleP1);
                if (count < 1) {
                    jsonObject.put("code", "00");
                    jsonObject.put("message", "该角色尚未分配栏目内容管理权限！");
                }
            }
        } else {
            jsonObject.put("code", "99");
            jsonObject.put("message", "参数错误，请联系技术人员");
        }

        response.setCharacterEncoding(request.getCharacterEncoding());
        response.setContentType("application/json;charset=" + request.getCharacterEncoding());
        try {
            PrintWriter out = response.getWriter();
            out.println(jsonObject);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void showTree() {
        logger.debug("加载栏目树");
        String roleID = request.getParameter("roleID");
        JSONArray jsonArray = new JSONArray();
        try {
            //获取全部权限列表
            List<Catalog> allCatalogList = catalogServices.queryAllCatalogList();
            //获取已分配权限列表
            Role roleParam = new Role();
            roleParam.setId(Integer.valueOf(roleID));
            List<Catalog> roleCatalogList = catalogServices.queryByRole(roleParam);

            if (roleCatalogList.isEmpty()) {
                //不存在已经分配的权限
                for (Catalog aElem : allCatalogList) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("id", aElem.getTheID());
                    jsonObject.put("pId", aElem.getParentID());
                    jsonObject.put("name", aElem.getTitle());
                    jsonObject.put("open", true);
                    jsonArray.add(jsonObject);
                }
            } else {
                //存在已经分配的权限
                for (Catalog accessElem : allCatalogList) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("id", accessElem.getTheID());
                    jsonObject.put("pId", accessElem.getParentID());
                    jsonObject.put("name", accessElem.getTitle());
                    for (Catalog roleElem : roleCatalogList) {
                        if (roleElem.getTheID().intValue() == accessElem.getTheID().intValue()) {
                            jsonObject.put("checked", true);
                        }
                    }
                    jsonObject.put("open", true);
                    jsonArray.add(jsonObject);
                }
            }

            response.setCharacterEncoding(request.getCharacterEncoding());
            response.setContentType("application/json;charset=" + request.getCharacterEncoding());
            PrintWriter out = response.getWriter();
            out.println(jsonArray);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void saveTree() {
        logger.debug(">>>>>>>>>>>>>保存栏目权限>>>>>>>>>>>>>>");
        String roleID = request.getParameter("roleID");
        String ids = request.getParameter("ids");
        JSONObject jsonObject = new JSONObject();
        try {
            if (StringUtils.isEmpty(roleID)) {
                logger.debug("所要配置的角色id为空！");
                throw new Exception("所要配置的角色id为空！");
            }

            Role roleParam = new Role();
            roleParam.setId(Integer.valueOf(roleID));
            List<Catalog> roleCatalogList = catalogServices.queryByRole(roleParam);

            if (!roleCatalogList.isEmpty()) {
                roleCatalogServices.deleteByRoleID(Integer.valueOf(roleID));
            }

            if (StringUtils.isNotEmpty(ids)) {
                String[] catalogIDs = ids.split(",");
                for (String catalogID : catalogIDs) {
                    RoleCatalog permitParam = new RoleCatalog();
                    permitParam.setRoleId(Integer.valueOf(roleID));
                    permitParam.setCatalogId(Integer.valueOf(catalogID));
                    roleCatalogServices.insertRoleCatalog(permitParam);
                }
            }
            jsonObject.put("code", "00");
            jsonObject.put("message", "保存栏目权限成功");
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("code", "99");
            jsonObject.put("message", "保存失败");
        }

        response.setCharacterEncoding(request.getCharacterEncoding());
        response.setContentType("application/json;charset=" + request.getCharacterEncoding());
        try {
            PrintWriter out = response.getWriter();
            out.println(jsonObject);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
