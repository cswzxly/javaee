<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>内容管理</title>
    <script type="text/javascript" src="${ctx}/resources/system/js/ajaxfileupload.js"></script>
</head>
<body>
<script>
    function onClickRow(index) {
        $("#theID_delete").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#desId").val($('#dg').datagrid('getRows')[index]['desId']);
        $("#theID_focus").val($('#dg').datagrid('getRows')[index]['theID']);
        $("input[name='theID_upload']").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#theID_edit").val($('#dg').datagrid('getRows')[index]['theID']);
        $("#title_edit").val($('#dg').datagrid('getRows')[index]['title']);
        $("#fileType_edit").val($('#dg').datagrid('getRows')[index]['fileType']);
        $("#sort_edit").val($('#dg').datagrid('getRows')[index]['sort']);
        $("#isshow_edit").val($('#dg').datagrid('getRows')[index]['isshow']);
    }


    var contents_page = {

        initDeleteContentsWin: function () {
            $('#deleteContentsWin').window({
                title: '删除内容',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
            });
        },

        initFocusContentsWin: function () {
            $('#focusContentsWin').window({
                title: '今日关注',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
            });
        },

        initInfoTipWin: function () {
            $('#infoTipWin').window({
                title: '提示信息',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
            });
        },

        initOpenUploadWin: function () {
            $('#openUploadWin').window({
                title: '新增上传文件',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable: false
            });
        },

        initEditUploadWin: function () {
            $('#editUploadWin').window({
                title: '编辑文件信息',
                width: 450,
                modal: true,
                shadow: true,
                closed: true,
                height: 300,
                resizable: false
            });
        },

        initDeleteUploadWin: function () {
            $('#deleteUploadWin').window({
                title: '删除上传文件',
                width: 200,
                modal: true,
                shadow: true,
                closed: true,
                height: 150,
                resizable: false
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
        
        closeEditUploadWin: function () {
            $('#editUploadWin').window('close');
        },

        closeDeleteUploadWin: function () {
            $('#deleteUploadWin').window('close');
        },

        closeOpenUploadWin: function () {
            $('#openUploadWin').window('close');
        },

        closeDeleteContentsWin: function () {

            $('#deleteContentsWin').window('close');
        },

        closeFocusContentsWin: function () {
            $('#focusContentsWin').window('close');
        },

        closeInfoTipWin: function () {
            $('#infoTipWin').window('close');
        },
        closeChangeTopNewsWin:function () {
        	if($("#theID_delete").val()==""){
        		alert("请选择要作为头条的新闻");
        		return;
        	}
            $('#changeTopNewsWin').window('close');
        },

        deleteContents: function () {
            var catalogType = $("#catalogType").val();
            var url;
            if (catalogType == "t_contents" || catalogType == 't_specialTopic') {
                url = "${ctx}/contents/deleteContents.action";
            } else if (catalogType == "t_video") {
                url = "${ctx}/video/deleteVideo.action";
            } else if (catalogType == "t_links" || catalogType == "t_services") {
                url = "${ctx}/links/deleteLinks.action";
            } else {
                url = "";
            }
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url, param, function (data) {
                if (data == "success") {
                    contents_page.closeDeleteContentsWin();
                    var url = "${ctx}/contents/contentsList.action";
                    var param = {};
                    var catalogID = $("#catalogID").val();
                    if (catalogID == "") catalogID = "10";
                    param.catalogID = catalogID;
                    $("#catalogID").val(catalogID);
                    $.post(url, param, function (data) {
                        $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                    }, "json");
                }
            }, "text");
        },

        focusContents: function () {
            var url = "${ctx}/contents/focusContents.action";
            var param = {};
            param.theID = $("#theID_focus").val();
            $.post(url, param, function (data) {
                if (data == "success") {
                    contents_page.closeFocusContentsWin();
                    var url = "${ctx}/contents/contentsList.action";
                    var param = {};
                    var catalogID = $("#catalogID").val();
                    if (catalogID == "") catalogID = "10";
                    param.catalogID = catalogID;
                    $("#catalogID").val(catalogID);
                    $.post(url, param, function (data) {
                        $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                    }, "json");
                }else if(data == "noSetNum"){
                	alert("未设置今日关注的数量！");
                	contents_page.closeFocusContentsWin();
                	return;
                }
            }, "text");
        },

        saveUploadFile: function () {
            var flag = true;
            var catalogID = $("input[name='catalogID_upload']").val();
            var title = $("#title").val();
            var sort = $("#sort").val();
            var fileType = $("#fileType").val();
            var isshow = $("#isshow").val();
            var uploadinfo = $("#uploadinfo").val();
            if (title == "") {
                flag = false;
                alert("图片（文件）名称不能为空！");
                return false;
            }
            if (uploadinfo == "") {
                flag = false;
                alert("上传图片（文件）不能为空！");
                return false;
            }
            if (flag) {
                var url = "${ctx}/fileInfo/saveNewFileInfo.action";
                var param = {};
                param.catalogID = catalogID;
                param.title = title;
                param.fileType = fileType;
                param.sort = sort;
                param.isshow = isshow;
                param.fileMode = "t_fileinfo";
                $.post(url, param, function (data) {
                    if (data.result == 'success') {

                        $.ajaxFileUpload({
                            url: '${ctx}/fileInfo/uploader.action?theID=' + data.fileInfoID,            //需要链接到服务器地址
                            secureuri: false,
                            fileElementId: 'uploadinfo',                        //文件选择框的id属性
                            dataType: 'text',                                     //服务器返回的格式，可以是json
                            success: function (data1, status)            //相当于java中try语句块的用法
                            {
//                                alert("操作成功");
                                contents_page.closeOpenUploadWin();
                                $("#title").val("");
                                $("#sort").val("");
                                $("#isshow").val("1");
                                window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                            },
                            error: function (data1, status, e)            //相当于java中catch语句块的用法
                            {
                                alert("操作失败!" + e);
                            }
                        });
                    }
                }, "json");


            }
        },

        saveEditUploadWin: function () {
            var flag = true;
            var theID1 = $("#theID_edit").val();
            var title1 = $("#title_edit").val();
            var sort1 = $("#sort_edit").val();
            var fileType1 = $("#fileType_edit").val();
            var isshow1 = $("#isshow_edit").val();
            var catalogID = $("input[name='catalogID_upload']").val();
            if (title1 == "") {
                flag = false;
                alert("文件名称不能为空");
                return false;
            }
            if (flag) {
                var url = "${ctx}/fileInfo/saveEditFileInfo.action";
                var param = {};
                param.theID = theID1;
                param.title = title1;
                param.fileType = fileType1;
                param.sort = sort1;
                param.isshow = isshow1;

                $.post(url, param, function (data) {
                    if (data == "success") {
                        contents_page.closeEditUploadWin();
                        window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                    }
                }, "text");

            }
        },
        deleteFileInfo: function () {
            if ($("#theID_delete").val() == "") {
                return;
            }
            var catalogID = $("input[name='catalogID_upload']").val();
            var url = "${ctx}/fileInfo/deleteFileInfo.action";
            var param = {};
            param.theID = $("#theID_delete").val();
            $.post(url, param, function (data) {
                if (data == "success") {
                    contents_page.closeDeleteUploadWin();
                    window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                }
            }, "text");
        },

        downloadFile: function () {
            var theID = $("#theID_delete").val();
            location.href = "${ctx}/fileInfo/downloadFile.action?theID=" + theID;
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
    function pagerFilter(data) {
        if (typeof data.length == 'number' && typeof data.splice == 'function') {	// is array
            data = {
                total: data.length,
                rows: data
            };
        }
        var dg = $(this);
        var opts = dg.datagrid('options');
        var pager = dg.datagrid('getPager');
        pager.pagination({
            onSelectPage: function (pageNum, pageSize) {
                opts.pageNumber = pageNum;
                opts.pageSize = pageSize;
                pager.pagination('refresh', {
                    pageNumber: pageNum,
                    pageSize: pageSize
                });
                dg.datagrid('loadData', data);
            }
        });
        if (!data.originalRows) {
            data.originalRows = (data.rows);
        }
        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
        var end = start + parseInt(opts.pageSize);
        data.rows = (data.originalRows.slice(start, end));
        return data;
    }

    $(function () {

        var url = "${ctx}/contents/contentsList.action";
        var param = {};
        var catalogID = '${catalogID}';
        var catalogType = '${catalog.catalogType}';
        var parentID = '${catalog.parentID}';
        if (catalogID == "") catalogID = "0";
        param.catalogID = catalogID;
        $("#catalogID").val(catalogID);
        $("#catalogType").val(catalogType);
        $("#parenID").val(parentID);
        $("[name='catalogID_upload']").val(catalogID);
        $.post(url, param, function (data) {
            if (data.code == "00") {
                alert("权限不足，请联系管理员！");
            } else {
                $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                if (catalogType == 't_contents') {
                    $('#dg').datagrid("hideColumn", "linkTypeName");
                    $('#dg').datagrid("hideColumn", "selectTypeName");
                    $('#dg').datagrid("hideColumn", "link_url");
//                    $('#dg').datagrid("hideColumn", "isindexName");
                    if (parentID == 9) {
                        $('#fileInfoListBtn').hide();
                        $('#focusContentsBtn').show();
                        $('#topNewsBtn').show();
                        $('#dg').datagrid("showColumn", "isTopName");
                        $('#dg').datagrid("showColumn", "isFocusName");
                    } else {
                        $('#fileInfoListBtn').show();
                        $('#focusContentsBtn').hide();
                        $('#topNewsBtn').hide();
                        $('#dg').datagrid("hideColumn", "isTopName");
                        $('#dg').datagrid("hideColumn", "isFocusName");
                        
                    }
                } else if (catalogType == 't_video') {
                    $('#dg').datagrid("hideColumn", "linkTypeName");
                    $('#dg').datagrid("hideColumn", "selectTypeName");
                    $('#dg').datagrid("hideColumn", "link_url");
//                    $('#dg').datagrid("showColumn", "isindexName");
                    $('#dg').datagrid("hideColumn", "isTopName");
                    $('#dg').datagrid("hideColumn", "isFocusName");
                    $('#focusContentsBtn').hide();
                    $('#fileInfoListBtn').hide();
                    $('#topNewsBtn').hide();
                } else if (catalogType == 't_links') {
                    $('#dg').datagrid("showColumn", "linkTypeName");
                    $('#dg').datagrid("showColumn", "selectTypeName");
                    $('#dg').datagrid("showColumn", "link_url");
//                    $('#dg').datagrid("hideColumn", "isindexName");
                    $('#dg').datagrid("hideColumn", "releaseDate");
                    $('#dg').datagrid("hideColumn", "source");
                    $('#dg').datagrid("hideColumn", "isTopName");
                    $('#dg').datagrid("hideColumn", "isFocusName");
                    $('#focusContentsBtn').hide();
                    $('#fileInfoListBtn').hide();
                    $('#topNewsBtn').hide();
                } else if (catalogType == 't_services') {
                    $('#dg').datagrid("hideColumn", "releaseDate");
                    $('#dg').datagrid("hideColumn", "source");
                    $('#dg').datagrid("hideColumn", "linkTypeName");
                    $('#dg').datagrid("hideColumn", "selectTypeName");
//                    $('#dg').datagrid("hideColumn", "isindexName");
                    $('#dg').datagrid("showColumn", "link_url");
                    $('#dg').datagrid("hideColumn", "isTopName");
                    $('#dg').datagrid("hideColumn", "isFocusName");
                    $('#focusContentsBtn').hide();
                    $('#fileInfoListBtn').hide();
                    $('#topNewsBtn').hide();
                } else if (catalogType == 't_fileinfo') {
                    $('#dg').datagrid("hideColumn", "releaseDate");
                    $('#dg').datagrid("hideColumn", "source");
                    $('#dg').datagrid("hideColumn", "linkTypeName");
                    $('#dg').datagrid("hideColumn", "selectTypeName");
//                    $('#dg').datagrid("hideColumn", "isindexName");
                    $('#dg').datagrid("showColumn", "link_url");
                    $('#dg').datagrid("hideColumn", "isTopName");
                    $('#dg').datagrid("hideColumn", "isFocusName");
                    $('#dg').datagrid("hideColumn", "link_url");
                    $('#focusContentsBtn').hide();
                    $('#fileInfoListBtn').hide();
                    $('#topNewsBtn').hide();
                    $("[name='catalogID_upload']").val(pid);
                }else if(catalogType == 't_specialTopic'){
                	alert("123123");
                	$('#dg').datagrid("hideColumn", "linkTypeName");
                    $('#dg').datagrid("hideColumn", "selectTypeName");
                    $('#dg').datagrid("hideColumn", "link_url");
                    $('#fileInfoListBtn').hide();
                    $('#focusContentsBtn').hide();
                    $('#topNewsBtn').hide();
                }
            }
        }, "json");

        $('#addContentsBtn').click(function () {
            if ($("#catalogID").val() == "") {
                return;
            }
            if ($("#catalogType").val() == 't_contents' || $("#catalogType").val() == 't_specialTopic') {
                window.location.href = "${ctx}/contents/newContentsPage.action?catalogID=" + $("#catalogID").val();
            } else if ($("#catalogType").val() == 't_video') {
                window.location.href = "${ctx}/video/newVideoPage.action?catalogID=" + $("#catalogID").val();
            } else if ($("#catalogType").val() == 't_links' || $("#catalogType").val() == 't_services') {
                window.location.href = "${ctx}/links/newLinksPage.action?catalogID=" + $("#catalogID").val();
            } else if ($("#catalogType").val() == 't_fileinfo') {
                $('#openUploadWin').window('open');
            }
        });

        $("#editContentsBtn").click(function () {
            if ($("#theID_delete").val() == "") {
                return;
            }
            if ($("#catalogType").val() == 't_contents' || $("#catalogType").val() == 't_specialTopic') {
                window.location.href = "${ctx}/contents/showContentsEdit.action?theID=" + $("#theID_delete").val();
            } else if ($("#catalogType").val() == 't_video') {
                window.location.href = "${ctx}/video/showVideoEdit.action?theID=" + $("#theID_delete").val();
            } else if ($("#catalogType").val() == 't_links' || $("#catalogType").val() == 't_services') {
                window.location.href = "${ctx}/links/showLinksEdit.action?theID=" + $("#theID_delete").val();
            } else if ($("#catalogType").val() == 't_fileinfo') {
                $('#editUploadWin').window('open');
            }
        });

        $('#fileInfoListBtn').click(function () {
            if ($("#theID_delete").val() == "") {
                return;
            }
            window.location.href = "${ctx}/fileInfo/fileInfoPage.action?contentID=" + $("#theID_delete").val();
        });

        contents_page.initDeleteContentsWin();
        $('#deleteContentsBtn').click(function () {
            if ($("#theID_delete").val() == "") {
                return;
            }
            if ($("#catalogType").val() == 't_fileinfo') {
                $('#deleteUploadWin').window('open');
            } else {
                $('#deleteContentsWin').window('open');
            }
        });

        contents_page.initFocusContentsWin();
        $('#focusContentsBtn').click(function () {
            if ($("#theID_focus").val() == "") {
                return;
            }
            $('#focusContentsWin').window('open');
        });
        contents_page.changeTopNewsWin();
        $('#topNewsBtn').click(function(){
        	if($("#theID_delete").val()==""){
        		return;
        	}
        	$('#changeTopNewsWin').window('open');
        });
        contents_page.initInfoTipWin();
        contents_page.initOpenUploadWin();
        contents_page.initEditUploadWin();
        contents_page.initDeleteUploadWin();
        
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
                	url="${ctx}/web/contentsShow.action?type=news&contentsID="+$("#desId").val();
                }else if($('#catalogID').val()==68){//通知公告
                	url="${ctx}/web/contentsShow.action?type=announcement&contentsID="+$("#desId").val();
                }else{
                	url="${ctx}/web/contentsShow.action?type=contents&contentsID="+$("#desId").val();
                }
        	}else if(type=='t_specialTopic'){
        		url="${ctx}/web/specialTopicShow.action?contentID="+$("#theID_delete").val();
        	}else if(type=='t_links'){
        		url="${ctx}";
        	}else if(type=='t_services'){
        		url="${ctx}/web/servicesList.action";
        	}else if(type=='t_video'){
	    		if($("#parentID").val() == 9){
	    			url="${ctx}/web/videoShow.action?type=news&videoID="+$("#desId").val();
	            }else{
	            	url="${ctx}/web/videoShow.action?type=contents&videoID="+$("#desId").val();
	            }
        	}
        	window.open(url);
        });
        
        $('#batchDeleteBtn').click(function(){
        	var ids="";
        	var param = {};
    		var rows = $('#dg').datagrid('getSelections');
    		for(var i=0;i<rows.length;i++){
    			if(i == rows.length-1){
    				ids=ids+rows[i].theID;
    			}else{
    				ids=rows[i].theID+","+ids;
    			}
    		}
    		param.theIDs = ids;
    		var catalogType = $("#catalogType").val();
            var url;
            if (catalogType == "t_contents" || catalogType == 't_specialTopic') {
                url = "${ctx}/contents/batchDeleteContents.action";
            } else if (catalogType == "t_video") {
                url = "${ctx}/video/batchDeleteVideo.action";
            } else if (catalogType == "t_links" || catalogType == "t_services") {
                url = "${ctx}/links/batchDeleteLinks.action";
            } else {
                url = "";
            }
            $.post(url, param, function (data) {
                if (data == "success") {
                    contents_page.closeDeleteContentsWin();
                    var url = "${ctx}/contents/contentsList.action";
                    var param = {};
                    var catalogID = $("#catalogID").val();
                    if (catalogID == "") catalogID = "10";
                    param.catalogID = catalogID;
                    $("#catalogID").val(catalogID);
                    $.post(url, param, function (data) {
                        $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
                    }, "json");
                }
            }, "text");
        });
    });

    function showChilds(pid, nodeName) {
        var url = "${ctx}/contents/contentsList.action";
        var param = {};
        $("#catalogID").val(pid);
        param.catalogID = pid;
        var title_se = $("#title_se").val();

        param.title = title_se;
        $("#title_se").val("");

        $.post(url, param, function (data) {
            $('#dg').datagrid({loadFilter: pagerFilter}).datagrid('loadData', data);
            $("#catalogType").val(data.catalogType);
            $("#parentID").val(data.parentID);
            var title_value = $("#table_title");
            title_value.text("");
            title_value.append(data.catalogName);

            if (data.catalogType == 't_links') {
                $('#dg').datagrid("hideColumn", "releaseDate");
                $('#dg').datagrid("hideColumn", "source");
                $('#dg').datagrid("showColumn", "linkTypeName");
                $('#dg').datagrid("showColumn", "selectTypeName");
//                $('#dg').datagrid("hideColumn", "isindexName");
                $('#dg').datagrid("showColumn", "link_url");
                $('#dg').datagrid("hideColumn", "isTopName");
                $('#dg').datagrid("hideColumn", "isFocusName");
                $('#focusContentsBtn').hide();
                $('#fileInfoListBtn').hide();
                $('#topNewsBtn').hide();
            } else if (data.catalogType == 't_services') {
                $('#dg').datagrid("hideColumn", "releaseDate");
                $('#dg').datagrid("hideColumn", "source");
                $('#dg').datagrid("hideColumn", "linkTypeName");
                $('#dg').datagrid("hideColumn", "selectTypeName");
//                $('#dg').datagrid("hideColumn", "isindexName");
                $('#dg').datagrid("showColumn", "link_url");
                $('#dg').datagrid("hideColumn", "isTopName");
                $('#dg').datagrid("hideColumn", "isFocusName");
                $('#focusContentsBtn').hide();
                $('#fileInfoListBtn').hide();
                $('#topNewsBtn').hide();
            } else if (data.catalogType == 't_video') {
                $('#dg').datagrid("showColumn", "releaseDate");
                $('#dg').datagrid("showColumn", "source");
//                $('#dg').datagrid("showColumn", "isindexName");
                $('#dg').datagrid("hideColumn", "linkTypeName");
                $('#dg').datagrid("hideColumn", "selectTypeName");
                $('#dg').datagrid("hideColumn", "link_url");
                $('#dg').datagrid("hideColumn", "isTopName");
                $('#dg').datagrid("hideColumn", "isFocusName");
                $('#focusContentsBtn').hide();
                $('#fileInfoListBtn').hide();
                $('#topNewsBtn').hide();
            } else if (data.catalogType == 't_contents') {
                $('#dg').datagrid("showColumn", "releaseDate");
                $('#dg').datagrid("showColumn", "source");
                $('#dg').datagrid("hideColumn", "linkTypeName");
                $('#dg').datagrid("hideColumn", "selectTypeName");
                $('#dg').datagrid("hideColumn", "link_url");
//                $('#dg').datagrid("hideColumn", "isindexName");
                if (data.parentID == 9) {
                    $('#fileInfoListBtn').hide();
                    $('#focusContentsBtn').show();
                    $('#topNewsBtn').show();
                    $('#dg').datagrid("showColumn", "isFocusName");
                    $('#dg').datagrid("showColumn", "isTopName");
                } else {
                    $('#fileInfoListBtn').show();
                    $('#focusContentsBtn').hide();
                    $('#topNewsBtn').hide();
                    $('#dg').datagrid("hideColumn", "isFocusName");
                    $('#dg').datagrid("hideColumn", "isTopName");
                }
            } else if (data.catalogType == 't_specialTopic'){
                $('#dg').datagrid("hideColumn", "linkTypeName");
                $('#dg').datagrid("hideColumn", "selectTypeName");
                $('#dg').datagrid("hideColumn", "link_url");
                $('#fileInfoListBtn').hide();
                $('#focusContentsBtn').hide();
                $('#topNewsBtn').hide();
                $('#dg').datagrid("hideColumn", "isFocusName");
                $('#dg').datagrid("hideColumn", "isTopName");
            } else if (data.catalogType = 't_fileinfo') {
                $('#dg').datagrid("hideColumn", "releaseDate");
                $('#dg').datagrid("hideColumn", "source");
                $('#dg').datagrid("hideColumn", "linkTypeName");
                $('#dg').datagrid("hideColumn", "selectTypeName");
//                $('#dg').datagrid("hideColumn", "isindexName");
                $('#dg').datagrid("showColumn", "link_url");
                $('#dg').datagrid("hideColumn", "isTopName");
                $('#dg').datagrid("hideColumn", "isFocusName");
                $('#dg').datagrid("hideColumn", "link_url");
                $('#focusContentsBtn').hide();
                $('#fileInfoListBtn').hide();
                $('#topNewsBtn').hide();
                $("[name='catalogID_upload']").val(pid);
            }
        }, "json");
    }
    function searchList() {
        var catalogID_se = $("#catalogID").val();
        if (catalogID_se == "") {
            alert("请选择栏目后再查询！");
            return;
        }
        showChilds(catalogID_se, "");
    }
