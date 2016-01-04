package com.web.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.system.pojo.*;
import com.web.services.*;

import org.springframework.beans.factory.annotation.Autowired;

import com.system.action.BaseAction;
import com.system.bean.AllClassBean;
import com.system.services.OptionServices;
import com.system.utils.DateUtils;
import com.web.pojo.SearchVO;
import com.web.utils.Arithmetic;
import com.web.utils.HtmlRegexpUtil;
import com.web.utils.PropertiesUtils;

/**
 * @author hchch
 *         <p/>
 *         2014年8月15日
 */
public class IndexAction extends BaseAction {

    private static final long serialVersionUID = 1L;
    @Autowired
    private FrontCatalogServices frontCatalogServices;
    @Autowired
    private FrontLinksServices frontLinksServices;
    @Autowired
    private FrontContentsServices frontContentsServices;
    @Autowired
    private FrontVideoServices frontVideoServices;

    @Autowired
    private FrontFileInfoServices frontFileInfoServices;
    @Autowired
    private FrontSearchServices frontSearchServices;

    @Resource(name = "frontOpenCatalogServices")
    private FrontOpenCatalogServices frontOpenCatalogServices;


    @Resource(name = "frontSurveyServices")
    private FrontSurveyServices frontSurveyServices;

    @Resource(name = "frontSurveyInfoServices")
    private FrontSurveyInfoServices frontSurveyInfoServices;

    @Resource(name = "frontZlCatalogServices")
    private FrontZlCatalogServices frontZlCatalogServices;

    @Resource(name = "frontOpenContentsServices")
    private FrontOpenContentsServices frontOpenContentsServices;

    @Resource(name = "frontZlContentsServices")
    private FrontZlContentsServices frontZlContentsServices;

    @Autowired
    private OptionServices optionServices;
    @Resource(name="frontOpinionPollServices")
	private FrontOpinionPollServices frontOpinionPollServices;

    @Autowired
    private FrontTitlepicServices frontTitlepicServices;
    @Autowired
    private FrontLetterServices frontLetterServices;

    public String index() {
        logger.info(">>>>>>>>>>IndexAction:index>>>>>>>>>>");

        String path = request.getSession().getServletContext().getRealPath("/");
        String propertiesPath = path + "WEB-INF/classes/web_index.properties";
        String value = "";
        Integer[] ids;
        
        Arithmetic des = new Arithmetic();

//        //网上调查
//        logger.info(">>>>>>>>>>IndexAction:index:网上调查>>>>>>>>>>");
//        Survey s = new Survey();
//        s.setStatus("1");
//        List<Survey> list = frontSurveyServices.front_queryAllSurveyList(s);
//        Iterator<Survey> it = list.iterator();
//        List<Survey> sl = new ArrayList<Survey>();
//        while (it.hasNext()) {
//            Survey survey = (Survey) it.next();
//            List<SurveyInfo> listInfo = frontSurveyInfoServices.front_querySurveyInfo(survey.getTheID().toString());
//            if (listInfo.size() < 1) {
//                sl.add(survey);
//            }
//        }
//        list.removeAll(sl);
//        if(list != null && list.size() > 0){
//        	for(Survey survey : list){
//        		survey.setDesId(des.getEncString(survey.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("list", list);
//
//        //民意征集
//        logger.info(">>>>>>>>>>IndexAction:index:民意征集>>>>>>>>>>");
//        OpinionPoll op = new OpinionPoll();
//		op.setStatus("1");
//		op.setNowDate(DateUtils.getServerDate());
//		List<OpinionPoll> contents45List = frontOpinionPollServices.queryOpinionPollListByBean(op);
//		if(contents45List != null && contents45List.size() > 0){
//			for(int i = 0;i < contents45List.size();i++){
//				contents45List.get(i).setDesId(des.getEncString(contents45List.get(i).getTheID().toString()));
//			}
//		}
//		request.setAttribute("contents45List", contents45List);


        //时政要闻头条@catalogID=10
        logger.info(">>>>>>>>>>IndexAction:index:时政要闻头条>>>>>>>>>>");
        Contents contents10 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "szywCatalogID");
        contents10.setCatalogID(Integer.valueOf(value));
        contents10.setStatus("1");
        contents10.setTopNum(null);
        contents10.setIsTop("1");
        contents10 = frontContentsServices.queryContentsByBean(contents10);
        
