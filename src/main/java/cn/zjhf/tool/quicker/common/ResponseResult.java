package cn.zjhf.tool.quicker.common;

/**
 * Created by lutiehua on 2017/9/22.
 */
public class ResponseResult {

    public final static int OK = 200;

    public final static int EXCEPTION = 500;

    private int code;

    private String message;

    private Object data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
