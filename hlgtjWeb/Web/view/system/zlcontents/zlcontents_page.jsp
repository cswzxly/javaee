<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理</title>
</head>
<body>
<script>
    function onClickRow(index){
//         $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);       
    }


    var contents_page = {     

        initDeleteContentsWin:function () {
            $('#deleteContentsWin').window({
                title: '删除内容',
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
     

        closeDeleteContentsWin:function () {
        	 if($("#theID_delete").val()==""){
        		 alert("请选择要删除的数据");
                 return;
             }
            $('#deleteContentsWin').window('close');
        },

        closeInfoTipWin:function () {
            $('#infoTipWin').window('close');
        },

        
        zldeleteContents:function (){
            var url = "${ctx}/zlcontents/zldeleteContents.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                	contents_page.closeDeleteContentsWin();
                	var url = "${ctx}/zlcontents/zlcontentsList.action";
                    var param = {};
                    var catalogID = '${catalogID}';
                    if(catalogID=="") catalogID="10";
                    param.catalogID=catalogID;
                    $("#catalogID").val(catalogID);
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

        var url = "${ctx}/zlcontentsList.action";
        var param = {};
        var catalogID = '${catalogID}';
        var catalogType = '${catalog.catalogType}';
        if(catalogID=="") catalogID="34";
        param.catalogID=catalogID;
        $("#catalogID").val(catalogID);
        $.post(url,param,function(data){
        	catalogType = data.catalogType;
        	$("#catalogType").val(catalogType);
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
        },"json");

        $('#addContentsBtn').click(function() { 
        	if($("#catalogID").val()==""){
        		return;
        	} 
        	if($("#catalogType").val()=='t_contents'){
				window.location.href = "${ctx}/zlcontents/zlnewContentsPage.action?catalogID="+$("#catalogID").val();
        	}else if($("#catalogType").val()=='t_links'){
        		alert("该栏目是跳转链接，无需在本站添加文章");
        		return;
        	}
        });

        $("#editContentsBtn").click(function(){      
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	if($("#catalogType").val()=='t_contents'){
        		window.location.href = "${ctx}/zlcontents/zlshowContentsEdit.action?theID="+$("#theID_delete").val();
        	}else if($("#catalogType").val()=='t_links'){
        		alert("该栏目是跳转链接，无需在本站修改文章");
        		return;
        	}
        });
        
        contents_page.initDeleteContentsWin();
        $('#deleteContentsBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteContentsWin').window('open');
        });

        contents_page.initInfoTipWin();
    });
    
    function showChilds(pid,nodeName){
    	var url = "${ctx}/zlcontentsList.action";
        var param = {};
        $("#catalogID").val(pid);
        param.catalogID=pid;
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
            var title_value=$("#table_title");
            title_value.text("");
            title_value.append(data.catalogName);
        },"json");
    }
    
    
</script>
<table width="100%">
<tr>
<td  valign="top" width="170">
<iframe src="${ctx}/view/system/zlcontents/zlcatalogZTree.jsp" height="600" width="170" frameborder="0" scrolling="auto" id="leftframe"></iframe>
</td>
<td valign="top" width="90%">
<table id="dg" title="<div id='table_title'>${catalog.title}" style="width:auto;height:600px" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
    <thead>
    <tr>
        <th field="title" width="350"><input type="hidden" field="theID">标题</th>
		<th field="catalogName" width="150">所属栏目</th>
        <th field="releaseDate" width="150">发布时间</th>
        <th field="source" width="80">来源</th>
        <th field="statusName" width="30"><input type="hidden" field="status">状态</th>
    </tr>
    </thead>
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addContentsBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editContentsBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteContentsBtn">删除</a>
</div>
</table>
</td>
</tr>
</table>




<div id="deleteContentsWin" class="easyui-window" title="删除内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
            <input type="hidden" id="catalogID" value="10">
            <input type="hidden" id="catalogType">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.zldeleteContents()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeDeleteContentsWin()">取消</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>


</body>
</html>