<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">

    <title>后台管理</title>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
    function onClickRow(index){
        $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#title_edit").val($('#dg').datagrid('getRows')[index]['title']);
        $("#catalogType_edit").val($('#dg').datagrid('getRows')[index]['catalogType']);
        $("#sort_edit").val($('#dg').datagrid('getRows')[index]['sort']);
        $("#status_edit").val($('#dg').datagrid('getRows')[index]['status']);
        $("#url_edit").val($('#dg').datagrid('getRows')[index]['url']);
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);
        if($('#dg').datagrid('getRows')[index]['catalogType']=='t_specialTopic'){
        	$("#catalogType_edit").attr("disabled",true);
        	$("#tr_pic").show();
        	$("#pic").show();
        	$("#img1").attr("src","${ctx}/uploads/zt/pic/"+$('#dg').datagrid('getRows')[index]['theID']+".jpg");
        }else{
        	$("#catalogType_edit").attr("disabled",false);
        	$("#tr_pic").hide();
        	$("#pic").hide();
        }
    }


    var openCatalog_page = {
        //设置新建用户
        initNewOpenCatalogWin:function () {
            $('#newOpenCatalogWin').window({
                title: '新建栏目',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },
        initEditOpenCatalogWin:function () {
            $('#editOpenCatalogWin').window({
                title: '编辑栏目',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable:false
            });
        },

        initDeleteOpenCatalogWin:function () {
            $('#deleteOpenCatalogWin').window({
                title: '删除栏目',
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
        closeNewOpenCatalogWin:function () {
            $('#newOpenCatalogWin').window('close');
        },

        closeEditOpenCatalogWin:function () {
            $('#editOpenCatalogWin').window('close');
        },

        closeDeleteOpenCatalogWin:function () {
            $('#deleteOpenCatalogWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        saveNewOpenCatalog:function (){
            var flag = true;
            var title1 = $("#title").val();
            var type1 = $("#catalogType").val();
            var sort1 = $("#sort").val();
            var url1 = $("#url").val();
            var status1 = $("#status").val();
            var isUploadPic1 = $("#isUploadPic").val();
            if(title1==""){
            	flag=false;
            	alert("栏目名称不能为空");
            	return false;
            }
            if(flag){
                var url = "${ctx}/opencatalog/saveNewOpenCatalog.action";
                var param = {};
                param.parentID = $("#parentID").val();
                param.title = title1;
                param.catalogType = type1;
                param.sort = sort1;
                param.url = url1;
                param.status = status1;
                param.isUploadPic = isUploadPic1;
                $.post(url,param,function(data){
                    if(data=="success"){
                        openCatalog_page.closeNewOpenCatalogWin();
                        $("#title").val("");
                        $("#sort").val("");
                        $("#url").val("");
                        var url = "${ctx}/opencatalog/openCatalogList.action";
                        var param = {};
                        param.parentID = $("#parentID").val();
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
            }
        },
        saveEditOpenCatalog:function (){
        	 var flag = true;
             var title1 = $("#title_edit").val();
             var type1 = $("#catalogType_edit").val();
             var sort1 = $("#sort_edit").val();
             var url1 = $("#url_edit").val();
             var status1 = $("#status_edit").val();
             var isUploadPic1 = $("#isUploadPic_edit").val();
             if(title1==""){
             	flag=false;
             	alert("栏目名称不能为空");
             	return false;
             }           
             if(flag){
                var url = "${ctx}/opencatalog/saveEditOpenCatalog.action";
                var param = {};
                param.theID = $("#theID_edit").val();
                param.parentID = $("#parentID").val();
                param.title = title1;
                param.catalogType = type1;
                param.sort = sort1;
                param.url = url1;
                param.status = status1;
                param.isUploadPic = isUploadPic1;               
                $.post(url,param,function(data){
                    if(data=="success"){
                        openCatalog_page.closeEditOpenCatalogWin();
                        var url = "${ctx}/opencatalog/openCatalogList.action";
                        var param = {};
                        param.parentID = $("#parentID").val();
                        $.post(url,param,function(data){
                            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                        },"json");
                    }
                },"text");
                $.ajaxFileUpload({
                    url:'${ctx}/opencatalog/uploader.action?theID='+$("#theID_edit").val(),            //需要链接到服务器地址
                    secureuri:false,
                    fileElementId:'uploadinfo',                        //文件选择框的id属性
                    dataType: 'json',                                     //服务器返回的格式，可以是json
                    success: function (data, status)            //相当于java中try语句块的用法
                    {},
                    error: function (data, status, e)            //相当于java中catch语句块的用法
                    {}
           	});
        }
        },
        
        deleteOpenCatalog:function (){
        	 if($("#theID_delete").val()==""){
                 return;
             }
            var url = "${ctx}/opencatalog/deleteOpenCatalog.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                    openCatalog_page.closeDeleteOpenCatalogWin();
                    var url = "${ctx}/opencatalog/openCatalogList.action";
                    var param = {};
                    param.parentID = $("#parentID").val();
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

        var url = "${ctx}/opencatalog/openCatalogList.action";
        var param = {};
        param.parentID="0";
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");


        //初始化新建窗口
        openCatalog_page.initNewOpenCatalogWin();
        //绑定事件
        $('#addOpenCatalogBtn').click(function() {
            $('#newOpenCatalogWin').window('open');
        });

        openCatalog_page.initEditOpenCatalogWin();
        $('#editOpenCatalogBtn').click(function() {
            if($("#theID_edit").val()==""){
                return;
            }
            $('#editOpenCatalogWin').window('open');
        });


        openCatalog_page.initDeleteOpenCatalogWin();
        $('#deleteOpenCatalogBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteOpenCatalogWin').window('open');
        });

        openCatalog_page.initInfoTipWin();
    });
    
    function showChilds(pid,nodeName){
    	var url = "${ctx}/opencatalog/openCatalogList.action";
        var param = {};
        $("#parentID").val(pid);
        param.parentID=pid;
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");
    }
    
    function changeValue(obj){
    	if(obj=='t_specialTopic'){
    		$("#isUploadPic").val("1");
    	}else{
    		$("#isUploadPic").val("0");
    	}
    }
    
</script>
<table width="100%">
<tr>
<td valign="top" width="170">
	<iframe src="${ctx}/view/system/opencatalog/openCatalogZTree.jsp" height="600" width="170" frameborder="0" scrolling="auto" id="leftframe"></iframe>
</td>
<td valign="top" width="90%">
<table id="dg" title="栏目列表" style="width:auto;height:600px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
    <thead>
    <tr>
        <th field="title" width="180"><input type="hidden" field="theID">栏目名</th>
        <th field="catalogTypeName" width="80"><input type="hidden" field="catalogType">栏目类型</th>
        <th field="sort" width="60">排列序号</th>
        <th field="url" width="250">链接URL</th>
        <th field="statusName" width="80"><input type="hidden" field="status">状态</th>
    </tr>
    </thead>
    
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addOpenCatalogBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editOpenCatalogBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteOpenCatalogBtn">删除</a>
    </div>
</td>
</tr>
</table>




<div id="newOpenCatalogWin" class="easyui-window" title="新建栏目" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="newOpenCatalogForm" method="post">
                <table cellpadding=3>
                	<input id="parentID" type="hidden" value="0"/>
                    <tr>
                        <td>栏目名称：</td>
                        <td><input id="title" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>栏目类型：</td>
                        <td>
                        	<select id="catalogType" onChange="changeValue(this.value)">
                        		<option value="0">-请选择-</option>
                        		<option value="t_contents">文章页面</option>
                        		<option value="t_video">视频页面</option>
                        		<option value="t_links">友情链接</option>
                        		<option value="t_fileinfo">资料页面</option>
                        		<option value="t_specialTopic">专题报道</option>
                        		<option value="t_services">便民服务</option>
                        	</select>
                        </td>
                    </tr>
                    <tr>
                        <td>排序：</td>
                        <td><input id="sort" value="1" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>链接URL：</td>
                        <td><input id="url" type="text" size="50" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status">
                        		<option value="1" selected="selected">启用</option>
                        		<option value="0">停用</option>
                        	</select>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="openCatalog_page.saveNewOpenCatalog()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="openCatalog_page.closeNewOpenCatalogWin()">取消</a>
        </div>
    </div>
</div>


<div id="editOpenCatalogWin" class="easyui-window" title="编辑栏目" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <form id="editOpenCatalogForm" method="post">
                <table cellpadding=3>                
                    <tr>
                        <td>栏目名称：</td>
                        <td><input id="title_edit" type="text" class="easyui-validatebox" data-options="required:true"/>
                         <input id="theID_edit" type="hidden"/>
                         <input id="parentID_edit" type="hidden" value="0"/>
                         <input type="hidden" id="isUploadPic_edit" value="1"/>
                        </td>
                    </tr>
                    <tr>
                        <td>栏目类型：</td>
                        <td>
                        	<select id="catalogType_edit">
                        		<option value="0">-请选择-</option>
                        		<option value="t_contents">文章页面</option>
                        		<option value="t_video">视频页面</option>
                        		<option value="t_links">友情链接</option>
                        		<option value="t_files">资料页面</option>
                        		<option value="t_specialTopic">专题报道</option>
                        	</select>
                        </td>
                    </tr>
                    <tr id="tr_pic">
                    	<td>上传缩略图</td>
                    	<td>
                    		<input type="file" id="uploadinfo" name="uploadinfo" class="easyui-validatebox" data-options="required:true"/>
                    	</td>
                    </tr>
                    <tr id="pic">
                    	<td>缩略图</td>
                    	<td>
                    		<img id="img1" src="" height="30" width="50"/>
                    	</td>
                    </tr>
                    <tr>
                        <td>排序：</td>
                        <td><input id="sort_edit" value="1" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>链接URL：</td>
                        <td><input id="url_edit" type="text" size="50" class="easyui-validatebox" data-options="required:true"/></td>
                    </tr>
                    <tr>
                        <td>状态：</td>
                        <td>
                        	<select id="status_edit">
                        		<option value="1" selected="selected">启用</option>
                        		<option value="0">停用</option>
                        	</select>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="openCatalog_page.saveEditOpenCatalog()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="openCatalog_page.closeEditOpenCatalogWin()">取消</a>
        </div>
    </div>
</div>


<div id="deleteOpenCatalogWin" class="easyui-window" title="删除栏目" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="openCatalog_page.deleteOpenCatalog()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="openCatalog_page.closeDeleteOpenCatalogWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="openCatalog_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>