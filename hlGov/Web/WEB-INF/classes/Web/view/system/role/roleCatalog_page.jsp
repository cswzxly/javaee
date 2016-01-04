<%@ page language="java" pageEncoding="utf-8" %>
<%@ include file="/view/system/comm/comm.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>栏目权限配置</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/zTree/css/demo.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/system/js/zTree/css/zTreeStyle/zTreeStyle.css">
    <script type="text/javascript" src="${ctx}/resources/system/js/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/system/js/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <style>
	.panel-body{ overflow:hidden; height:auto !important;}
	</style>
</head>

<body>

<div class="easyui-panel" title="栏目权限配置" style="width:700px;height:500px" data-options="toolbar: '#tb'">

    <div id="tb" style="height:auto" class="datagrid-toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-back',plain:true" id="backRoleBtn">返回</a>
    </div>
    <div style="padding:10px 10px 10px 10px">
        <form id="editCatalogForm" method="post">
            <table class="formtable">
                <tr>
                    <td class="zTreeDemoBackground center">
                        <ul id="treeDemo" class="ztree"></ul>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div region="south" border="false" style="text-align: center; height: 30px; line-height: 30px;">
        <a class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" id="saveBtn">保存</a>
        <a class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)" id="cancelBtn">取消</a>
    </div>
</div>
</body>

<script>

    var setting = {
        check: {
            enable: true,
            chkboxType: {
                "Y": "sp",
                "N": "sp"
            }
        },
        data: {
            simpleData: {
                enable: true
            }
        }
    };

    function saveTree() {
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);
        var ids = "";
        for (var i = 0; i < nodes.length; i++) {
            if (i == nodes.length - 1) {
                ids = ids + nodes[i].id;
            } else if (i == 0) {
                ids = nodes[i].id + ",";
            } else {
                ids = ids + nodes[i].id + ",";
            }
        }
        $.ajax({
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {'roleID': ${roleID}, 'ids': ids},
            url: "${ctx}/permit/saveTree.action",
            error: function () {
                alert("操作失败！");
            },
            success: function (data) {
                if (data.code == "00") {
                    window.location.href = "${ctx}/role/rolePage.action";
                } else {
                    alert(data.message);
                }
            }
        });
    }

    $(document).ready(function () {
        $('#backRoleBtn').click(function () {
            window.location.href = "${ctx}/role/rolePage.action";
        });

        $('#cancelBtn').click(function () {
            window.location.href = "${ctx}/role/rolePage.action";
        });

        $('#saveBtn').click(function () {
            saveTree();
        });

        $.ajax({
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {'roleID': ${roleID}},
            url: "${ctx}/permit/showTree.action",
            error: function () {
                alert("操作失败！");
            },
            success: function (data) {
                $.fn.zTree.init($("#treeDemo"), setting, data);
            }
        });
    });

</script>
</html>