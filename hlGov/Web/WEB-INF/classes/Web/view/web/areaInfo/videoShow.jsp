<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>惠来县人民政府门户网站</title>
<script type="text/javascript" src="../resources/ckplayer/js/offlights.js"></script>
<script type="text/javascript" src="../resources/ckplayer/ckplayer/ckplayer.js" charset="utf-8"></script>
</head>

<body>
<%@include file="../../web/head.jsp" %>

  <script type="text/javascript">
	//如果你不需要某项设置，可以直接删除，注意var flashvars的最后一个值后面不能有逗号
	var flashvars={
		f:'<%=basePath+"/"+request.getAttribute("videoUrl")%>',
		a:'',//调用时的参数，只有当s>0的时候有效
		s:'0',//调用方式，0=普通方法（f=视频地址），1=网址形式,2=xml形式，3=swf形式(s>0时f=网址，配合a来完成对地址的组装)
		c:'0',//是否读取文本配置,0不是，1是
		x:'',//调用xml风格路径，为空的话将使用ckplayer.js的配置
		i:'',//初始图片地址
		d:'',//暂停时播放的广告，swf/图片,多个用竖线隔开，图片要加链接地址，没有的时候留空就行
		u:'',//暂停时如果是图片的话，加个链接地址
		l:'',//前置广告，swf/图片/视频，多个用竖线隔开，图片和视频要加链接地址
		r:'',//前置广告的链接地址，多个用竖线隔开，没有的留空
		t:'10|10',//视频开始前播放swf/图片时的时间，多个用竖线隔开
		y:'',//这里是使用网址形式调用广告地址时使用，前提是要设置l的值为空
		z:'',//缓冲广告，只能放一个，swf格式
		e:'3',//视频结束后的动作，0是调用js函数，1是循环播放，2是暂停播放并且不调用广告，3是调用视频推荐列表的插件，4是清除视频流并调用js功能和1差不多，5是暂停播放并且调用暂停广告
		v:'80',//默认音量，0-100之间
		p:'0',//视频默认0是暂停，1是播放
		h:'0',//播放http视频流时采用何种拖动方法，=0不使用任意拖动，=1是使用按关键帧，=2是按时间点，=3是自动判断按什么(如果视频格式是.mp4就按关键帧，.flv就按关键时间)，=4也是自动判断(只要包含字符mp4就按mp4来，只要包含字符flv就按flv来)
		q:'',//视频流拖动时参考函数，默认是start
		m:'0',//默认是否采用点击播放按钮后再加载视频，0不是，1是,设置成1时不要有前置广告
		o:'',//当m=1时，可以设置视频的时间，单位，秒
		w:'',//当m=1时，可以设置视频的总字节数
		g:'',//视频直接g秒开始播放
		j:'',//视频提前j秒结束
		k:'30|60',//提示点时间，如 30|60鼠标经过进度栏30秒，60秒会提示n指定的相应的文字
		n:'这是提示点的功能，如果不需要删除n和j的值|提示点测试60秒',//提示点文字，跟k配合使用，如 提示点1|提示点2
		wh:'',//这是6.2新增加的宽高比，可以自己定义视频的宽高或宽高比如：wh:'4:3',或wh:'1080:720'
		ct:'2',//6.2新增加的参数，主要针对有些视频拖动时时间出错的修正参数，默认是2，自动修正，1是强制修正，0是强制不修正
		//调用播放器的所有参数列表结束
		//以下为自定义的播放器参数用来在插件里引用的
		my_url:encodeURIComponent(window.location.href)//本页面地址
		//调用自定义播放器参数结束
		};
	var params={bgcolor:'#FFF',allowFullScreen:true,allowScriptAccess:'always'};//这里定义播放器的其它参数如背景色（跟flashvars中的b不同），是否支持全屏，是否支持交互
	var attributes={id:'ckplayer_a1',name:'ckplayer_a1',menu:'false'};
	//下面一行是调用播放器了，括号里的参数含义：（播放器文件，要显示在的div容器，宽，高，需要flash的版本，当用户没有该版本的提示，加载初始化参数，加载设置参数如背景，加载attributes参数，主要用来设置播放器的id）
	swfobject.embedSWF('../resources/ckplayer/ckplayer/ckplayer.swf', 'a1', '700', '480', '10.0.0','../resources/ckplayer/ckplayer/expressInstall.swf', flashvars, params, attributes);
	/*播放器地址，容器id，宽，高，需要flash插件的版本，flashvars,params,attributes
	  如果你因为目前的swfobject和你项目中的存在冲突，不想用swfobject.embedSWF调用，也可以用如下代码进行调用
	  CKobject.embedSWF('ckplayer/ckplayer.swf','a1','ckplayer_a1','600','400',flashvars,params);
	  CKobject.embedSWF(播放器路径,容器id,播放器id/name,播放器宽,播放器高,flashvars的值,其它定义也可省略);
	  此时可以删除ckplayer.js中的最后一行，交互的部分也要改成CKobject.getObjectById('ckplayer_a1')
	*/
	//调用ckplayer的flash播放器结束
	/*
	下面三行是调用html5播放器用到的
	var video='视频地址和类型';
	var support='支持的平台或浏览器内核名称';	
	*/
	//var video=[''];
	//var support=['iPad','iPhone','ios','android+false','msie10+false'];//默认的在ipad,iphone,ios设备中用html5播放,android,ie10上没有安装flash的也调用html5
	//CKobject.embedHTML5('video','ckplayer_a1',600,400,video,flashvars,support);
	/*
	如果不想使用html5播放器，只要把上面三行去掉就可以了
	=================================================================
	以下代码并不是播放器里的，只是播放器应用时用到的
	=================================================================
	*/
	function playerstop(){
		//只有当调用视频播放器时设置e=0或4时会有效果
		alert("播放完成");	
	}
	var _nn=0;//用来计算实时监听的条数的，超过100条记录就要删除，不然会消耗内存
	var watt=false;
	function ckplayer_status(str){
		_nn+=1;
		if(_nn>200){
			_nn=0;
			document.getElementById('statusvalue').value='';
		}
		document.getElementById('statusvalue').value=str+'\n'+document.getElementById('statusvalue').value;
		if(str=='video:play'){
			if(!watt){
				watt=true;
				setInterval('getstart()',1000);
			}
		}

	}
	function getstart(){
		var a=swfobject.getObjectById('ckplayer_a1').ckplayer_getstatus();
		var ss='';
		for (var k in a){
			ss+=k+":"+a[k]+'\n';
		}
		document.getElementById('obj').innerHTML=ss;
	}
	function aboutstr(str,f){//查看str字符里是否有f
		var about=false;
		var strarray=new Array();
		var farray=new Array();
		farray=f.split(",");
		if(str){
			for(var i=0;i<farray.length;i++){
				strarray=str.split(farray[i]);
				if(strarray.length>1){
					about=true;
					break;
				}
			}
		}
		return about;
	}
	//开关灯
	var box = new LightBox();
	function closelights(){//关灯
		box.Show();
		CKobject._K_('video').style.width='940px';
		CKobject._K_('video').style.height='550px';
		swfobject.getObjectById('ckplayer_a1').width=940;
		swfobject.getObjectById('ckplayer_a1').height=550;
	}
	function openlights(){//开灯
		box.Close();
		CKobject._K_('video').style.width='600px';
		CKobject._K_('video').style.height='400px';
		swfobject.getObjectById('ckplayer_a1').width=600;
		swfobject.getObjectById('ckplayer_a1').height=400;
	}
	function changeVideo(url){
		swfobject.getObjectById('ckplayer_a1').ckplayer_newaddress(url);
	}
	
  </script>

