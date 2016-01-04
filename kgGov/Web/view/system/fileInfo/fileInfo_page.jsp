<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">

    <title>图片资料管理</title>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
    function onClickRow(index){
        $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#title_edit").val($('#dg').datagrid('getRows')[index]['title']);
        $("#fileType_edit").val($('#dg').datagrid('getRows')[index]['fileType']);
        $("#sort_edit").val($('#dg').datagrid('getRows')[index]['sort']);
        $("#isshow_edit").val($('#dg').datagrid('getRows')[index]['isshow']);
//         $("#isindex_edit").val($('#dg').datagrid('getRows')[index]['isindex']);
        $("#contentID_edit").val($('#dg').datagrid('getRows')[index]['contentID']);
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);
//         if($('#dg').datagrid('getRows')[index]['fileType']=='1'){
//         	$("#pic").show();
//         	$("#img1").attr("src","${ctx}/"+$('#dg').datagrid('getRows')[index]['fileUrl']);
//         	$("#tr_edit_index").show();
//         }else{
//         	$("#pic").hide();
//         	$("#tr_edit_index").hide();
//         }
    }


    var fileInfo_page = {
        //设置新建用户
        initNewFileInfoWin:function () {
            $('#newFileInfoWin').window({
                title: '新建图片资料',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },
        initEditFileInfoWin:function () {
            $('#editFileInfoWin').window({
                title: '编辑图片资料',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },

        initDeleteFileInfoWin:function () {
            $('#deleteFileInfoWin').window({
                title: '删除图片资料',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable:false
            });
        },

        initInfoTipWin:function () {
            $('#infoTipWin').window({
                title: '提示信息',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable:false
            });
        },

        //关闭新建用户
        closeNewFileInfoWin:function () {
            $('#newFileInfoWin').window('close');
        },

        closeEditFileInfoWin:function () {
            $('#editFileInfoWin').window('close');
        },

        closeDeleteFileInfoWin:function () {
            $('#deleteFileInfoWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        saveNewFileInfo:function (){
            var flag = true;
            var contentID = $("#contentID").val();
            var title = $("#title").val();
            var sort = $("#sort").val();
            var fileType = $("#fileType").val();
            var isshow = $("#isshow").val();
//             var isindex = $("#isindex").val();
            var uploadinfo = $("#uploadinfo").val();
            if(title==""){
            	flag=false;
            	alert("图片（文件）名称不能为空！");
            	return false;
            }
            if(uploadinfo==""){
            	flag=false;
            	alert("上传图片（文件）不能为空！");
            	return false;
            }
            if(flag){
                var url = "${ctx}/fileInfo/saveNewFileInfo.action";
                var param = {};
                param.contentID = contentID;
                param.title = title;
                param.fileType = fileType;
                param.sort = sort;
                param.isshow = isshow;
//                 param.isindex = isindex;
                $.post(url,param,function(data){
                
                   if(data.result=='success'){
                    	
                    	$.ajaxFileUpload({
                            url:'${ctx}/fileInfo/uploader.action?theID='+data.fileInfoID,            //需要链接到服务器地址
                            secureuri:false,
                            fileElementId:'uploadinfo',                        //文件选择框的id属性
                            dataType: 'text',                                     //服务器返回的格式，可以是json
                            success: function (data1,status)            //相当于java中try语句块的用法
                            {alert("操作成功");},
                            error: function (data1, status, e)            //相当于java中catch语句块的用法
                            {alert("操作失败!"+e);}
                   		});
                    	
                        fileInfo_page.closeNewFileInfoWin();
                        $("#title").val("");
                        $("#sort").val("");
                        $("#isshow").val("1");
//                         $("#isindex").val("0");
                        var url = "${ctx}/fileInfo/fileInfoList.action";
                        var param = {};
                        param.contentID=contentID;
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                   }
                },"json");
                
                
            }
        },
        
        saveEditFileInfo:function (){
        	 var flag = true;
             var title1 = $("#title_edit").val();
             var sort1 = $("#sort_edit").val();
             var fileType1 = $("#fileType_edit").val();
             var isshow1 = $("#isshow_edit").val();
//              var isindex1 = $("#isindex_edit").val();
             var contentID = $("#contentID_edit").val();
             if(title1==""){
             	flag=false;
             	alert("文件名称不能为空");
             	return false;
             }           
             if(flag){
                var url = "${ctx}/fileInfo/saveEditFileInfo.action";
                var param = {};
                param.theID = $("#theID_edit").val();
                param.title = title1;
                param.fileType = fileType1;
                param.sort = sort1;
                param.isshow = isshow1;
//                 param.isindex = isindex1;
                
                $.post(url,param,function(data){
                    if(data=="success"){
                    	
                        fileInfo_page.closeEditFileInfoWin();
                        var url = "${ctx}/fileInfo/fileInfoList.action";
                        var param = {};
                        param.contentID=contentID;
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                   }
                },"text");
               
        	}
        },
        
        deleteFileInfo:function (){
        	
        	if($("#theID_delete").val()==""){
                return;
            }
        	var contentID = $("#contentID").val();
            var url = "${ctx}/fileInfo/deleteFileInfo.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    fileInfo_page.closeDeleteFileInfoWin();
                    var url = "${ctx}/fileInfo/fileInfoList.action";
                    var param = {};
                    param.contentID=contentID;
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }
            },"text");
        }
        
    };




    //加载数据
    function pagerFilter(data){
        if (typeof data.length == 'number' && typeof data.splice == 'function'){	// is array
            data = {
                total: data.length,
                rows: data
            }
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage:function(pageNum, pageSize){
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh',{
                    pageNumber:pageNum,
                    pageSize:pageSize
                });
                dg.datagrid('loadData',data);
            }
        });
        if (!data.originalRows){
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber-1)*parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }

    $(function(){
        var url = "${ctx}/fileInfo/fileInfoList.action?open="+$('#open').val();
        var param = {};
        var contentID = "${contentID}";
        param.contentID=contentID;
        
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");


        $('#backContentsBtn').click(function() {
        	window.location.href = "${ctx}/contents/contentsPage.action";        	      
        });
        
        $('#backOpenContentsBtn').click(function() {
        	window.location.href = "${ctx}/opencontents/openContentsPage.action";        	      
        });
        
        //初始化新建窗口
        fileInfo_page.initNewFileInfoWin();
        $('#addFileInfoBtn').click(function() {
            $('#newFileInfoWin').window('open');
        });

        fileInfo_page.initEditFileInfoWin();
        $('#editFileInfoBtn').click(function() {
            if($("#theID_edit").val()==""){
                return;
            }
            $('#editFileInfoWin').window('open');
        });


        fileInfo_page.initDeleteFileInfoWin();
        $('#deleteFileInfoBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteFileInfoWin').window('open');
        });

        fileInfo_page.initInfoTipWin();
    });
    
