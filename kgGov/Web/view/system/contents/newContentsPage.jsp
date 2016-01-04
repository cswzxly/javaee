<%@ page language="java" pageEncoding="utf-8" %>
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
    var editor;
    KindEditor.ready(function (K) {
        editor = K.create('#contents', {
            uploadJson: '${ctx}/resources/kindeditor/jsp/upload_json.jsp',
            fileManagerJson: '${ctx}/resources/kindeditor/jsp/file_manager_json.jsp',
            allowFileManager: true,
            filterMode: false,
            afterCreate: function () {
                this.sync();
            },
            afterBlur: function () {
                this.sync();
            }
        });
    });
    var newContents_page = {

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

        closeInfoTipWin: function () {
            $('#infoTipWin').window('close');
        },

        saveNewContents: function () {
            var flag = true;
            var title = $("#title").val();
            var secTitle = $("#secTitle").val();
            var catalogID = $("#catalogID").val();
            var releaseDate = $("#releaseDate").val();
            var source = $("#source").val();
            var status = $("#status").val();
            var contents = $("#contents").val();
            var isTop = $("#isTop").val();
            var catalogPid = $("#catalogPid").val();
            var isFocus = $("#isFocus").val();
            var visitCount = $("#visitCount").val();
            if (title == "") {
                flag = false;
                alert("标题不能为空");
                return false;
            }
            if (contents == "") {
                flag = false;
                alert("内容不能为空");
                return false;
            }
            if (flag) {
                var url = "${ctx}/contents/saveNewContents.action";
                var param = {};
                param.catalogID = catalogID;
                param.releaseDate = releaseDate;
                param.title = title;
                param.secTitle = secTitle;
                param.source = source;
                param.contents = contents;
                param.status = status;
                param.isTop = isTop;
                param.isFocus = isFocus;
                param.visitCount = visitCount;
                $.post(url, param, function (data) {
                    var uploadinfo = $("#uploadinfo").val();
                    if (catalogPid == 9 && uploadinfo != '') {
                        var urlFile = "${ctx}/fileInfo/saveNewFileInfo.action";
                        var fileParam = {};
                        fileParam.contentID = data.contentsID;
                        fileParam.title = title;
                        fileParam.fileType = "1";
                        fileParam.sort = 0;
                        fileParam.isshow = "1";
                        fileParam.isindex = "1";
                        $.post(urlFile, fileParam, function (data1) {
                            if (data1.result == 'success') {
                                $.ajaxFileUpload({
                                    url: '${ctx}/fileInfo/uploader.action?theID=' + data1.fileInfoID,            //需要链接到服务器地址
                                    secureuri: false,
                                    fileElementId: 'uploadinfo',                        //文件选择框的id属性
                                    dataType: 'text',                                     //服务器返回的格式，可以是json
                                    success: function (data2, status)            //相当于java中try语句块的用法
                                    {
                                        alert("操作成功");
                                        window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                                    },
                                    error: function (data2, status, e)            //相当于java中catch语句块的用法
                                    {
                                        alert("操作失败!" + e);
                                    }
                                });

                            }

                        }, "json");

                    } else {
                        window.location.href = "${ctx}/contents/contentsPage.action?catalogID=" + catalogID;
                    }
                }, "json");
            }
        }


    }
    $(function () {
        newContents_page.initInfoTipWin();

        $('#backContentsBtn').click(function () {
            window.location.href = "${ctx}/contents/contentsPage.action";
        });

    });

    function checkIsTop(obj) {
        if (obj == 1) {
            var url = "${ctx}/fileInfo/checkIsTop.action";
            var param = {};
            var catalogID = $("#catalogID").val();
            param.catalogID = catalogID;
            $.post(url, param, function (data) {
                if (data == '1') {
                    alert("已有头条新闻，头条新闻只能设置一条");
                    $("#isTop").val('0');
                }
            }, "json");
        }
    }
</script>


<div id="newContentsWin" class="easyui-panel" title="新增内容" collapsible="false" minimizable="false"
     maximizable="true" icon="icon-save" style="width: auto; height: 600px; padding: 5px;
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
                        <td colspan="3"><input id="title" type="text" class="easyui-validatebox" data-options="required:true,validType:'length[1,40]'"/></td>
                    </tr>
                    <tr>
                        <th>所属栏目：</th>
                        <td>
                            <span>${catalog.title}</span>
                            <input type="hidden" id="catalogID" value="${catalog.theID}"/>
                            <input type="hidden" id="catalogPid" value="${catalog.parentID }"/>
                        </td>
                        <th>副标题：</th>
                        <td><input id="secTitle" type="text" class="easyui-validatebox"/></td>
                    </tr>
                    <tr>
                        <th>发布日期：</th>
                        <td>
                            <input id="releaseDate" type="text" width="100" readonly="readonly" value="${now }"/>
                            <img onClick="WdatePicker({el:'releaseDate',dateFmt:'yyyy-MM-dd HH:mm:ss'})" src="${ctx}/resources/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
                        </td>
                        <th>状态：</th>
                        <td>
                            <select id="status">
                                <option value="1">启用</option>
                                <option value="0">停用</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>来源：</th>
                        <td colspan="3"><input id="source" type="text" value="未知"/></td>
                    </tr>
                    <c:if test="${catalog.parentID==9 }">
                        <tr>
                            <th>是否头条新闻：</th>
                            <td>
                                <select id="isTop"><!-- onChange="checkIsTop(this.value);" -->
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </td>
                            <th>是否今日关注：</th>
                            <td>
                                <select id="isFocus">
                                    <option value="0">否</option>
                                    <option value="1">是</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>首页图片：<br/>（最佳尺寸：300*260）</th>
                            <td colspan="3"><input id="uploadinfo" type="file" name="uploadinfo" class="easyui-validatebox"/></td>
                        </tr>
                    </c:if>
                    <c:if test="${catalog.parentID!=9 }">
                        <input type="hidden" id="isTop" value="0">
                        <input type="hidden" id="isFocus" value="0">
                    </c:if>
                    <input type="hidden" id="visitCount" value="0">
                    <tr>
                        <td colspan="4">
                            <textarea id="contents"></textarea>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
        <div region="south" border="false" style="text-align: center; height: 50px; line-height: 50px;">
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newContents_page.saveNewContents()">
                保存</a>
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
            <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" onClick="newContents_page.closeInfoTipWin()">
                确认</a>
        </div>
    </div>
</div>
</body>
</html>