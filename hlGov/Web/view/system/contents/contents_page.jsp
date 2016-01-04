<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容管理</title>
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
        changeTopNewsWin:function () {
            $('#changeTopNewsWin').window({
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
        closeChangeTopNewsWin:function () {
        	if($("#theID_delete").val()==""){
        		alert("请选择要作为头条的新闻");
        		return;
        	}
            $('#changeTopNewsWin').window('close');
        },
        
        deleteContents:function (){
        	var catalogType = $("#catalogType").val();
        	var url;
           	if(catalogType == "t_contents"){
        		url = "${ctx}/contents/deleteContents.action";
           	}else if(catalogType == "t_video"){
           		url = "${ctx}/video/deleteVideo.action";
           	}else if(catalogType == "t_links" || catalogType == "t_services"){
           		url = "${ctx}/links/deleteLinks.action";
        	}else if(catalogType == "t_opinionPoll"){
        		url = "${ctx}/opinionPoll/deleteOpinionPoll.action";
        	}else if(catalogType == "t_files"){
        		url = "${ctx}/fileInfo/deleteFileInfo.action";
        	}else{
           		url = "";
           	}
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url,param,function(data){
                if(data=="success"){
                	contents_page.closeDeleteContentsWin();
                	var url = "${ctx}/contents/contentsList.action";
                    var param = {};
                    var catalogID = $("#catalogID").val();
                    if(catalogID=="") catalogID="0";
                    param.catalogID=catalogID;
                    $("#catalogID").val(catalogID);
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
                }else if(data=="other"){
                	contents_page.closeDeleteContentsWin();
                	alert("该数据存在关联数据，无法删除！");
                }
            },"text");
        },
        changeTopNews:function(){
        	var url = "${ctx}/contents/changeTopNews.action";
        	var contentsID = $("#theID_delete").val();
    		var param = {};
    		var catalogID = $("#catalogID").val();
    		param.theID = contentsID;
    		param.catalogID=catalogID;
    		$.post(url,param,function(data){
    			if(data=='1'){
    				contents_page.closeChangeTopNewsWin();
                	var url = "${ctx}/contents/contentsList.action";
                    var param = {};
                    
                    if(catalogID=="") catalogID=";0";
                    param.catalogID=catalogID;
                    $("#catalogID").val(catalogID);
                    $.post(url,param,function(data){
                        $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
                    },"json");
    			}
    		},"json");
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
    	
        var url = "${ctx}/contents/contentsList.action";
        var param = {};
        var catalogID = '${catalogID}';
        var catalogType = '${catalog.catalogType}';
        var parentID = '${catalog.parentID}';
        if(catalogID=="") catalogID="0";
        param.catalogID=catalogID;
        $("#catalogID").val(catalogID);
        $("#catalogType").val(catalogType);
        $("#parenID").val(parentID);
        $.post(url,param,function(data){
        	 if (data.code == "00") {
                 alert("权限不足，请联系管理员！");
             } else {
	            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
	            if(catalogType=='t_contents'){
	            	$('#dg').datagrid("hideColumn","linkTypeName");
	            	$('#dg').datagrid("hideColumn","selectTypeName");
	            	$('#dg').datagrid("hideColumn","link_url");
	            	$('#dg').datagrid("hideColumn","isindexName");
	            	$('#dg').datagrid("hideColumn","beginDate");
	            	$('#dg').datagrid("hideColumn","endDate");
	            	$('#dg').datagrid("hideColumn","isCollectName");
	            	$('#dg').datagrid("hideColumn","isshowName");
	            	$('#dg').datagrid("showColumn","statusName");
	            	$('#dg').datagrid("showColumn","viewedNum");
	            	$('#dg').datagrid("hideColumn","downloadNum");
	            	$('#opinionPollInfoBtn').hide();
	            	if(parentID == 9){
	                	$('#fileInfoListBtn').hide();
	                	$('#topNewsBtn').show();
	                	$('#dg').datagrid("showColumn","isTopName");
	                }else{
	                	$('#fileInfoListBtn').show();
	                	$('#topNewsBtn').hide();
	                	$('#dg').datagrid("hideColumn","isTopName");
	                }
	            	$('#frontContentsBtn').show();
	            }else if(catalogType=='t_video'){
	            	$('#dg').datagrid("hideColumn","linkTypeName");
	            	$('#dg').datagrid("hideColumn","selectTypeName");
	            	$('#dg').datagrid("hideColumn","link_url");
	            	$('#dg').datagrid("showColumn","isindexName");
	            	$('#dg').datagrid("hideColumn","isTopName");
	            	$('#dg').datagrid("hideColumn","beginDate");
	            	$('#dg').datagrid("hideColumn","endDate");
	            	$('#dg').datagrid("hideColumn","isCollectName");
	            	$('#dg').datagrid("hideColumn","isshowName");
	            	$('#dg').datagrid("showColumn","statusName");
	            	$('#dg').datagrid("showColumn","viewedNum");
	            	$('#dg').datagrid("hideColumn","downloadNum");
	            	$('#opinionPollInfoBtn').hide();
	            	$('#fileInfoListBtn').hide();
	            	$('#topNewsBtn').hide();
	            	$('#frontContentsBtn').hide();
	            }else if(catalogType=='t_links'){
	            	$('#dg').datagrid("showColumn","linkTypeName");
	            	$('#dg').datagrid("showColumn","selectTypeName");
	            	$('#dg').datagrid("showColumn","link_url");
	            	$('#dg').datagrid("hideColumn","isindexName");
	            	$('#dg').datagrid("hideColumn","releaseDate");
	            	$('#dg').datagrid("hideColumn","source");
	            	$('#dg').datagrid("hideColumn","isTopName");
	            	$('#dg').datagrid("hideColumn","beginDate");
	            	$('#dg').datagrid("hideColumn","endDate");
	            	$('#dg').datagrid("hideColumn","isCollectName");
	            	$('#dg').datagrid("hideColumn","isshowName");
	            	$('#dg').datagrid("showColumn","statusName");
	            	$('#dg').datagrid("hideColumn","viewedNum");
	            	$('#dg').datagrid("hideColumn","downloadNum");
	            	$('#opinionPollInfotn').hide();
	            	$('#fileInfoListBtn').hide();
	            	$('#topNewsBtn').hide();
	            	$('#frontContentsBtn').show();
	            }else if(catalogType=='t_services'){
	            	$('#dg').datagrid("hideColumn","releaseDate");
	            	$('#dg').datagrid("hideColumn","source");
	            	$('#dg').datagrid("hideColumn","linkTypeName");
	            	$('#dg').datagrid("hideColumn","selectTypeName");
	            	$('#dg').datagrid("hideColumn","isindexName");
	            	$('#dg').datagrid("showColumn","link_url");
	            	$('#dg').datagrid("hideColumn","isTopName");
	            	$('#dg').datagrid("hideColumn","beginDate");
	            	$('#dg').datagrid("hideColumn","endDate");
	            	$('#dg').datagrid("hideColumn","isCollectName");
	            	$('#dg').datagrid("hideColumn","isshowName");
	            	$('#dg').datagrid("showColumn","statusName");
	            	$('#dg').datagrid("hideColumn","viewedNum");
	            	$('#dg').datagrid("hideColumn","downloadNum");
	            	$('#opinionPollInfoBtn').hide();
	            	$('#fileInfoListBtn').hide();
	            	$('#topNewsBtn').hide();
	            	$('#frontContentsBtn').show();
	            }else if(catalogType=='t_opinionPoll'){
	            	$('#dg').datagrid("showColumn","releaseDate");
	            	$('#dg').datagrid("hideColumn","source");
	            	$('#dg').datagrid("hideColumn","linkTypeName");
	            	$('#dg').datagrid("hideColumn","selectTypeName");
	            	$('#dg').datagrid("hideColumn","isindexName");
	            	$('#dg').datagrid("hideColumn","link_url");
	            	$('#dg').datagrid("hideColumn","isTopName");
	            	$('#dg').datagrid("showColumn","beginDate");
	            	$('#dg').datagrid("showColumn","endDate");
	            	$('#dg').datagrid("showColumn","isCollectName");
	            	$('#dg').datagrid("hideColumn","isshowName");
	            	$('#dg').datagrid("showColumn","statusName");
	            	$('#dg').datagrid("hideColumn","viewedNum");
	            	$('#dg').datagrid("hideColumn","downloadNum");
	            	$('#opinionPollInfoBtn').show();
	            	$('#fileInfoListBtn').hide();
	            	$('#topNewsBtn').hide();
	            	$('#frontContentsBtn').hide();
	            }else if(catalogType=='t_files'){
	            	$('#dg').datagrid("showColumn","releaseDate");
	            	$('#dg').datagrid("hideColumn","source");
	            	$('#dg').datagrid("hideColumn","linkTypeName");
	            	$('#dg').datagrid("hideColumn","selectTypeName");
	            	$('#dg').datagrid("hideColumn","isindexName");
	            	$('#dg').datagrid("hideColumn","link_url");
	            	$('#dg').datagrid("hideColumn","isTopName");
	            	$('#dg').datagrid("hideColumn","beginDate");
	            	$('#dg').datagrid("hideColumn","endDate");
	            	$('#dg').datagrid("hideColumn","isCollectName");
	            	$('#dg').datagrid("showColumn","isshowName");
	            	$('#dg').datagrid("hideColumn","statusName");
	            	$('#dg').datagrid("hideColumn","viewedNum");
	            	$('#dg').datagrid("showColumn","downloadNum");
	            	$('#opinionPollInfoBtn').hide();
	            	$('#fileInfoListBtn').hide();
	            	$('#topNewsBtn').hide();
	            	$('#frontContentsBtn').hide();
	            }
             }
        },"json");
        $('#addContentsBtn').click(function() {  
        	if($("#catalogID").val()==""){
        		return;
        	}
        	if($("#catalogType").val() == 't_contents' || $("#catalogType").val() == 't_specialTopic'){
            	window.location.href = "${ctx}/contents/newContentsPage.action?catalogID="+$("#catalogID").val();
        	}else if($("#catalogType").val() == 't_video'){
        		window.location.href = "${ctx}/video/newVideoPage.action?catalogID="+$("#catalogID").val();
        	}else if($("#catalogType").val() == 't_links' || $("#catalogType").val() == 't_services'){
        		window.location.href = "${ctx}/links/newLinksPage.action?catalogID="+$("#catalogID").val();
        	}else if($("#catalogType").val() == 't_opinionPoll'){
        		window.location.href = "${ctx}/opinionPoll/newOpinionPollPage.action?catalogID="+$("#catalogID").val();
        	}else if($("#catalogType").val() == 't_files'){
        		window.location.href = "${ctx}/fileInfo/newTheFileInfoPage.action?catalogID="+$("#catalogID").val();
        	}
        });

        $("#editContentsBtn").click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	if($("#catalogType").val() == 't_contents' || $("#catalogType").val() == 't_specialTopic'){
        		window.location.href = "${ctx}/contents/showContentsEdit.action?theID="+$("#theID_delete").val();
        	}else if($("#catalogType").val() == 't_video'){
        		window.location.href = "${ctx}/video/showVideoEdit.action?theID="+$("#theID_delete").val();
        	}else if($("#catalogType").val() == 't_links' || $("#catalogType").val() == 't_services'){
        		window.location.href = "${ctx}/links/showLinksEdit.action?theID="+$("#theID_delete").val();
        	}else if($("#catalogType").val() == 't_opinionPoll'){
        		window.location.href = "${ctx}/opinionPoll/showOpinionPollEdit.action?theID="+$("#theID_delete").val();
        	}else if($("#catalogType").val() == 't_files'){
        		window.location.href = "${ctx}/fileInfo/showTheFileInfoPage.action?theID="+$("#theID_delete").val();
        	}
        });
        
        $('#fileInfoListBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	window.location.href = "${ctx}/fileInfo/fileInfoPage.action?contentID="+$("#theID_delete").val();	
        });
        
        contents_page.initDeleteContentsWin();
        $('#deleteContentsBtn').click(function() {
            if($("#theID_delete").val()==""){
                return;
            }
            $('#deleteContentsWin').window('open');
        });

        contents_page.initInfoTipWin();
        
        $('#opinionPollInfoBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	window.location.href="${ctx}/opinionPoll/opinionPollInfoPage.action?opinionID="+$("#theID_delete").val();
        });
        
        $('#frontContentsBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	var type = $("#catalogType").val();
        	var url = "";
        	var parentID2='';
        	if(type == 't_contents'){
        		if($("#parentID").val()==''){
        			parentID2=parentID;
        		}else{
        			parentID2=$("#parentID").val();
        		}
        		if(parentID2 == 9){
                	url="${ctx}/web/contentsShow.action?type=news&contentsID="+$("#theID_delete").val();
                }else if($('#catalogID').val()==68){//通知公告
                	url="${ctx}/web/contentsShow.action?type=announcement&contentsID="+$("#theID_delete").val();
                }else if(parentID2==59){//镇场信息
                	url="${ctx}/web/townPage.action?flag=1&theID="+$("#theID_delete").val();
                }else if(parentID2==67){//机关单位
                	url="${ctx}/web/officePage.action?flag=1&theID="+$("#theID_delete").val();
                }else if($('#catalogID').val()==126){//投诉建议
                	url="${ctx}/web/tsjyDetailPage.action?theID="+$("#theID_delete").val();
                }else{
                	url="${ctx}/web/contentsShow.action?type=contents&contentsID="+$("#theID_delete").val();
                }
        	}else if(type=='t_specialTopic'){
        		url="";
        	}else if(type=='t_links'){
        		url="${ctx}";
        	}else if(type=='t_services'){
        		url="${ctx}/web/servicesList.action";
        	}else if(type=='t_video'){
	    		if($("#parentID").val() == 9){
	    			url="${ctx}/web/videoShow.action?type=news&videoID="+$("#theID_delete").val();
	            }else{
	            	url="${ctx}/web/videoShow.action?type=contents&videoID="+$("#theID_delete").val();
	            }
        	}
        	window.open(url);
        });
        contents_page.changeTopNewsWin();
        $('#topNewsBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	$('#changeTopNewsWin').window('open');
        });
    });
    
    function showChilds(pid,nodeName){
    	var url = "${ctx}/contents/contentsList.action";
        var param = {};
        $("#catalogID").val(pid);
        param.catalogID=pid;
        var title_se=$("#title_se").val();
        
        param.title = title_se;
        $("#title_se").val("");
        
        $.post(url,param,function(data){
            $('#dg').datagrid({loadFilter:pagerFilter}).datagrid('loadData', data);
            $("#catalogType").val(data.catalogType);
            $("#parentID").val(data.parentID);
            var title_value=$("#table_title");
            title_value.text("");
            title_value.append(data.catalogName);
            
            if(data.catalogType=='t_links'){
            	$('#dg').datagrid("hideColumn","releaseDate");
            	$('#dg').datagrid("hideColumn","source");
            	$('#dg').datagrid("showColumn","linkTypeName");
            	$('#dg').datagrid("showColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","isindexName");
            	$('#dg').datagrid("showColumn","link_url");
            	$('#dg').datagrid("hideColumn","isTopName");
            	$('#dg').datagrid("hideColumn","beginDate");
            	$('#dg').datagrid("hideColumn","endDate");
            	$('#dg').datagrid("hideColumn","isCollectName");
            	$('#dg').datagrid("showColumn","isshowName");
            	$('#dg').datagrid("showColumn","statusName");
            	$('#dg').datagrid("hideColumn","viewedNum");
            	$('#dg').datagrid("hideColumn","downloadNum");
            	$('#opinionPollInfoBtn').hide();
            	$('#fileInfoListBtn').hide();
            	$('#topNewsBtn').hide();
            	$('#frontContentsBtn').show();
            }else if(data.catalogType=='t_services'){
            	$('#dg').datagrid("hideColumn","releaseDate");
            	$('#dg').datagrid("hideColumn","source");
            	$('#dg').datagrid("hideColumn","linkTypeName");
            	$('#dg').datagrid("hideColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","isindexName");
            	$('#dg').datagrid("showColumn","link_url");
            	$('#dg').datagrid("hideColumn","isTopName");
            	$('#dg').datagrid("hideColumn","beginDate");
            	$('#dg').datagrid("hideColumn","endDate");
            	$('#dg').datagrid("hideColumn","isCollectName");
            	$('#dg').datagrid("hideColumn","isshowName");
            	$('#dg').datagrid("showColumn","statusName");
            	$('#dg').datagrid("hideColumn","viewedNum");
            	$('#dg').datagrid("hideColumn","downloadNum");
            	$('#opinionPollInfoBtn').hide();
            	$('#fileInfoListBtn').hide();
            	$('#topNewsBtn').hide();
            	$('#frontContentsBtn').show();
            }else if(data.catalogType=='t_video'){
            	$('#dg').datagrid("showColumn","releaseDate");
            	$('#dg').datagrid("showColumn","source");
            	$('#dg').datagrid("showColumn","isindexName");
            	$('#dg').datagrid("hideColumn","linkTypeName");
            	$('#dg').datagrid("hideColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","link_url");
            	$('#dg').datagrid("hideColumn","isTopName");
            	$('#dg').datagrid("hideColumn","beginDate");
            	$('#dg').datagrid("hideColumn","endDate");
            	$('#dg').datagrid("hideColumn","isCollectName");
            	$('#dg').datagrid("hideColumn","isshowName");
            	$('#dg').datagrid("showColumn","statusName");
            	$('#dg').datagrid("showColumn","viewedNum");
            	$('#dg').datagrid("hideColumn","downloadNum");
            	$('#opinionPollInfoBtn').hide();
            	$('#fileInfoListBtn').hide();
            	$('#topNewsBtn').hide();
            	$('#frontContentsBtn').show();
            }else if(data.catalogType=='t_contents' || data.catalogType=='t_specialTopic'){
            	$('#dg').datagrid("showColumn","releaseDate");
            	$('#dg').datagrid("showColumn","source");
            	$('#dg').datagrid("hideColumn","linkTypeName");
            	$('#dg').datagrid("hideColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","link_url");
            	$('#dg').datagrid("hideColumn","isindexName");
            	$('#dg').datagrid("hideColumn","beginDate");
            	$('#dg').datagrid("hideColumn","endDate");
            	$('#dg').datagrid("hideColumn","isCollectName");
            	$('#dg').datagrid("hideColumn","isshowName");
            	$('#dg').datagrid("showColumn","statusName");
            	$('#dg').datagrid("showColumn","viewedNum");
            	$('#dg').datagrid("hideColumn","downloadNum");
            	$('#opinionPollInfoBtn').hide();
            	if(data.parentID == 9){
                	$('#fileInfoListBtn').hide();
                	$('#topNewsBtn').show();
                	$('#dg').datagrid("showColumn","isTopName");
                }else{
                	$('#fileInfoListBtn').show();
                	$('#topNewsBtn').hide();
                	$('#dg').datagrid("hideColumn","isTopName");
                }
            	$('#frontContentsBtn').show();
            }else if(data.catalogType=='t_opinionPoll'){
            	$('#dg').datagrid("showColumn","releaseDate");
            	$('#dg').datagrid("hideColumn","source");
            	$('#dg').datagrid("hideColumn","linkTypeName");
            	$('#dg').datagrid("hideColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","link_url");
            	$('#dg').datagrid("hideColumn","isindexName");
            	$('#dg').datagrid("hideColumn","isTopName");
            	$('#dg').datagrid("showColumn","beginDate");
            	$('#dg').datagrid("showColumn","endDate");
            	$('#dg').datagrid("showColumn","isCollectName");
            	$('#dg').datagrid("showColumn","statusName");
            	$('#dg').datagrid("hideColumn","isshowName");
            	$('#dg').datagrid("hideColumn","viewedNum");
            	$('#dg').datagrid("hideColumn","downloadNum");
            	$('#opinionPollInfoBtn').show();
            	$('#fileInfoListBtn').hide();
            	$('#topNewsBtn').hide();
            	$('#frontContentsBtn').hide();
            }else if(data.catalogType=='t_files'){
            	$('#dg').datagrid("showColumn","releaseDate");
            	$('#dg').datagrid("hideColumn","source");
            	$('#dg').datagrid("hideColumn","linkTypeName");
            	$('#dg').datagrid("hideColumn","selectTypeName");
            	$('#dg').datagrid("hideColumn","link_url");
            	$('#dg').datagrid("hideColumn","isindexName");
            	$('#dg').datagrid("hideColumn","isTopName");
            	$('#dg').datagrid("hideColumn","beginDate");
            	$('#dg').datagrid("hideColumn","endDate");
            	$('#dg').datagrid("hideColumn","isCollectName");
            	$('#dg').datagrid("hideColumn","statusName");
            	$('#dg').datagrid("showColumn","isshowName");
            	$('#dg').datagrid("hideColumn","viewedNum");
            	$('#dg').datagrid("showColumn","downloadNum");
            	$('#opinionPollInfoBtn').hide();
            	$('#fileInfoListBtn').hide();
            	$('#topNewsBtn').hide();
            	$('#frontContentsBtn').hide();
            }
        },"json");
    }
    function searchList(){
    	var catalogID_se = $("#catalogID").val();
    	if(catalogID_se == ""){
    		alert("请选择栏目后再查询！");
    		return;
    	}
    	showChilds(catalogID_se,"");
    }
