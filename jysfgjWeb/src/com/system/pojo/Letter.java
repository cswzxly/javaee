package com.system.pojo;

public class Letter {

	private Integer theID; //主键
	private String visitePath;  //来访路径
	private String acceptNum;  //受理编号
	private String name; //姓名
	private String sex; //性别     1-男|0-女
	private String age; //年龄
	private String politicalType; //政治面貌    1-群众|2-团员|3-党员|4-其它
	private String certType; //证件类型    1-身份证|2-学生证|3-驾驶证
	private String certNum; //证件号码
	private String occupType; //职业      1-公务员|2-学生|3-教师|4-农民|5-工人|6-个体经营
	private String workplace; //工作单位
	private String phone; //联系电话
	private String moblePhone; //手机
	private String email; //电子邮箱
	private String address; //联系方式或地址
	private String postcode; //邮编
	private String theme; //主题
	private String questionType; //问题类型
	private String referDept;  //涉及单位
	private String joinNum; //联名人数
	private String detailAddress;  //问题发生详细地址
	private String content; //具体内容
	private String uploadFile; //文件上传
	private String everDo; //是否曾向信访局来信来访
	private String isOpen; //是否公开
	private String flag; //信箱类型标识   1-县长信箱|2我要写信|3-我要建议
	private String status; //回复状态   1-已回复|2-未回复
	private String replay; //回复内容
	private String createDate;//接收时间
	private String ipAddress;//ip地址
	private String count1Star;//满意度1的次数
	private String count2Star;//满意度2的次数
	private String count3Star;//满意度3的次数
	
	//非数据库字段
	private String flagName;
	private String desId;

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReplay() {
		return replay;
	}
	public void setReplay(String replay) {
		this.replay = replay;
	}
	public Integer getTheID() {
		return theID;
	}
	public void setTheID(Integer theID) {
		this.theID = theID;
	}
	public String getVisitePath() {
		return visitePath;
	}
	public void setVisitePath(String visitePath) {
		this.visitePath = visitePath;
	}
	public String getAcceptNum() {
		return acceptNum;
	}
	public void setAcceptNum(String acceptNum) {
		this.acceptNum = acceptNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getPoliticalType() {
		return politicalType;
	}
	public void setPoliticalType(String politicalType) {
		this.politicalType = politicalType;
	}
	public String getCertType() {
		return certType;
	}
	public void setCertType(String certType) {
		this.certType = certType;
	}
	public String getCertNum() {
		return certNum;
	}
	public void setCertNum(String certNum) {
		this.certNum = certNum;
	}
	public String getOccupType() {
		return occupType;
	}
	public void setOccupType(String occupType) {
		this.occupType = occupType;
	}
	public String getWorkplace() {
		return workplace;
	}
	public void setWorkplace(String workplace) {
		this.workplace = workplace;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMoblePhone() {
		return moblePhone;
	}
	public void setMoblePhone(String moblePhone) {
		this.moblePhone = moblePhone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getTheme() {
		return theme;
	}
	public void setTheme(String theme) {
		this.theme = theme;
	}
	public String getQuestionType() {
		return questionType;
	}
	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}
	public String getReferDept() {
		return referDept;
	}
	public void setReferDept(String referDept) {
		this.referDept = referDept;
	}
	public String getJoinNum() {
		return joinNum;
	}
	public void setJoinNum(String joinNum) {
		this.joinNum = joinNum;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(String uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getEverDo() {
		return everDo;
	}
	public void setEverDo(String everDo) {
		this.everDo = everDo;
	}
	public String getIsOpen() {
		return isOpen;
	}
	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getFlagName() {
		return flagName;
	}
	public void setFlagName(String flagName) {
		this.flagName = flagName;
	}
	public String getDesId() {
		return desId;
	}
	public void setDesId(String desId) {
		this.desId = desId;
	}
	public String getIpAddress() {
		return ipAddress;
	}
	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}
	public String getCount1Star() {
		return count1Star;
	}
	public void setCount1Star(String count1Star) {
		this.count1Star = count1Star;
	}
	public String getCount2Star() {
		return count2Star;
	}
	public void setCount2Star(String count2Star) {
		this.count2Star = count2Star;
	}
	public String getCount3Star() {
		return count3Star;
	}
	public void setCount3Star(String count3Star) {
		this.count3Star = count3Star;
	}
	
}
