package com.web.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.pojo.Accrual;
import com.web.mappers.FrontAccrualMapper;

/**
 * @author hchch
 * 2015年6月17日
 */
@Service("frontAccrualServices")
public class FrontAccrualServicesImpl implements FrontAccrualServices{
	
	private FrontAccrualMapper frontAccrualMapper;
	
	public FrontAccrualMapper getFrontAccrualMapper() {
		return frontAccrualMapper;
	}

	public void setFrontAccrualMapper(FrontAccrualMapper frontAccrualMapper) {
		this.frontAccrualMapper = frontAccrualMapper;
	}

	@Override
	public Accrual queryOneAccrualById(Integer theID) {
		return frontAccrualMapper.queryOneAccrualById(theID);
	}

	@Override
	public List<Accrual> queryAccrualListByBean(Accrual accrual) {
		return frontAccrualMapper.queryAccrualListByBean(accrual);
	}

	@Override
	public void insertAccrual(Accrual accrual) {
		frontAccrualMapper.insertAccrual(accrual);
	}

	@Override
	public void updateAccrual(Accrual accrual) {
		frontAccrualMapper.updateAccrual(accrual);
	}

	@Override
	public void deleteAccrual(Accrual accrual) {
		frontAccrualMapper.deleteAccrual(accrual);
	}

	@Override
	public List<AllClassBean> getAccrualListByBean(AllClassBean bean) {
		return frontAccrualMapper.getAccrualListByBean(bean);
	}

	@Override
	public Integer countAccrualByBean(Accrual accrual) {
		return frontAccrualMapper.countAccrualByBean(accrual);
	}

	@Override
	public void batchDeleteAccrual(String ids) {
		frontAccrualMapper.batchDeleteAccrual(ids);
	}

	@Override
	public List<Accrual> getAccrualListByPid(Integer pid) {
		return frontAccrualMapper.getAccrualListByPid(pid);
	}

}
