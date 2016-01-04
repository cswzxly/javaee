package com.system.action;


import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.OperationLog;
import com.system.pojo.Option;
import com.system.services.OperationLogServices;

public class OperationLogAction extends BaseAction {
	@Resource(name = "operationLogServices")
	private OperationLogServices operationLogServices;
	
	private OperationLog operationLog;
	
	public OperationLog getOperationLog() {
		return operationLog;
	}

	public void setOperationLog(OperationLog operationLog) {
		this.operationLog = operationLog;
	}

	public String operationLogPage(){
		return "success";
	}
	
	public void operationLogList() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			Map<String, Object> map = new HashMap<String, Object>();
			OperationLog operationLog = new OperationLog();
			List<OperationLog> list = operationLogServices.queryOperationLogByBean(operationLog);
			map.put("total",list.size());
            map.put("rows",list);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}
	
	public String showOperationLog(){
		String theID = request.getParameter("theID");
		if(theID != null && !"".equals(theID)){
			OperationLog operationLog =  operationLogServices.queryOperationLogById(Integer.valueOf(theID));
			request.setAttribute("operationLog", operationLog);
		}
		return "success";
	}

}
