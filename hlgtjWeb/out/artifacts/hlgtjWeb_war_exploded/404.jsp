<%@ page language="java" contentType="text/html; charset=GBK"
	isErrorPage="true" pageEncoding="utf-8"%>

<%
	response.setStatus(HttpServletResponse.SC_OK);
%>
<%
	/**
	 * 本页面是在客户查找的页面无法找到的情况下调用的
	 */
	response.setStatus(HttpServletResponse.SC_OK);
%>
<%
    String path=request.getContextPath();
    String domain=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    String basePath=domain+path;
    pageContext.setAttribute("ctx",path);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
<TITLE>404出错啦：文件没找到！</TITLE>
<META http-equiv=Content-Language content=en-us>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<!-- <META http-equiv=refresh content="2;URL = http://www.leadto.com.cn/"> -->
<STYLE type=text/css>
A {
	TEXT-DECORATION: none
}

A:link {
	COLOR: #001111;
	FONT-FAMILY: 宋体;
	TEXT-DECORATION: none
}

A:visited {
	COLOR: #001111;
	FONT-FAMILY: 宋体;
	TEXT-DECORATION: none
}

A:active {
	FONT-FAMILY: 宋体;
	TEXT-DECORATION: none
}

A:hover {
	BORDER-TOP-WIDTH: 1px;
	BORDER-LEFT-WIDTH: 1px;
	FONT-SIZE: 12px;
	COLOR: #ff0000;
	BORDER-BOTTOM: 1px dotted;
	BORDER-RIGHT-WIDTH: 1px;
	TEXT-DECORATION: none
}

BODY {
	SCROLLBAR-FACE-COLOR: #e8e7e7;
	FONT-SIZE: 12px;
	SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
	SCROLLBAR-SHADOW-COLOR: #ffffff;
	COLOR: #001111;
	SCROLLBAR-3DLIGHT-COLOR: #cccccc;
	SCROLLBAR-ARROW-COLOR: #ff6600;
	SCROLLBAR-TRACK-COLOR: #efefef;
	FONT-FAMILY: 宋体;
	SCROLLBAR-DARKSHADOW-COLOR: #b2b2b2;
	SCROLLBAR-BASE-COLOR: #000000;
	BACKGROUND-COLOR: #ffffff
}

TABLE {
	FONT-SIZE: 9pt;
	FONT-FAMILY: 宋体;
	BORDER-COLLAPSE: collapse
}

.button {
	BORDER-RIGHT: #5589aa 1px solid;
	BORDER-TOP: #5589aa 1px solid;
	FONT-SIZE: 9pt;
	BACKGROUND: url(image/ButtonBg.gif) #f6f6f9;
	BORDER-LEFT: #5589aa 1px solid;
	WIDTH: 50px;
	COLOR: #000000;
	BORDER-BOTTOM: #5589aa 1px solid;
	HEIGHT: 18px
}

.lanyu {
	BORDER-RIGHT: #5589aa 1px solid;
	BORDER-TOP: #5589aa 1px solid;
	FONT-SIZE: 12px;
	BORDER-LEFT: #5589aa 1px solid;
	COLOR: #000000;
	BORDER-BOTTOM: #5589aa 1px solid
}

.font {
	FONT-SIZE: 9pt;
	FILTER: DropShadow(Color = #cccccc, OffX = 2, OffY = 1, Positive = 2);
	TEXT-DECORATION: none
}
</STYLE>

<META content="MSHTML 6.00.2900.2523" name=GENERATOR>
</HEAD>
<BODY bgColor=#ffffff leftMargin=0 topMargin=0>
	<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%"
		align=center border=0>
		<TBODY>
			<TR>
				<TD vAlign=center align=middle>
					<DIV align=center>
						<CENTER>
							<TABLE style="BORDER-COLLAPSE: collapse" borderColor=#111111
								height=340 cellSpacing=0 cellPadding=0 width=700 border=0>
								<TBODY>
									<TR>
										<TD vAlign=center width=700 height=340>
											<P align=center>
												<IMG src="${ctx }/resources/web/image/notfound.gif" border=0>
											</P>
											<P align=center>
												<SPAN lang=zh-cn><B><FONT color=#ff0000>出错啦：</FONT></B><FONT
													color=#ff0000>文件没找到！</FONT></SPAN>
											</P>
											<P align=center>
												<FONT color=#ff0000><B>建议：&nbsp;&nbsp; </B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												</FONT>
											</P>
											<P align=center>
												1.你可以刷新（F5）下下看看，不过估计效果不大。<br> <BR>&nbsp;
												2.返回主页咯，点击主页地址：<FONT color=#ff0000> <A href="${ctx }"><U><FONT
															color=#0000ff>揭阳市发展和改革局主页</FONT></U></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												</FONT>
											</P>
											<P align=center></P>
											<P align=center></P>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</CENTER>
					</DIV>
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</BODY>
<script language="JavaScript">
		//session过期可以跳出iframe
		if (window != top)
			top.location.href = location.href;
	</script>
</HTML>