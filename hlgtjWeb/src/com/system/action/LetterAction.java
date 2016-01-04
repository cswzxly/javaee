package com.system.action;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSONObject;
import com.system.pojo.Letter;
import com.system.services.LetterServices;

public class LetterAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	private String downPath;
	
	

	@Resource(name="letterServices")
	private LetterServices letterServices;	
	private String flag;
	private String isOpen;
	private String status;

	public String letterPage(){
		logger.info("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<flag="+flag);
		logger.info("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<isOpen="+isOpen);
		logger.info("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<status="+status);
		String result = "";
		try{
			if(flag != null && !"".equals(flag)){
				if(flag.equals("1")){
					result = "局长信箱";
				}else if(flag.equals("2")){
					result = "业务咨询";
				}else if(flag.equals("3")){
					result = "监督投诉";
				}
			}else{
				result = "信箱";
			}
			request.setAttribute("result", result);
			request.setAttribute("flag", flag);
			request.setAttribute("isOpen", isOpen);
			request.setAttribute("status", status);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "page";
	}
	
	public void queryLetterList(){
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>LetterAction:queryLetterList>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		PrintWriter pw = null;
        try{
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            Map<String,Object> map = new HashMap<String, Object>();
            List<Letter> listLetter = null;
            if((flag!=null)&&(flag!="")||(isOpen!=null)&&(flag!="")||(status!=null)&&(status!="")){
            	Letter letter = new Letter();
            	if((flag!=null)&&(flag!="")){
            		letter.setFlag(flag);
            		request.setAttribute("flag", flag);
            	}
            	if((isOpen!=null)&&(flag!="")){
            		letter.setIsOpen(isOpen);
            		request.setAttribute("isOpen", isOpen);
            	}
            	if((status!=null)&&(status!="")){
            		letter.setStatus(status);
            		request.setAttribute("status", status);
            	}
            	listLetter = letterServices.queryLetterLike(letter);   
            }else{
            	listLetter = letterServices.queryLetterList();
            }           
            listLetter = this.setFieldName(listLetter);
            map.put("total",listLetter.size());
            map.put("rows",listLetter);
            String result = JSONObject.toJSONString(map);
            pw.write(result);
        }catch (Exception e){
            e.printStackTrace();
        }
        pw.flush();
        pw.close();
	}
	
	public String queryLetterByLike(){
    	request.setAttribute("flag", request.getParameter("flag"));
    	request.setAttribute("isOpen", request.getParameter("isOpen"));
    	return SUCCESS;
	}
	
	public String queryLetterByBean(){
	    logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>theID="+request.getParameter("theID"));
        int theID = Integer.valueOf(request.getParameter("theID"));              
        Letter letter = new Letter();
        letter = letterServices.queryLetterByBean(theID);
        request.setAttribute("letter", letter);
        return SUCCESS;
	}
	 
	public String updateLetter(){
		Letter letter = new Letter();
		int theID = Integer.valueOf(request.getParameter("theID"));
		String isOpen = request.getParameter("isOpen");
		String replay = request.getParameter("replay");
		letter.setTheID(theID);
		letter.setReplay(replay);
		letter.setIsOpen(isOpen);
		letterServices.updateLetter(letter);
		if(replay!=null&&!"".equals(replay)){  //如果没有输入回复内容，则不改变状态
			Letter l = new Letter();
			l.setTheID(theID);
			l.setStatus("1");
			letterServices.updateLetter(l);
		}		
		return "success";
	}
	
	public InputStream getInputStream() throws Exception{
		String path = "uploads/web/letter/"+downPath;
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>path="+path);
		return ServletActionContext.getServletContext().getResourceAsStream(path);
	}
	
	public String getDownloadFileName(){
		String path = "uploads/web/letter/"+downPath;
		String downFileName = path.substring(path.lastIndexOf("/")+1);
		try{
			downFileName = new String(downFileName.getBytes(),"ISO8859-1");
		}catch(Exception e){
			e.printStackTrace();
		}
		logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>downFileName="+downFileName);
		return downFileName;
	}	
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	/**
	 * 将部分属性转成中文
	 * @param list
	 * @return
	 */
	private List<Letter> setFieldName(List<Letter> list){
		Iterator it = list.iterator();
    	while(it.hasNext()){
    		Letter letter = (Letter)it.next();
    		if(letter.getStatus().equals("1")){
    			letter.setStatus("已回复");
    		}else{
    			letter.setStatus("未回复");
    		} 
    		if(letter.getIsOpen().equals("0")){
    			letter.setIsOpen("不公开");
    		}else{
    			letter.setIsOpen("公开");
    		}
    		if(letter.getFlag().equals("1")){
    			letter.setFlagName("局长信箱");
    		}else if(letter.getFlag().equals("2")){
    			letter.setFlagName("业务咨询");
    		}else if(letter.getFlag().equals("3")){
    			letter.setFlagName("监督投诉");
    		}
    	}
		return list;
	}
	
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getIsOpen() {
		return isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}

	public String getDownPath() {
		return downPath;
	}

	public void setDownPath(String downPath) {
		this.downPath = downPath;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
