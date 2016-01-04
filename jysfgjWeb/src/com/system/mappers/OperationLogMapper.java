package com.system.mappers;

import com.system.pojo.OperationLog;

import java.util.List;

public interface OperationLogMapper {

    public List<OperationLog> queryOperationLogByBean(OperationLog operationLog);

    public void insertOperationLog(OperationLog operationLog);

    public void updateOperationLog(OperationLog operationLog);

    public void deleteOperationLog(OperationLog operationLog);

    public Integer countOperationLogByBean(OperationLog operationLog);
    
    public OperationLog queryOperationLogById(Integer theID);
}
