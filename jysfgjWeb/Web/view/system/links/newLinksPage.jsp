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
	/* newContents_page.initInfoTipWin(); */

    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+$("#catalogID").val();
    });
    
});

function checkLinks(){
    var title = $("#title").val();
    var upload = $("#upload").val();
    var linkType = $("#link_type").val();
    var link_url = $("#link_url").val();
//     var strRegex = "(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?";
//     var re = new RegExp(strRegex);
	// var strRegex = "^((https|http|ftp|rtsp|mms)?://)" 
 //     + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@ 
 //           + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184 
 //           + "|" // 允许IP和DOMAIN（域名）
 //           + "([0-9a-z_!~*'()-]+\.)*" // 域名- www. 
 //           + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名 
 //           + "[a-z]{2,6})" // first level domain- .com or .museum 
 //           + "(:[0-9]{1,4})?" // 端口- :80 
 //           + "((/?)|" // a slash isn't required if there is no file name 
 //           + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$"; 
 //    var re=new RegExp(strRegex); 
    if(title==""){
    	alert("标题不能为空！");
    	return false;
    }
    if(link_url == ""){
    	alert("链接地址不能为空！");
    	return false;
    }
    // else if(link_url != ""){
    // 	if(!re.test(link_url)){
    // 		alert("链接地址填写不符合规范，请重新填写！");
    // 		return false;
    // 	}
    // }
    if(linkType==1){
	    if(upload == ""){
	    	alert("上传图片不能为空！");
	    	return false;
	    }
    }
    
    return true;
}

function changeLinkType(){
	var linkType = $("#link_type").val();
	if(linkType == 1){
		$("#tr_pic").css("display","block");
		$("#tr_select").css("display","none");
// 		$("tr_pic").show();
// 		$("tr_select").hide();
	}else if(linkType == 2){
		$("#tr_pic").css("display","none");
		$("#tr_select").css("display","block");
// 		$("tr_pic").hide();
// 		$("tr_select").show();
	}
}
</script>



<div id="newContentsWin" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: 750px; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post" action="${ctx}/links/saveLinks.action" enctype="multipart/form-data" onSubmit="return checkLinks();">
                <table class="formtable">
                    <tr>
                        <td>所属栏目：</td>
                        <td>
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="catalogID" name="links.catalogID" value="${catalog.theID}"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>标题：</td>
                        <td><input id="title" name="links.title" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[3,40]'"/></td>
                    </tr>
                    <tr>
                        <td><span style="color:red">*</span>链接地址：</td>
                        <td>
                        	http://<input id="link_url" name="links.link_url" type="text" />
                        </td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status" name="links.status">
                        		<option value="1">启用</option>
                        		<option value="0">停用</option>
                        	</select>
                        </td>
                    </tr>
                    <c:if test="${catalog.catalogType=='t_links' }">
                    	<tr>
	                        <td>链接类型：</td>
	                        <td>
								<select id="link_type" name="links.link_type" onchange="changeLinkType();">
									<option value="1">图片</option>
									<option value="2">所属框</option>
								</select>
								<input type="hidden" id="linkKind" name="links.linkKind" value="1"/>
	                        </td>
                        
                    	</tr>
                    	<tr id="tr_pic">
	                    	<td><span style="color:red">*</span>上传图片：</td>
	                    	<td>
	                    		<input type="file" id="upload" name="upload" />
	                    	</td>
                    	</tr>
	                    <tr id="tr_select" style="display:none;">
	                    	<td><span style="color:red">*</span>所属框：</td>
	                    	<td>
	                    		<select id="select_type" name="links.select_type">
									<c:forEach items="${linksMap }" var="item">
										<option value="${item.key}">${item.value}</option>
									</c:forEach>
								</select>
	                    	</td>
	                    </tr>
                    </c:if>
                    <c:if test="${catalog.catalogType=='t_services' }">
                        <input type="hidden" id="linkKind" name="links.linkKind" value="2"/>
                        <tr id="tr_pic">
	                    	<td><span style="color:red">*</span>上传图片:</td>
	                    	<td>
	                    		<input type="file" id="upload" name="upload" />
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