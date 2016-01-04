package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Module;
import com.system.pojo.User;
import com.system.services.ModuleServices;
import com.system.services.UserServices;
import com.system.utils.MD5Utils;

import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-22
 * Time: 下午3:07
 * To change this template use File | Settings | File Templates.
 */
public class LoginAction extends BaseAction {


    private String userName;
    private String password;

    @Autowired
    private UserServices userServices;

    @Autowired
    private ModuleServices moduleServices;

    public String login() {
        User user = (User) this.getRequest().getSession().getAttribute("userInSession");
        if (user != null) {
            this.setUserModule(user);
            return SUCCESS;
        } else {
            user = new User();
        }
        if (userName == null || "".equals(userName) || password == null || "".equals(password)) {
            return ERROR;
        }

        String validCode = this.getRequest().getParameter("validCode");
        String validationCode = (String) this.getRequest().getSession().getAttribute("validationCode");

        user.setUserName(userName);
        user.setPassword(MD5Utils.strToMD5(password));
        user = userServices.queryUserByBean(user);
        if (user != null) {
            if (validCode.equals(validationCode)) {
                this.getRequest().getSession().setAttribute("userInSession", user);
                this.setUserModule(user);
                return SUCCESS;
            } else {
                request.setAttribute("tips", "验证码错误！");
                return ERROR;
            }

        } else {
            request.setAttribute("tips", "不存在该用户或者登录密码错误！");
            return ERROR;
        }
    }

    private void setUserModule(User user) {
        Module module = new Module();
        module.setUserId(user.getId());
        List<Module> moduleList = moduleServices.queryUserModule(module);
        Map<String, Object> map = new HashMap<String, Object>();
        List<Map> mapArrayList = new ArrayList<Map>();
        if (moduleList != null && moduleList.size() > 0) {
            for (int i = 0; i < moduleList.size(); i++) {
                if (moduleList.get(i).getPid() == 0) {
                    Map<String, Object> m = new HashMap<String, Object>();
                    m.put("id", moduleList.get(i).getId());
                    m.put("icon", "icon-sys");
                    m.put("moduleName", moduleList.get(i).getModuleName());
                    List<Module> sub = new ArrayList<Module>();
                    for (int j = 0; j < moduleList.size(); j++) {
                        if (moduleList.get(i).getId() == moduleList.get(j).getPid()) {//模块管理不给于维护
                            sub.add(moduleList.get(j));
                        }
                    }
                    m.put("menus", sub);
                    mapArrayList.add(m);
                }
            }
        }
        map.put("menus", mapArrayList);
        String result = JSONObject.toJSONString(map);
        this.getRequest().setAttribute("result", result);
    }

    public String loginOut() {
        this.getRequest().getSession().removeAttribute("userInSession");
        return SUCCESS;
    }


    public UserServices getUserServices() {
        return userServices;
    }

    public void setUserServices(UserServices userServices) {
        this.userServices = userServices;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public ModuleServices getModuleServices() {
        return moduleServices;
    }

    public void setModuleServices(ModuleServices moduleServices) {
        this.moduleServices = moduleServices;
    }
}