<div class="wrapper">
	<div class="inner">
    	<div class="side"> 
			<%@include file="../../web/leftCatalog.jsp" %>
        </div>
        <div class="main">
        	<div class="position"><span>当前位置：</span><a href="${ctx}/web/index.action">网站首页</a> > 
			<c:if test="${leftTitle=='news'}">
        		<a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
    				新闻资讯
    			</a>
    			> <b>${catalog.title}</b>
    		</c:if>
    		<c:if test="${leftTitle=='contents'}">
    			<a href="${ctx}/web/areaInfoPage.action">
    				走进惠来
    			</a>
    			> <b>${catalog.title}</b>
    		</c:if>
    		<c:if test="${leftTitle=='announcement'}">
    			<a href="${ctx}/web/areaInfoList.action?type=${leftTitle }&catalogID=${leftCatalogList[0].theID}">
    				通知公告
				</a>
    		</c:if> </div>
        	<div class="list">
            	<h3><span>${video.title}</span></h3>
            	<div id="video" style="position:relative;z-index:100;width:700px;height:500px;float:left;">
                <div id="a1"></div>
                </div>
                <div style="text-align:right; color:#999;">播放次数：${video.viewedNum }</div>
            </div>
        	                               
        </div>
    </div>
</div>
<%@include file="../../web/foot.jsp" %>
</body>
</html>