        //时政要闻@catalogID=10
        logger.info(">>>>>>>>>>IndexAction:index:时政要闻>>>>>>>>>>");
        if (contents10 != null && contents10.getTheID() != null) {//如果有头条新闻，则查询7条新闻
        	contents10.setContents(HtmlRegexpUtil.Html2Text(contents10.getContents()));
        	contents10.setDesId(des.getEncString(contents10.getTheID().toString()));
        	request.setAttribute("contents10", contents10);
            contents10 = new Contents();
            contents10.setCatalogID(Integer.valueOf(value));
            contents10.setStatus("1");
            contents10.setTopNum("6");
            contents10.setIsTop("0");
            List<Contents> contents10List = frontContentsServices.queryTopContentsList(contents10);
            Catalog catalog10 = frontCatalogServices.queryCatalogByID(value);
            request.setAttribute("catalog10", catalog10);
            if(contents10List != null && contents10List.size() > 0){
            	for(Contents c : contents10List){
            		c.setDesId(des.getEncString(c.getTheID().toString()));
            	}
            }
            request.setAttribute("contents10List", contents10List);
        } else {//如果没有头条新闻，则查询8条新闻，第一条为头条新闻
            contents10 = new Contents();
            contents10.setCatalogID(Integer.valueOf(value));
            contents10.setStatus("1");
            contents10.setTopNum("9");
            contents10.setIsTop("0");
            List<Contents> contents10List = frontContentsServices.queryTopContentsList(contents10);
            Catalog catalog10 = frontCatalogServices.queryCatalogByID(value);
            request.setAttribute("catalog10", catalog10);
            if(contents10List != null && contents10List.size() > 0){
            	for(Contents c : contents10List){
            		c.setDesId(des.getEncString(c.getTheID().toString()));
            	}
            }
            request.setAttribute("contents10List", contents10List);
        }

        //新闻图片
        logger.info(">>>>>>>>>>IndexAction:index:新闻图片>>>>>>>>>>");
        AllClassBean picBean = new AllClassBean();
        value = PropertiesUtils.readValue(propertiesPath, "xwtpCatalogPID");
        picBean.setCatalogPID(value);
        picBean.setIsindex("1");
        picBean.setFileType("1");
        picBean.setTopNum("4");
        List<AllClassBean> picIndexList = frontFileInfoServices.queryTopPicIndex(picBean);
        request.setAttribute("picIndexList", picIndexList);

//        //专题
//        logger.info(">>>>>>>>>>IndexAction:index:专题>>>>>>>>>>");
//        Catalog catalog = new Catalog();
//        value = PropertiesUtils.readValue(propertiesPath, "ztCatalogPID");
//        catalog.setCatalogType("t_specialTopic");
//        catalog.setParentID(value);
////		catalog.setTopNum("5");
//        List<Catalog> ztCatalogList = frontCatalogServices.queryCatalogListByBean(catalog);
////		List<Catalog> ztCatalogList = frontCatalogServices.queryTopCatalogList(catalog);
//        request.setAttribute("ztCatalogList", ztCatalogList);

//        //空港视频
//        logger.info(">>>>>>>>>>IndexAction:index:空港视频>>>>>>>>>>");
//        Video video = new Video();
//        value = PropertiesUtils.readValue(propertiesPath, "kgspCatalogID");
//        video.setCatalogID(Integer.valueOf(value));
//        video.setStatus("1");
//        video.setTopNum("10");
//        List<Video> videoList = frontVideoServices.queryTopVideoList(video);
//        Catalog catalogVideo = frontCatalogServices.queryCatalogByID(value);
//        request.setAttribute("catalogVideo", catalogVideo);
//        if(videoList != null && videoList.size() > 0){
//        	for(Video v : videoList){
//        		v.setDesId(des.getEncString(v.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("videoList", videoList);

//        //首页视频
//        logger.info(">>>>>>>>>>IndexAction:index:首页视频>>>>>>>>>>");
//        video = new Video();
//        video.setStatus("1");
//        video.setIsindex("1");
//        video.setTopNum("1");
//        List<Video> videoList2 = frontVideoServices.queryTopVideoList(video);
//        if (videoList2 != null && videoList2.size() > 0) {
//            request.setAttribute("videoIndex", videoList2.get(0));
//        }
//        //首页视频是否自动播放
//        logger.info(">>>>>>>>>>IndexAction:index:首页视频是否自动播放>>>>>>>>>>");
        Option option = new Option();
//        option.setItem("videoAutoPlay");
//        option = optionServices.queryOptionByBean(option);
//        boolean autostart = false;
//        if (option.getCode().equals("1")) {
//            autostart = true;
//        }
//        request.setAttribute("autostart", autostart);

