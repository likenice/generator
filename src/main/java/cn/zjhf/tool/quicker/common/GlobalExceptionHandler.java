package cn.zjhf.tool.quicker.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by lutiehua on 2017/9/22.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    protected final Logger logger = LoggerFactory.getLogger(this.getClass());

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseResult handleBusinessException(Exception e) {
        ResponseResult responseResult = new ResponseResult();
        int errorCode = ResponseResult.EXCEPTION;
        String errorMessage = e.getMessage();
        responseResult.setCode(errorCode);
        responseResult.setMessage(errorMessage);
        responseResult.setData(null);
        logger.error("Exception: code=[{}] msg=[{}]", errorCode, errorMessage);
        return responseResult;
    }
}