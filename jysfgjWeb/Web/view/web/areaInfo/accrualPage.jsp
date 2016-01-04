<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>揭阳市发展和改革局</title>
<script>
	function changeTableByType(id){
		if(id == '0'){
			for(var i = 1;i < 11;i++){
				$("#span"+i).show();
				$("#table"+i).show();
			}
		}else{
			for(var i = 1;i<11;i++){
				if(i==parseInt(id)){
					$("#span"+id).show();
					$("#table"+id).show();
				}else{
					$("#span"+i).hide();
					$("#table"+i).hide();
				}
			}
		}
	}
</script>
</head>
<body>
<%@include file="../../web/head.jsp" %>

<link rel="stylesheet" type="text/css" href="${ctx}/resources/web/style/baguetteBox.css" />
<div class="wrapper">
	<div class="inner">
    
    	<div class="accrual">
		<table class="csstable">
			<tr>
				<th><a href="javascript:void(0);" onclick="changeTableByType(0);">全部</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(1);">行政许可</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(2);">非行政许可审批</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(3);">行政处罚</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(4);">行政强制</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(5);">行政征收</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(6);">行政给付</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(7);">行政检查</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(8);">行政指导</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(9);">行政确认</a></th>
				<th><a href="javascript:void(0);" onclick="changeTableByType(10);">其他</a></th>
			</tr>
		</table>
		<span id="span1">行政许可（${fn:length(list1)}）</span>
        <table id="table1" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td width="150">子项名称</td>
        		<td width="450">实施依据</td>
        		<td width="60">审批对象</td>
        		<td width="60">其他共同审批部门</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list1}" var="item" varStatus="status">
        		<tr>
        			<th rowspan="${fn:length(item.childList)}">${status.index+1 }</th>
	        		<td rowspan="${fn:length(item.childList)}">${item.title }</td>
	        		<c:forEach items="${item.childList }" var="childItem" begin="0" end="0">
			        	<td>${childItem.title }</td>
				        <td>${childItem.contents }</td>
				        <td>${childItem.approvalObject }</td>
				        <td>${childItem.approvalDept }</td>
				        <td>${childItem.remark }</td>
		        	</c:forEach>
        		</tr>
	        	<c:forEach items="${item.childList }" var="childItem" begin="1" >
	        		<tr>
			        	<td>${childItem.title }</td>
				        <td>${childItem.contents }</td>
				        <td>${childItem.approvalObject }</td>
				        <td>${childItem.approvalDept }</td>
				        <td>${childItem.remark }</td>
				    </tr>
		        </c:forEach>
        	</c:forEach>
        </table> 
        <span id="span2">非行政许可审批（${fn:length(list2)}）</span>
        <table id="table2" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td width="150">子项名称</td>
        		<td width="450">实施依据</td>
        		<td width="60">审批对象</td>
        		<td width="60">其他共同审批部门</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list2}" var="item" varStatus="status">
        		<tr>
        			<th rowspan="${fn:length(item.childList)}">${status.index+1 }</th>
	        		<td rowspan="${fn:length(item.childList)}">${item.title }</td>
	        		<c:forEach items="${item.childList }" var="childItem" begin="0" end="0">
			        	<td>${childItem.title }</td>
				        <td>${childItem.contents }</td>
				        <td>${childItem.approvalObject }</td>
				        <td>${childItem.approvalDept }</td>
				        <td>${childItem.remark }</td>
		        	</c:forEach>
        		</tr>
	        	<c:forEach items="${item.childList }" var="childItem" begin="1" >
	        		<tr>
			        	<td>${childItem.title }</td>
				        <td>${childItem.contents }</td>
				        <td>${childItem.approvalObject }</td>
				        <td>${childItem.approvalDept }</td>
				        <td>${childItem.remark }</td>
				    </tr>
		        </c:forEach>
        	</c:forEach>
        </table>
        <span id="span3">行政处罚（${fn:length(list3)}）</span> 
        <table id="table3" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td>可予处罚的违法行为</td>
        		<td>处罚种类</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list3}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
			        <td>${item.punishType }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>  
        <span id="span4">行政强制（${fn:length(list4)}）</span>      
		<table id="table4" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td>行政强制对象</td>
        		<td>行政强制措施</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list4}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
			        <td>${item.compulsoryMeasures }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span5">行政征收（${fn:length(list5)}）</span>
        <table id="table5" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">征收项目</td>
        		<td>征收标准</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list5}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
			        <td>${item.levyStandard }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span6">行政给付（${fn:length(list6)}）</span>
        <table id="table6" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list6}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span7">行政检查（${fn:length(list7)}）</span>
        <table id="table7" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list7}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span8">行政指导（${fn:length(list8)}）</span>
        <table id="table8" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list8}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span9">行政确认（${fn:length(list9)}）</span>
        <table id="table9" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list9}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        <span id="span10">其他（${fn:length(list10)}）</span>
        <table id="table10" class="csstable">
        	<tr class="trbg">
        		<td width="30">序号</td>
        		<td width="150">项目名称</td>
        		<td>实施依据</td>
        		<td width="60">备注</td>
        	</tr>
        	<c:forEach items="${list10}" var="item" varStatus="status">
        		<tr>
	        		<th>${status.index+1 }</th>
		        	<td>${item.title }</td>
				    <td>${item.contents }</td>
				    <td>${item.remark }</td>
        		</tr>
        	</c:forEach>
        </table>
        </div>
	</div>
</div>

<%@include file="../../web/foot.jsp" %>

</body>
</html>