        //首页对联是否显示
        logger.info(">>>>>>>>>>IndexAction:index:首页对联是否显示>>>>>>>>>>");
        option = new Option();
        option.setItem("dlPicShow");
        option = optionServices.queryOptionByBean(option);
        request.setAttribute("isDlShow", option.getCode());

        //便民服务
        logger.info(">>>>>>>>>>IndexAction:index:便民服务>>>>>>>>>>");
        Links sLinks = new Links();
        sLinks.setLinkKind("2");
        sLinks.setTopNum("12");
        sLinks.setStatus("1");
        List<Links> sLinksList = frontLinksServices.queryTopLinksList(sLinks);
        request.setAttribute("sLinksList", sLinksList);

        //图片友情连接
        logger.info(">>>>>>>>>>IndexAction:index:图片友情连接>>>>>>>>>>");
        Links picLinks = new Links();
        picLinks.setLinkKind("1");
        picLinks.setLink_type("1");
        picLinks.setStatus("1");
        picLinks.setTopNum("5");
        List<Links> picLinksList = frontLinksServices.queryTopLinksList(picLinks);
        request.setAttribute("picLinksList", picLinksList);

        //所属框友情连接
        logger.info(">>>>>>>>>>IndexAction:index:所属框友情连接>>>>>>>>>>");
        Links links = new Links();
        links.setLinkKind("1");
        links.setLink_type("2");
        links.setStatus("1");
        List<Links> selectLinksList = frontLinksServices.queryLinksListByBean(links);
        request.getSession().setAttribute("selectLinksList", selectLinksList);
        
//	    String sysPropertiesPath = path + "WEB-INF/classes/system.properties";
//	    String sysValue = "";
//	    sysValue = PropertiesUtils.readValue(sysPropertiesPath, "linksKeyNum");
//		String key = "";
//		Map<String,String> map = new HashMap<String,String>();
//		if(Integer.valueOf(sysValue).intValue() > 0){
//			int linksKeyNum = Integer.valueOf(sysValue);
//			for(int i = 1;i <= linksKeyNum;i++){
//				key = "linksKey"+i;
//				sysValue = PropertiesUtils.readValue(sysPropertiesPath, key);
//				map.put(key, sysValue);
//			}
//			request.setAttribute("linksKeyNum", linksKeyNum);
//			request.setAttribute("linksMap", map);
//		}

        //信息公开栏目
//        logger.info(">>>>>>>>>>IndexAction:index:信息公开栏目>>>>>>>>>>");
//        OpenCatalog openCatalog = new OpenCatalog();
//        value = PropertiesUtils.readValue(propertiesPath, "xxgkCatalogPID");
//        openCatalog.setParentID(value);
//        openCatalog.setStatus("1");
//        List<OpenCatalog> openTop8 = frontOpenCatalogServices.queryTopOpenCatalogList(openCatalog);
//        request.setAttribute("openTop8", openTop8);

        //重点领域栏目
//        logger.info(">>>>>>>>>>IndexAction:index:重点领域栏目>>>>>>>>>>");
//        ZlCatalog zlcatalog = new ZlCatalog();
//        value = PropertiesUtils.readValue(propertiesPath, "zdlyCatalogPID");
//        zlcatalog.setParentID(value);
//        zlcatalog.setStatus("1");
//        List<ZlCatalog> zlTop8 = frontZlCatalogServices.queryTopZlCatalogList(zlcatalog);
//        request.setAttribute("zlTop8", zlTop8);

