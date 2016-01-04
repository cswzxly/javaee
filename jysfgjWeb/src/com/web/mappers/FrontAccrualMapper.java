package com.web.mappers;

import java.util.List;

import com.system.bean.AllClassBean;
import com.system.pojo.Accrual;

public interface FrontAccrualMapper {
	public Accrual queryOneAccrualById(Integer theID);
    
    public List<Accrual> queryAccrualListByBean(Accrual accrual);

    public void insertAccrual(Accrual accrual);

    public void updateAccrual(Accrual accrual);

    public void deleteAccrual(Accrual accrual);
    
    public List<AllClassBean> getAccrualListByBean(AllClassBean bean);  
    
    public Integer countAccrualByBean(Accrual accrual);
    
    public void batchDeleteAccrual(String ids);

	public List<Accrual> getAccrualListByPid(Integer pid);
}
