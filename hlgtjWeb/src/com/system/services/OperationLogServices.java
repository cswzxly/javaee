package com.system.services;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.system.pojo.OperationLog;

@Transactional
public interface OperationLogServices {


	public List<OperationLog> queryOperationLogByBean(OperationLog operationLog);

    public Integer countOperationLogByBean(OperationLog operationLog);

    public void insertOperationLog(OperationLog operationLog);

    public void updateOperationLog(OperationLog operationLog);

    public void deleteOperationLog(OperationLog operationLog);

    public OperationLog queryOperationLogById(Integer theID);

}