//     function changeFileType(){
//     	var fileType = $("#fileType").val();
//     	if(fileType == '1'){
//     		$("#tr_new_index").show();
//     	}else{
//     		$("#tr_new_index").hide();
//     	}
//     }
    
//     function checkIndex(){
//     	var contentID = $("#contentID").val();
//     	var url = "${ctx}/fileInfo/checkIndex.action";
//     	var param = {};
//         param.contentID = contentID;
//         $.post(url,param,function(data){
//         	if(data == '1'){
//         		alert("已有首页显示图片，不能重复选择");
//         		$("#isindex").val('0');
//         	}
//         },"json");
//     }
    
//     function checkEditIndex(){
//     	var contentID = $("#contentID_edit").val();
//     	var url = "${ctx}/fileInfo/checkIndex.action";
//     	var param = {};
//         param.contentID = contentID;
//         $.post(url,param,function(data){
//         	if(data == '1'){
//         		alert("已有首页显示图片，不能重复选择");
//         		$("#isindex_edit").val('0');
//         	}
//         },"json");
//     }
</script>
<input type="hidden" value="${open }" name="open" id="open">
<table width="100%">
<tr>
<td valign="top" width="90%">
<table id="dg" title="文件列表" style="width:650px;height:600px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
    <thead>
    <tr>
        <th field="title"  width="350"><input type="hidden" field="theID">附件名</th>
        <th field="fileTypeName" width="150"><input type="hidden" field="fileType">文件类型</th>
        <th field="sort" width="60">排列序号</th>
        <th field="isshowName" width="80"><input type="hidden" field="isshow">是否显示</th>
