<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/ztree/js/jquery.ztree.core-3.5.js"></script>
<title>揭阳空港经济区</title>
</head>
<body>

	<div class="zTreeDemoBackground">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	
	
	<input type="hidden" name="theID" id="theID">
    
	<script type="text/javascript">
    var setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onClick: onClick
        }
    };
    
    function onClick(event, treeId, treeNode, clickFlag) {
        //alert(treeNode.id);
        $('#theID').val(treeNode.id);
        window.parent.document.getElementById("rightFrame").src="officeContentsList.action?theID="+treeNode.id;
    }		
    
    $(document).ready(function(){
        $.fn.zTree.init($("#treeDemo"), setting, eval('${array}'));
    });
    </script>    
</body>
</html>