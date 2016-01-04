package com.system.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.system.bean.AllClassBean;
import com.system.mappers.AccrualMapper;
import com.system.pojo.Accrual;

/**
 * @author hchch
 * 2015年6月17日
 */
@Service("accrualServices")
public class AccrualServicesImpl implements AccrualServices{
	
	private AccrualMapper accrualMapper;
	
	public AccrualMapper getAccrualMapper() {
		return accrualMapper;
	}

	public void setAccrualMapper(AccrualMapper accrualMapper) {
		this.accrualMapper = accrualMapper;
	}

	@Override
	public Accrual queryOneAccrualById(Integer theID) {
		return accrualMapper.queryOneAccrualById(theID);
	}

	@Override
	public List<Accrual> queryAccrualListByBean(Accrual accrual) {
		return accrualMapper.queryAccrualListByBean(accrual);
	}

	@Override
	public void insertAccrual(Accrual accrual) {
		accrualMapper.insertAccrual(accrual);
	}

	@Override
	public void updateAccrual(Accrual accrual) {
		accrualMapper.updateAccrual(accrual);
	}

	@Override
	public void deleteAccrual(Accrual accrual) {
		accrualMapper.deleteAccrual(accrual);
	}

	@Override
	public List<AllClassBean> getAccrualListByBean(AllClassBean bean) {
		return accrualMapper.getAccrualListByBean(bean);
	}

	@Override
	public Integer countAccrualByBean(Accrual accrual) {
		return accrualMapper.countAccrualByBean(accrual);
	}

	@Override
	public void batchDeleteAccrual(String ids) {
		accrualMapper.batchDeleteAccrual(ids);
	}

	@Override
	public List<Accrual> getAccrualListByPid(Integer pid) {
		return accrualMapper.getAccrualListByPid(pid);
	}

}
