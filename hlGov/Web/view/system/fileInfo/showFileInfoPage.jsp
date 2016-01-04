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
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>

var newFileInfo_page = {

	    saveEditFileInfo:function(){
	    	var flag = true;
            var title = $("#title").val();
            var catalogID = $("#catalogID").val();
            var releaseDate = $("#releaseDate").val();
            var isshow = $("#isshow").val();
            var uploadinfo = $("#uploadinfo").val();
            var theID = $("#theID").val();
            if(title==""){
            	flag=false;
            	alert("标题不能为空");
            	return false;
            } 
            if(releaseDate==""){
            	flag=false;
            	alert("发布时间不能为空");
            	return false;
            }
            if(flag){
				var urlFile = "${ctx}/fileInfo/saveTheEditFile.action";
				var fileParam = {};
				fileParam.theID = theID;
				fileParam.title = title;
				fileParam.fileType = "1";
				fileParam.sort = 0;
				fileParam.isshow = isshow;
	            fileParam.isindex = "1";
	            fileParam.releaseDate = releaseDate;
	            fileParam.catalogID=catalogID;
	            $.post(urlFile,fileParam,function(data1){
					if(data1.result=='success'){
						if(uploadinfo!=''){
							$.ajaxFileUpload({
								url:'${ctx}/fileInfo/coverOldFile.action?theID='+data1.fileInfoID,            //需要链接到服务器地址
								secureuri:false,
		                        fileElementId:'uploadinfo',                        //文件选择框的id属性
		                        dataType: 'text',                                     //服务器返回的格式，可以是json
		                        success: function (data2,status)            //相当于java中try语句块的用法
		                        {
		            	          	alert("操作成功");
		                            window.location.href = "${ctx}/contents/contentsPage.action?catalogID="+catalogID;
		                        },
		                        error: function (data2, status, e)            //相当于java中catch语句块的用法
		                        {alert("操作失败!"+e);}
		                  	});
						}
					}
				},"json");
	   		}
	    }
	};
$(function(){
	
    $('#backContentsBtn').click(function() {
        window.location.href = "${ctx}/contents/contentsPage.action";
    });
    
});


</script>



<div id="newContentsWin" class="easyui-panel" title="新增文件" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save"  style="width: auto; height: 600px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
   <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </div>
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newRoleForm" method="post">
                <table class="formtable">
                	<tr>
                        <th>标题：</th>
                        <td colspan="3">
                        	<input id="theID" type="hidden" value="${fileInfo.theID }" />
                        	<input id="title" type="text" value="${fileInfo.title }" class="easyui-validatebox" data-options="required:true,validType:'length[1,40]'"/>
                        </td>
                    </tr>
                    <tr>
                        <th>所属栏目：</th>
                        <td colspan="3">
                        	<span>${catalog.title}</span>
                        	<input type="hidden" id="catalogID" value="${catalog.theID}"/>
                        </td>
                    </tr>
                    
                    <tr>
                   		<th>发布日期：</th>
                        <td colspan="3">
                        	<input id="releaseDate" type="text" width="100" readonly="readonly" value="${fileInfo.releaseDate }"/>
							<img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                    </tr>
                    <tr>
                   		<th>是否显示：</th>
                        <td colspan="3">
                        	<select id="isshow">
                        		<option value="1" <c:if test="${fileInfo.isshow==1 }">selected</c:if>>是</option>
                        		<option value="0" <c:if test="${fileInfo.isshow==0 }">selected</c:if>>否</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                    	<th>原文件：</th>
                    	<td colspan="3">
                    		${fileInfo.fileUrl }
                    	</td>
                    </tr>
                    <tr>
                    	<th>上传文件：</th>
                    	<td colspan="3">
                    		<input id="uploadinfo" type="file" name="uploadinfo" class="easyui-validatebox" />
                    	</td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newFileInfo_page.saveEditFileInfo()">
                保存</a> 
        </div>
    </div>
</div>


</body>
</html>