</script>
<table width="100%">
    <tr>
        <td valign="top" width="170">
            <iframe src="${ctx}/view/system/contents/catalogZTree.jsp" height="650" width="170" frameborder="0" scrolling="auto" id="leftframe"></iframe>
        </td>
        <td valign="top" width="90%">
            <div>


                标题：<input type="text" id="title_se" value="${title }"/>

                <input type="button" value="查询" onclick="searchList();">

            </div>
            <table id="dg" title="<div id='table_title'>${catalog.title}" style="width:auto;height:600px" data-options="
				rownumbers:true,
				
				autoRowHeight:false,
				toolbar: '#tb',
				pagination:true,
				pageSize:20,
				onClickRow: onClickRow">
                <thead>
                <tr>
                	<th field="id" checkbox="true"></th>
                    <th field="title" width="350"><input type="hidden" field="theID">标题</th>
                    <th field="catalogName" width="80"><input type="hidden" id="desId">所属栏目</th>
                    <th field="releaseDate" width="150">发布时间</th>
                    <th field="source" width="80">来源</th>
                    <th field="linkTypeName" width="80">链接类型</th>
                    <th field="selectTypeName" width="150">所属框</th>
                    <th field="link_url" width="150">链接地址</th>
                    <th field="statusName" width="45"><input type="hidden" field="status">状态</th>
                    <%--<th field="isindexName" width="100"><input type="hidden" field="isindex">是否首页视频</th>--%>
                    <th field="isTopName" width="100"><input type="hidden" field="isTop">是否头条新闻</th>
                    <th field="isFocusName" width="100"><input type="hidden" field="isFocus">是否今日关注</th>
                </tr>
                </thead>
                <div id="tb" style="height:auto">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addContentsBtn">新建</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="editContentsBtn">编辑</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" id="fileInfoListBtn">图片附件</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="deleteContentsBtn">删除</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="batchDeleteBtn">批量删除</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="frontContentsBtn">查看前台显示</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="focusContentsBtn">是否今日关注</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" id="topNewsBtn">头条新闻</a>
                </div>

            </table>
        </td>
    </tr>