<!--         <th field="isindexName" width="80"><input type="hidden" field="isshow">是否首页显示</th> -->
    </tr>
    </thead>
    
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addFileInfoBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editFileInfoBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteFileInfoBtn">删除</a>
    <c:if test="${open!=null }">
    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backOpenContentsBtn">返回</a>
    </c:if>
    <c:if test="${open==null }">
    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backContentsBtn">返回</a>
    </c:if>
    </div>
</td>
</tr>
</table>




<div id="newFileInfoWin" class="easyui-window" title="新建图片资料" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
     background: #fafafa;" data-options="left:'250px',top:'200px'"> 
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newFileInfoForm" method="post">
                <table cellpadding=3>
                	<input id="contentID" type="hidden" value="${contentID}"/>
                    <tr>
                        <td>名称：</td>
                        <td><input id="title" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>文件类型：</td>
                        <td>
                        	<select id="fileType" >
                         		<option value="1">图片</option>
                        		<option value="2">文件</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                        <td>上传：</td>
                        <td><input id="uploadinfo" type="file" name="uploadinfo" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>排序：</td>
                        <td><input id="sort" value="0" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>               
                    <tr>
                        <td>是否显示：</td>
                        <td>
                        	<select id="isshow">
                        		<option value="1">是</option>
                        		<option value="0">否</option>
                        	</select>
                        </td>
                    </tr>
<!--                     <tr id="tr_new_index"> -->
<!--                         <td>是否首页显示：</td> -->
<!--                         <td> -->
<!--                         	<select id="isindex" onchange="checkIndex();"> -->
<!--                         		<option value="0">否</option> -->
<!--                         		<option value="1">是</option> -->
<!--                         	</select> -->
<!--                         	（注：首页图片只能选择一张图片） -->
<!--                         </td> -->
<!--                     </tr> -->
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="fileInfo_page.saveNewFileInfo();">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="fileInfo_page.closeNewFileInfoWin()">取消</a>
        </div>
    </div>
</div>


<div id="editFileInfoWin" class="easyui-window" title="编辑图片资料" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
         background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newFileInfoForm" method="post">
                <table cellpadding=3>
                	<input id="contentID_edit" type="hidden" value="${contentID}"/>
                	<input id="theID_edit" type="hidden" value="${theID}"/>
                    <tr>
                        <td>名称：</td>
                        <td><input id="title_edit" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>文件类型：</td>
                        <td>
                        	<select id="fileType_edit" disabled>
                        		<option value="1">图片</option>
                        		<option value="2">文件</option>
                        	</select>
                        </td>
                    </tr>
<!--                     <tr> -->
<!--                         <td>上传：</td> -->
<!--                         <td><input id="uploadinfo" type="file" name="uploadinfo"/></td> -->
<!--                     </tr> -->
					<tr id="pic">
                    	<td>缩略图</td>
                    	<td>
                    		<img id="img1" src="" height="30" width="50"/>
                    	</td>
                    </tr>
                    <tr>
                        <td>排序：</td>
                        <td><input id="sort_edit" value="0" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>               
                    <tr>
                        <td>是否显示：</td>
                        <td>
                        	<select id="isshow_edit">
                        		<option value="1">是</option>
                        		<option value="0">否</option>
                        	</select>
                        </td>
                    </tr>
<!--                     <tr id="tr_edit_index"> -->
<!--                         <td>是否首页显示：</td> -->
<!--                         <td> -->
<!--                         	<select id="isindex_edit" onchange="checkEditIndex();"> -->
<!--                         		<option value="0">否</option> -->
<!--                         		<option value="1">是</option> -->
<!--                         	</select> -->
<!--                         	（注：首页图片只能选择一张图片） -->
<!--                         </td> -->
<!--                     </tr> -->
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="fileInfo_page.saveEditFileInfo()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="fileInfo_page.closeEditFileInfoWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteFileInfoWin" class="easyui-window" title="删除文件" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
         background: #fafafa;" data-options="left:'250px',top:'200px'"> 
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="fileInfo_page.deleteFileInfo()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="fileInfo_page.closeDeleteFileInfoWin()">取消</a>
        </div>
    </div>
</div>


<div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label id="info_tip"></label>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="fileInfo_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>