</script>
<table width="100%">
<tr>
<td  valign="top" width="170">
<iframe src="${ctx}/view/system/contents/catalogZTree.jsp" height="650" width="170" frameborder="0" scrolling="auto" id="leftframe"></iframe>
</td>
<td valign="top" width="90%">
<div>


	标题：<input type="text" id="title_se" value="${title }"/>
	
	<input type="button" value="查询" onclick="searchList();">

</div>
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
			<th field="catalogName" width="80">所属栏目</th>
		    <th field="releaseDate" width="150">发布时间</th>
		    <th field="source" width="80">来源</th>
		    <th field="linkTypeName" width="80">链接类型</th>
		    <th field="selectTypeName" width="150">所属框</th>
		    <th field="link_url" width="150">链接地址</th>
		    <th field="statusName" width="45"><input type="hidden" field="status">状态</th>
		    <th field="isindexName" width="100"><input type="hidden" field="isindex">是否首页视频</th>
		    <th field="isTopName" width="100"><input type="hidden" field="isTop">是否头条新闻</th>
		    <th field="beginDate" width="150">开始时间</th>
		    <th field="endDate" width="150">结束时间</th>
		    <th field="isCollectName" width="100"><input type="hidden" field="isCollect">是否本站征集</th>
		    <th field="isshowName" width="80"><input type="hidden" field="isshow">是否显示</th>
		    <th field="viewedNum" width="80">浏览次数</th>
		    <th field="downloadNum" width="80">下载次数</th>
		</tr>
    </thead>
    <div id="tb" style="height:auto">
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addContentsBtn">新建</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editContentsBtn">编辑</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" id="fileInfoListBtn" >图片附件</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteContentsBtn">删除</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="opinionPollInfoBtn">查看征集</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="frontContentsBtn">查看前台显示</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="topNewsBtn">头条新闻</a>
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
            <input type="hidden" id="parentID">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.deleteContents()">
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

<div id="changeTopNewsWin" class="easyui-window" title="更换头条新闻" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save"  style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认更换头条新闻？</label>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.changeTopNews()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeChangeTopNewsWin()">取消</a>
        </div>
    </div>
</div>


</body>
</html>