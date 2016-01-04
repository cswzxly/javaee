<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容新建</title>
    <link rel="stylesheet" href="${ctx}/resources/kindeditor/themes/default/default.css"/>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/kindeditor-min.js"></script>
    <script charset="utf-8" src="${ctx}/resources/kindeditor/lang/zh_CN.js"></script>
</head>
<body>
<script>


$(function(){
// 	newContents_page.initInfoTipWin();

    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
    });
    
});

function checkLinks(){
    var title = $("#title").val();
    var link_url = $("#link_url").val();
	var strRegex = "^((https|http|ftp|rtsp|mms)?://)" 
     + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@ 
           + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184 
           + "|" // 允许IP和DOMAIN（域名）
           + "([0-9a-z_!~*'()-]+\.)*" // 域名- www. 
           + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名 
           + "[a-z]{2,6})" // first level domain- .com or .museum 
           + "(:[0-9]{1,4})?" // 端口- :80 
           + "((/?)|" // a slash isn't required if there is no file name 
           + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"; 
    var re=new RegExp(strRegex); 
    if(title==""){
    	alert("标题不能为空！");
    	return false;
    }
    if(link_url == ""){
    	alert("链接地址不能为空！");
    	return false;
    }else if(link_url != ""){
    	if(!re.test(link_url)){
    		alert("链接地址填写不符合规范，请重新填写！");
    		return false;
    	}
    }
    
    return true;
}


</script>



<div id="newContentsWin" class="easyui-panel" title="编辑内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: 750px; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post" action="${ctx}/links/updateLinks.action" onSubmit="return checkLinks();">
                <table cellpadding=3>
                    <tr>
                        <td>所属栏目：</td>
                        <td>
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="catalogID" name="links.catalogID" value="${catalog.theID}"/>
                        	<input type="hidden" id="theID" name="links.theID" value="${links.theID }">
                        </td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>标题：</td>
                        <td>
                        	<input id="title" name="links.title" type="text" value="${links.title}" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>链接地址：</td>
                        <td>
                        	<input id="link_url" name="links.link_url" type="text" value="${links.link_url }"/>
                        </td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status" name="links.status">
                        		<option value="1" <c:if test="${links.status==1}">selected</c:if>>启用</option>
                        		<option value="0" <c:if test="${links.status==0}">selected</c:if>>停用</option>
                        	</select>
                        </td>
                    </tr>
                    <c:if test="${catalog.catalogType=='t_links' }">
                    	<tr>
	                        <td>链接类型：</td>
	                        <td>
	                        	<c:if test="${links.link_type==1 }">
	                        		图片
	                        	</c:if>
	                        	<c:if test="${links.link_type==2 }">
	                        		下拉框
	                        	</c:if>
	                        	<input type="hidden" id="link_type" name="links.link_type" value="${links.link_type}"/>
								<input type="hidden" id="linkKind" name="links.linkKind" value="1"/>
	                        </td>
                    	</tr>
                    	<c:if test="${links.link_type==1 }">
	                    	<tr>
		                    	<td><span style="color:red">*</span>上传图片：</td>
		                    	<td>
									<img src="${ctx}/${links.pic_url}" alt=""/>
		                    	</td>
	                    	</tr>
                    	</c:if>
                    	
                    	<c:if test="${links.link_type==2 }">
		                    <tr>
		                    	<td>所属下拉：</td>
		                    	<td>
		                    		<select id="select_type" name="links.select_type">
										<option value="1" <c:if test="${links.select_type==1}">selected</c:if>>-中央政府部门网站-</option>
										<option value="2" <c:if test="${links.select_type==2}">selected</c:if>>-省市政府部门网站-</option>
										<option value="3" <c:if test="${links.select_type==3}">selected</c:if>>-省级机关网站-</option>
										<option value="4" <c:if test="${links.select_type==4}">selected</c:if>>-公共服务单位网站-</option>
										<option value="5" <c:if test="${links.select_type==5}">selected</c:if>>-其他友情连接-</option>
									</select>
		                    	</td>
		                    </tr>
	                    </c:if>
                    </c:if>
                    <c:if test="${catalog.catalogType=='t_services' }">
                        <input type="hidden" id="linkKind" name="links.linkKind" value="2"/>
                        <tr id="tr_pic">
	                    	<td><span style="color:red">*</span>上传图片：</td>
	                    	<td>
	                    		<img src="${ctx}/${links.pic_url}" alt=""/>
	                    	</td>
                    	</tr>
                    </c:if>
                    
                </table>
                <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
                	<input type="submit" class="easy-linkbutton" value="保存"/>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- <div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false" -->
<!--      maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px; -->
<!--         background: #fafafa;" data-options="left:'250px',top:'200px'"> -->
<!--     <div class="easyui-layout" fit="true"> -->
<!--         <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;"> -->
<!--             <label id="info_tip"></label> -->
<!--         </div> -->
<!--         <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;"> -->
<!--             <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="newContents_page.closeInfoTipWin()"> -->
<!--                 确认</a> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->
</body>
</html>