        //信息公开_政府文件
//        logger.info(">>>>>>>>>>IndexAction:index:信息公开_政府文件>>>>>>>>>>");
//        OpenContents openContents = new OpenContents();
//        openContents.setTopNum("10");
//        value = PropertiesUtils.readValue(propertiesPath, "zfwjCatalogID");
//        openContents.setCatalogID(value);
//        List<OpenContents> openTop8Contents = frontOpenContentsServices.queryTopOpenContentsList(openContents);
//        request.setAttribute("openTop8Contents", openTop8Contents);
//        //重点领域_政府公报
//        logger.info(">>>>>>>>>>IndexAction:index:重点领域_政府公报>>>>>>>>>>");
//        ZlContents zlContents = new ZlContents();
//        zlContents.setTopNum("8");
//        value = PropertiesUtils.readValue(propertiesPath, "zfgbCatalogID");
//        zlContents.setCatalogID(value);
//        List<ZlContents> zfgbContents = frontZlContentsServices.queryTopZlContentsList(zlContents);
//        request.setAttribute("zfgbContents", zfgbContents);

        //重点领域_人事任免
        //logger.info(">>>>>>>>>>IndexAction:index:重点领域_人事任免>>>>>>>>>>");
        //zlContents = new ZlContents();
        //zlContents.setTopNum("8");
        //value = PropertiesUtils.readValue(propertiesPath, "rsrmCatalogID");
        //zlContents.setCatalogID(value);
        //List<ZlContents> zlTop8Contents = frontZlContentsServices.queryTopZlContentsList(zlContents);
        //request.setAttribute("zlTop8Contents", zlTop8Contents);
        
        //重点领域_重大项目
        //logger.info(">>>>>>>>>>IndexAction:index:重点领域_重大项目>>>>>>>>>>");
        //zlContents = new ZlContents();
        //zlContents.setTopNum("8");
        //value = PropertiesUtils.readValue(propertiesPath, "zdxmCatalogID");
        //zlContents.setCatalogID(value);
        //List<ZlContents> zdxmContents = frontZlContentsServices.queryTopZlContentsList(zlContents);
        //request.setAttribute("zdxmContents", zdxmContents);

        //重大项目
//        logger.info(">>>>>>>>>>IndexAction:index:重大项目>>>>>>>>>>");
//        Contents contents171 = new Contents();
//        value = PropertiesUtils.readValue(propertiesPath, "zdxmCatalogID");
//        contents171.setCatalogID(Integer.valueOf(value));
//        contents171.setStatus("1");
//        contents171.setTopNum("8");
//        List<Contents> content171List = frontContentsServices.queryTopContentsList(contents171);
//        if(content171List != null && content171List.size() > 0){
//        	for(Contents c : content171List){
//        		c.setDesId(des.getEncString(c.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("content171List", content171List);

        //人事信息
//        logger.info(">>>>>>>>>>IndexAction:index:人事信息>>>>>>>>>>");
//        Contents contents172 = new Contents();
//        value = PropertiesUtils.readValue(propertiesPath, "rsxxCatalogID");
//        contents172.setCatalogID(Integer.valueOf(value));
//        contents172.setStatus("1");
//        contents172.setTopNum("8");
//        List<Contents> content172List = frontContentsServices.queryTopContentsList(contents172);
//        if(content172List != null && content172List.size() > 0){
//        	for(Contents c : content172List){
//        		c.setDesId(des.getEncString(c.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("content172List", content172List);


