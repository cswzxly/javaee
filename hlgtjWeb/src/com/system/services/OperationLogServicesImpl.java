package com.system.services;

import java.util.List;

import com.system.pojo.OperationLog;

import org.springframework.stereotype.Service;

import com.system.mappers.OperationLogMapper;

@Service("operationLogServices")
public class OperationLogServicesImpl implements OperationLogServices {

	private OperationLogMapper operationLogMapper;

	public OperationLogMapper getOperationLogMapper() {
		return operationLogMapper;
	}

	public void setOperationLogMapper(OperationLogMapper operationLogMapper) {
		this.operationLogMapper = operationLogMapper;
	}

	@Override
	public List<OperationLog> queryOperationLogByBean(OperationLog operationLog) {
		return operationLogMapper.queryOperationLogByBean(operationLog);
	}

	@Override
	public Integer countOperationLogByBean(OperationLog operationLog) {
		return operationLogMapper.countOperationLogByBean(operationLog);
	}

	@Override
	public void insertOperationLog(OperationLog operationLog) {
		operationLogMapper.insertOperationLog(operationLog);
	}

	@Override
	public void updateOperationLog(OperationLog operationLog) {
		operationLogMapper.updateOperationLog(operationLog);
	}

	@Override
	public void deleteOperationLog(OperationLog operationLog) {
		operationLogMapper.deleteOperationLog(operationLog);
	}

	@Override
	public OperationLog queryOperationLogById(Integer theID) {
		return operationLogMapper.queryOperationLogById(theID);
	}

}
