package com.system.action;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.User;
import com.system.services.UserRoleServices;
import com.system.services.UserServices;
import com.system.utils.DateUtils;
import com.system.utils.MD5Utils;

import org.springframework.beans.factory.annotation.Autowired;

import java.io.PrintWriter;
import java.security.MessageDigest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: cxx
 * Date: 14-7-23
 * Time: 下午3:33
 * To change this template use File | Settings | File Templates.
 */
public class UserAction extends BaseAction {

    @Autowired
    private UserServices userServices;
    @Autowired
    private UserRoleServices userRoleServices;

    private Integer id;
    private String userName;
    private String password;
    private String realName;

    public String userPage() {
        return SUCCESS;
    }

    public void userList() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String, Object> map = new HashMap<String, Object>();
            List<User> list = userServices.queryAllUserList();
            map.put("total", list.size());
            map.put("rows", list);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    public void checkExist() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            User user = new User();
            user.setUserName(userName);
            user = userServices.queryUserByBean(user);
            if (user != null) {
                result = "exist";
            } else {
                result = "ok";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    public void saveNewUser() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            User user = new User();
            user.setUserName(userName);
            user = userServices.queryUserByBean(user);
            if (user != null) {
                result = "exist";
            } else {
                user = new User();
                user.setUserName(userName);
                user.setPassword(MD5Utils.strToMD5(password));
                user.setRealName(realName);
                user.setCreateTime(DateUtils.getNowTime());
                user.setStatus("1");
                userServices.insertUser(user);
                result = "success";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }

    public void saveEditUser() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            String result;
            User user = new User();
            user.setId(id);
            user = userServices.queryUserByBean(user);
            if (user != null) {
                user.setPassword(MD5Utils.strToMD5(password));
                user.setRealName(realName);
                userServices.updateUser(user);
                result = "success";
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public void deleteUser() {
        PrintWriter pw = null;
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            User userInSession = (User) this.getRequest().getSession().getAttribute("userInSession");
            String result;
            User user = new User();
            user.setId(id);
            user = userServices.queryUserByBean(user);
            int size = userServices.countUserByCreatePid(id);
            if (user != null) {
                if (userInSession.getUserName().equals(user.getUserName())) {
                    result = "self";
                } else if (("admin").equals(user.getUserName())) {
                    result = "admin";
                } else {
                    this.userRoleServices.deleteUserRoleByUser(user);
                    if (size > 0) {
                        this.userServices.hideUser(user);
                    } else {
                        this.userServices.deleteUser(user);
                    }
                    result = "success";
                }
            } else {
                result = "fail";
            }
            pw.write(result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
    }


    public UserServices getUserServices() {
        return userServices;
    }

    public void setUserServices(UserServices userServices) {
        this.userServices = userServices;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
}
