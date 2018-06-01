package cn.zjhf.tool.quicker.dto;

import lombok.Data;

/**
 * 排序信息
 *
 * @author lutiehua
 * @date 2017/11/24
 */
@Data
public class OrderByInfo {

    /**
     * 排序字段
     */
    private String field;

    /**
     * 排序方式
     */
    private String sort;
}
