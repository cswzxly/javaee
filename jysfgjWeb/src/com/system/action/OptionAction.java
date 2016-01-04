package com.system.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Option;
import com.system.services.OptionServices;
import com.system.utils.DateUtils;

public class OptionAction extends BaseAction {

	@Autowired
	private OptionServices optionServices;

	private Option option;

	private String theID;
	private String item;
	private String code;
	private String content;
	private String mark;

	public String list() {
		List<Option> optionList = optionServices.queryOptionListByBean(option);
		request.setAttribute("optionList", optionList);
		return "list";
	}

	public void optionList() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			Map<String, Object> map = new HashMap<String, Object>();
			Option op = new Option();
			List<Option> list = optionServices.queryOptionListByBean(op);
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

	public void saveNewOption() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Option op = new Option();
			op.setCode(code);
			op.setItem(item);
			op.setContent(content);
			op.setMark(mark);
			op.setCreateTime(DateUtils.getNowTime());
			optionServices.insertOption(op);
			result = "success";

			pw.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public void saveEditOption() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Option op = new Option();
			op.setTheID(Integer.valueOf(theID));
			op = optionServices.queryOptionByBean(op);
			if (op != null) {
				op.setCode(code);
				op.setItem(item);
				op.setContent(content);
				op.setMark(mark);
				op.setUpdateTime(DateUtils.getNowTime());
				optionServices.updateOption(op);

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

	public void deleteOption() {
		PrintWriter pw = null;
		try {
			this.getResponse().setCharacterEncoding("UTF-8");
			pw = this.getResponse().getWriter();
			String result;
			Option op = new Option();
			op.setTheID(Integer.valueOf(theID));
			op = optionServices.queryOptionByBean(op);
			if (op != null) {
				optionServices.deleteOption(op);
				result = "success";
			} else {
				result = "fail";
			}
			pw.print(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		pw.flush();
		pw.close();
	}

	public OptionServices getOptionServices() {
		return optionServices;
	}

	public void setOptionServices(OptionServices optionServices) {
		this.optionServices = optionServices;
	}

	public Option getOption() {
		return option;
	}

	public void setOption(Option option) {
		this.option = option;
	}

	public String getTheID() {
		return theID;
	}

	public void setTheID(String theID) {
		this.theID = theID;
	}

	public String getItem() {
		return item;
	}

	public void setItem(String item) {
		this.item = item;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

}