</table>


<div id="deleteContentsWin" class="easyui-window" title="删除内容" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" id="theID_delete">
            <input type="hidden" id="catalogID">
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

<div id="focusContentsWin" class="easyui-window" title="今日关注" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
        background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认操作？</label>
            <input type="hidden" id="theID_focus">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onclick="contents_page.focusContents()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeFocusContentsWin()">取消</a>
        </div>
    </div>
</div>


<div id="infoTipWin" class="easyui-window" title="提示信息" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
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

<div id="openUploadWin" class="easyui-window" title="新增上传文件" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
     background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding=3>
                <input type="hidden" name="catalogID_upload">
                <input type="hidden" id="fileMode" value="t_file">
                <tr>
                    <td>名称：</td>
                    <td><input id="title" type="text" class="easyui-validatebox" data-options="required:true"/></td>
                </tr>
                <tr>
                    <td>文件类型：</td>
                    <td>
                        <select id="fileType">
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
            </table>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="contents_page.saveUploadFile();">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeOpenUploadWin()">取消</a>
        </div>
    </div>
</div>

<div id="editUploadWin" class="easyui-window" title="编辑文件信息" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
         background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <table cellpadding=3>
                <input type="hidden" name="catalogID_upload">
                <input id="theID_edit" type="hidden"/>
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
                <tr>
                    <td>下载：</td>
                    <td>
                        <button type="button" onclick="contents_page.downloadFile();">点击下载</button>
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
            </table>
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="contents_page.saveEditUploadWin()">
                保存</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeEditUploadWin();">取消</a>
        </div>
    </div>
</div>

<div id="deleteUploadWin" class="easyui-window" title="删除上传文件" collapsible="false" minimizable="false"
     maximizable="false" icon="icon-save" style="width: 300px; height: 250px; padding: 5px;
         background: #fafafa;" data-options="left:'250px',top:'200px'">
    <div class="easyui-layout" fit="true">
        <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
            <label>确认删除？</label>
            <input type="hidden" name="theID_upload">
        </div>
        <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="contents_page.deleteFileInfo()">
                确认</a> <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)"
                          onclick="contents_page.closeDeleteUploadWin()">取消</a>
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