        Contents contents43 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "jgzdtCatalogID");
        //局工作动态头条@catalogID=43
        logger.info(">>>>>>>>>>IndexAction:index:局工作动态头条>>>>>>>>>>");
        contents43.setCatalogID(Integer.valueOf(value));
        contents43.setStatus("1");
        contents43.setTopNum(null);
        contents43.setIsTop("1");
        contents43 = frontContentsServices.queryContentsByBean(contents43);
        
        //局工作动态@catalogID=43
        logger.info(">>>>>>>>>>IndexAction:index:局工作动态>>>>>>>>>>");
        if (contents43 != null && contents43.getTheID() != null) {//如果有头条新闻，则查询7条新闻
        	contents43.setContents(HtmlRegexpUtil.Html2Text(contents43.getContents()));
        	contents43.setDesId(des.getEncString(contents43.getTheID().toString()));
        	request.setAttribute("contents43", contents43);
            contents43 = new Contents();
            contents43.setCatalogID(Integer.valueOf(value));
            contents43.setStatus("1");
            contents43.setTopNum("6");
            contents43.setIsTop("0");
            List<Contents> contents43List = frontContentsServices.queryTopContentsList(contents43);
            Catalog catalog43 = frontCatalogServices.queryCatalogByID(value);
            request.setAttribute("catalog43", catalog43);
            if(contents43List != null && contents43List.size() > 0){
            	for(Contents c : contents43List){
            		c.setDesId(des.getEncString(c.getTheID().toString()));
            	}
            }
            request.setAttribute("contents43List", contents43List);
        } else {//如果没有头条新闻，则查询8条新闻，第一条为头条新闻
            contents43 = new Contents();
            contents43.setCatalogID(Integer.valueOf(value));
            contents43.setStatus("1");
            contents43.setTopNum("9");
            contents43.setIsTop("0");
            List<Contents> contents43List = frontContentsServices.queryTopContentsList(contents43);
            Catalog catalog43 = frontCatalogServices.queryCatalogByID(value);
            request.setAttribute("catalog43", catalog43);
            if(contents43List != null && contents43List.size() > 0){
            	for(Contents c : contents43List){
            		c.setDesId(des.getEncString(c.getTheID().toString()));
            	}
            }
            request.setAttribute("contents43List", contents43List);
        }

        //通知公告@catalogID=68
        logger.info(">>>>>>>>>>IndexAction:index:通知公告>>>>>>>>>>");
        Contents contents68 = new Contents();
        Integer zxtzCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "zxtzCatalogID"));
        Integer xmggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "xmggCatalogID"));
        Integer jfggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "jfggCatalogID"));
        Integer rsggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "rsggCatalogID"));
        Integer qtggCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "qtggCatalogID"));
        ids = new Integer[]{zxtzCatalogID, xmggCatalogID, jfggCatalogID, rsggCatalogID, qtggCatalogID};
        contents68.setIds(ids);
        contents68.setStatus("1");
        contents68.setTopNum("8");
        List<Contents> content186List = frontContentsServices.queryContentsByIds(contents68);
        if(content186List.size() > 0){
        	for(Contents c : content186List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content186List", content186List);

        //最新公示@catalogID=180
        logger.info(">>>>>>>>>>IndexAction:index:最新公示>>>>>>>>>>");
        Contents contents180 = new Contents();
        Integer smgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "smgsCatalogID"));
        Integer jfgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "jfgsCatalogID"));
        Integer qtgsCatalogID = Integer.valueOf(PropertiesUtils.readValue(propertiesPath, "qtgsCatalogID"));
        ids = new Integer[]{smgsCatalogID, jfgsCatalogID, qtgsCatalogID};
        contents180.setIds(ids);
        contents180.setStatus("1");
        contents180.setTopNum("8");
        List<Contents> content180List = frontContentsServices.queryTopContentsList(contents180);
        if(content180List.size() > 0){
        	for(Contents c : content180List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content187List", content180List);


        //发展规划@catalogID=5
        logger.info(">>>>>>>>>>IndexAction:index:发展规划>>>>>>>>>>");
        Contents contents5 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "fzghCatalogID");
        contents5.setCatalogID(Integer.valueOf(value));
        contents5.setStatus("1");
        contents5.setTopNum("8");
        List<Contents> content5List = frontContentsServices.queryTopContentsList(contents5);
        if(content5List.size() > 0){
        	for(Contents c : content5List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content5List", content5List);

        //重点项目@catalogID=171
        logger.info(">>>>>>>>>>IndexAction:index:重点项目>>>>>>>>>>");
        Contents contents171 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "zdxmCatalogID");
        contents171.setCatalogID(Integer.valueOf(value));
        contents171.setStatus("1");
        contents171.setTopNum("8");
        List<Contents> content171List = frontContentsServices.queryTopContentsList(contents171);
        if(content171List.size() > 0){
        	for(Contents c : content171List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content171List", content171List);

        //价费标准@catalogID=81
        logger.info(">>>>>>>>>>IndexAction:index:价费标准>>>>>>>>>>");
        Contents contents81 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "jfbzCatalogID");
        contents81.setCatalogID(Integer.valueOf(value));
        contents81.setStatus("1");
        contents81.setTopNum("8");
        List<Contents> contents81List = frontContentsServices.queryTopContentsList(contents81);
        if(contents81List.size() > 0){
        	for(Contents c : contents81List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("contents81List", contents81List);

        //粮食工作@catalogID=187
        logger.info(">>>>>>>>>>IndexAction:index:粮食工作>>>>>>>>>>");
        Contents contents187 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "lsgzCatalogID");
        contents187.setCatalogID(Integer.valueOf(value));
        contents187.setStatus("1");
        contents187.setTopNum("8");
        List<Contents> content187List = frontContentsServices.queryTopContentsList(contents187);
        if(content187List.size() > 0){
        	for(Contents c : content187List){
        		c.setDesId(des.getEncString(c.getTheID().toString()));
        	}
        }
        request.setAttribute("content187List", content187List);

        //政策发布@catalogID=80
        logger.info(">>>>>>>>>>IndexAction:index:政策发布>>>>>>>>>>");
        Contents contents80 = new Contents();
        value = PropertiesUtils.readValue(propertiesPath, "zcfbCatalogID");
        contents80.setCatalogID(Integer.valueOf(value));
        contents80.setStatus("1");
        contents80.setTopNum("8");
        List<Contents> contents80List = frontContentsServices.queryTopContentsList(contents80);
        if(contents80List.size() > 0){
            for(Contents c : contents80List){
                c.setDesId(des.getEncString(c.getTheID().toString()));
            }
        }
        request.setAttribute("contents80List", contents80List);

        //投资指南
//        logger.info(">>>>>>>>>>IndexAction:index:投资指南>>>>>>>>>>");
//        Contents contents65 = new Contents();
//        value = PropertiesUtils.readValue(propertiesPath, "tzznCatalogPID");
////		contents65.setCatalogID(65);
//        contents65.setCatalogID(Integer.valueOf(value));
//        contents65.setStatus("1");
//        contents65.setTopNum("6");
////		List<Contents> contents65List = frontContentsServices.queryTopContentsList(contents65);
//        List<Contents> contents65List = frontContentsServices.queryContentsByCataPid(contents65);
//        logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>投资指南：" + contents65List.size());
//        if(contents65List != null && contents65List.size() > 0){
//        	for(Contents c : contents65List){
//        		c.setDesId(des.getEncString(c.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("contents65List", contents65List);
//
//        //旅游天地
//        logger.info(">>>>>>>>>>IndexAction:index:旅游天地>>>>>>>>>>");
//        value = PropertiesUtils.readValue(propertiesPath, "lvtdCatalogPID");
////		contents65.setCatalogID(51);
//        contents65 = new Contents();
//        contents65.setCatalogPid(value);
//        contents65.setStatus("1");
//        contents65.setTopNum("6");
////		List<Contents> contents51List = frontContentsServices.queryTopContentsList(contents65);
//        List<Contents> contents51List = frontContentsServices.queryContentsByCataPid(contents65);
//        if(contents51List != null && contents51List.size() > 0){
//        	for(Contents c : contents51List){
//        		c.setDesId(des.getEncString(c.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("contents51List", contents51List);
//        //经济文化
//        logger.info(">>>>>>>>>>IndexAction:index:旅游天地>>>>>>>>>>");
//        value = PropertiesUtils.readValue(propertiesPath, "jjwhCatalogPID");
////		contents65.setCatalogID(51);
//        Contents contents7 = new Contents();
//        contents7.setCatalogID(Integer.valueOf(value));
////		List<Contents> contents51List = frontContentsServices.queryTopContentsList(contents65);
//        List<Contents> contents7List = frontContentsServices.queryContentsListByBean(contents7);
//        request.setAttribute("contents7List", contents7List);

        //今日关注
        logger.info(">>>>>>>>>>IndexAction:index:今日关注>>>>>>>>>>");
        ids = new Integer[]{10, 43};
        option = new Option();
        option.setItem("focusNewsNums");
        option = optionServices.queryOptionByBean(option);
        if(option != null && option.getCode() != null && Integer.valueOf(option.getCode())>0){
            Contents jrgzTemp = new Contents();
            jrgzTemp.setIds(ids);
            jrgzTemp.setIsFocus("1");
        	List<Contents> focusList = frontContentsServices.queryContentsByIds(jrgzTemp);
        	if(focusList != null && focusList.size() > 0){
            	for(Contents c : focusList){
            		c.setDesId(des.getEncString(c.getTheID().toString()));
            	}
            }
        	request.setAttribute("focusList", focusList);
        }
        

//        //市民服务
//        logger.info(">>>>>>>>>>IndexAction:index:市民服务>>>>>>>>>>");
//        Catalog catalog1 = new Catalog();
//        value = PropertiesUtils.readValue(propertiesPath, "smfwCatalogPID");
//        catalog1.setParentID(value);
//        catalog1.setStatus("1");
//        List<Catalog> catalog98List = frontCatalogServices.queryCatalogListByBean(catalog1);
//        request.setAttribute("catalog98List", catalog98List);
//
//        //企业服务
//        logger.info(">>>>>>>>>>IndexAction:index:企业服务>>>>>>>>>>");
//        Catalog catalog2 = new Catalog();
//        value = PropertiesUtils.readValue(propertiesPath, "qyfwCatalogPID");
//        catalog2.setParentID(value);
//        catalog2.setStatus("1");
//        List<Catalog> catalog99List = frontCatalogServices.queryCatalogListByBean(catalog2);
//        request.setAttribute("catalog99List", catalog99List);

        //政府信息
//        logger.info(">>>>>>>>>>IndexAction:index:政府信息>>>>>>>>>>");
//        Contents contents130 = new Contents();
//        value = PropertiesUtils.readValue(propertiesPath, "zfxxCatalogID");
//        contents130.setCatalogID(Integer.valueOf(value));
//        contents130.setStatus("1");
//        contents130.setTopNum("14");
//        List<Contents> contents130List = frontContentsServices.queryTopContentsList(contents130);
//        request.setAttribute("contents130List", contents130List);
        
        //重点领域信息公开专栏
        //logger.info(">>>>>>>>>>IndexAction:index:重点领域信息公开专栏>>>>>>>>>>");
        //OpenCatalog openCatalog = new OpenCatalog();
        //value = PropertiesUtils.readValue(propertiesPath, "zdlyxxkgzlCatalogPID");
        //openCatalog.setParentID(value);
        //openCatalog.setStatus("1");
        //openCatalog.setTopNum("10");
        //List<OpenCatalog> openTop8 = frontOpenCatalogServices.queryTopOpenCatalogList(openCatalog);
        //request.setAttribute("openTop8", openTop8);

        //最新来信
//        Letter letter = new Letter();
//        letter.setFlag("1");
//        letter.setIsOpen("1");
//        List<Letter> letterList = frontLetterServices.frontLetterDetail(letter);
//        request.setAttribute("letterList", letterList);
//
//        //最新建言
//        Letter advise = new Letter();
//        advise.setFlag("2");
//        advise.setIsOpen("1");
//        List<Letter> adviseList = frontLetterServices.frontLetterDetail(advise);
//        request.setAttribute("adviseList", adviseList);

        //办事指南
//        logger.info(">>>>>>>>>>IndexAction:index:办事指南>>>>>>>>>>");
//        value = PropertiesUtils.readValue(propertiesPath, "bsznCatalogPID");
//        Contents contents169 = new Contents();
//        contents169.setCatalogID(Integer.valueOf(value));
//        List<Contents> contents169List = frontContentsServices.queryContentsListByBean(contents169);
//        if(contents169List != null && contents169List.size() > 0){
//        	for(Contents c : contents169List){
//        		c.setDesId(des.getEncString(c.getTheID().toString()));
//        	}
//        }
//        request.setAttribute("contents169List", contents169List);

        return "index";
    }

    /**
     * 全文搜索（文章、视频）
     *
     * @return
     */
    public String searchList() {
        String title = request.getParameter("title");
        SearchVO s = new SearchVO();
        s.setTitle(title);
        List<SearchVO> resultList = frontSearchServices.querySearchVOByBean(s);
        request.setAttribute("resultList", resultList);
        request.setAttribute("title", title);
        return "searchList";
    }

    public String searchShow() {
        String id = request.getParameter("id");
        String tableName = request.getParameter("tableName");
        if (tableName != null && id != null) {
            if (tableName.equals("t_video")) {//视频
                Video video = new Video();
                video.setTheID(Integer.valueOf(id));
                video = frontVideoServices.queryVideoByBean(video);
                request.setAttribute("video", video);
                request.setAttribute("videoUrl", video.getUrl());
                return "searchVideoShow";
            } else if (tableName.equals("t_contents")) {//普通文章
                Contents contents = new Contents();
                contents.setTheID(Integer.valueOf(id));
                contents = frontContentsServices.queryContentsByBean(contents);
                request.setAttribute("contents", contents);
                //查找图片
                FileInfo fileInfo = new FileInfo();
                fileInfo.setContentID(contents.getTheID());
                fileInfo.setIsshow("1");
                fileInfo.setFileType("1");
                List<FileInfo> picList = frontFileInfoServices.front_fileInfoList(fileInfo);
                request.setAttribute("picList", picList);

                //查找附件
                fileInfo = new FileInfo();
                fileInfo.setContentID(contents.getTheID());
                fileInfo.setFileType("2");
                fileInfo.setIsshow("1");
                List<FileInfo> fileList = frontFileInfoServices.front_fileInfoList(fileInfo);
                request.setAttribute("fileList", fileList);

                request.setAttribute("tableName", tableName);
            } else if (tableName.equals("zl_contents")) {//重点领域
                ZlContents contents = frontZlContentsServices.queryZlContentsByBean(Integer.valueOf(id));
                request.setAttribute("contents", contents);

                request.setAttribute("tableName", tableName);
            } else if (tableName.equals("open_contents")) {//政务公开
                OpenContents contents = frontOpenContentsServices.frontOpenContentsDetail(Integer.valueOf(id));
                request.setAttribute("contents", contents);

                request.setAttribute("tableName", tableName);
            }
        }
        return "searchContentsShow";
    }

    /**
     * 便民服务列表
     *
     * @return
     */
    public String servicesList() {
        Links links = new Links();
        links.setLinkKind("2");
        links.setStatus("1");
        List<Links> servicesList = frontLinksServices.queryLinksListByBean(links);
        request.setAttribute("servicesList", servicesList);
        return "servicesList";
    }

    /**
     * 同个titlepic的id查到对应的url
     */
    public void queryUrlById() {
        PrintWriter pw = null;
        String theID = request.getParameter("id");
        String result = "";
        try {
            this.getResponse().setCharacterEncoding("UTF-8");
            pw = this.getResponse().getWriter();
            if (theID != null && !"".equals(theID)) {
                Titlepic titlepic = new Titlepic();
                titlepic.setTheID(Integer.valueOf(theID));
                titlepic = frontTitlepicServices.queryTitlepicByBean(titlepic);
                if (titlepic.getLinkUrl() != null) {
                    result = titlepic.getLinkUrl();
                }
            }
            pw.write(result);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public FrontCatalogServices getFrontCatalogServices() {
        return frontCatalogServices;
    }

    public void setFrontCatalogServices(FrontCatalogServices frontCatalogServices) {
        this.frontCatalogServices = frontCatalogServices;
    }

    public FrontLinksServices getFrontLinksServices() {
        return frontLinksServices;
    }

    public void setFrontLinksServices(FrontLinksServices frontLinksServices) {
        this.frontLinksServices = frontLinksServices;
    }

    public FrontContentsServices getFrontContentsServices() {
        return frontContentsServices;
    }

    public void setFrontContentsServices(FrontContentsServices frontContentsServices) {
        this.frontContentsServices = frontContentsServices;
    }

    public FrontVideoServices getFrontVideoServices() {
        return frontVideoServices;
    }

    public void setFrontVideoServices(FrontVideoServices frontVideoServices) {
        this.frontVideoServices = frontVideoServices;
    }

    public FrontFileInfoServices getFrontFileInfoServices() {
        return frontFileInfoServices;
    }

    public void setFrontFileInfoServices(FrontFileInfoServices frontFileInfoServices) {
        this.frontFileInfoServices = frontFileInfoServices;
    }

    public FrontSearchServices getFrontSearchServices() {
        return frontSearchServices;
    }

    public void setFrontSearchServices(FrontSearchServices frontSearchServices) {
        this.frontSearchServices = frontSearchServices;
    }

    public OptionServices getOptionServices() {
        return optionServices;
    }

    public void setOptionServices(OptionServices optionServices) {
        this.optionServices = optionServices;
    }

    public FrontTitlepicServices getFrontTitlepicServices() {
        return frontTitlepicServices;
    }

    public void setFrontTitlepicServices(FrontTitlepicServices frontTitlepicServices) {
        this.frontTitlepicServices = frontTitlepicServices;
    }

}
