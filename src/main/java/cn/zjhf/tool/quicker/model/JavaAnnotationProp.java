package cn.zjhf.tool.quicker.model;

import lombok.Getter;
import lombok.Setter;

/**
 * Created by lutiehua on 2017/9/27.
 */
@Getter
@Setter
public class JavaAnnotationProp {

    /**
     * 数值
     */
    public static final int NUMBER = 1;

    /**
     * 字符串
     */
    public static final int STRING = 2;

    /**
     * 布尔
     */
    public static final int BOOLEAN = 3;

    /**
     * 对象
     */
    public static final int OBJECT = 4;

    /**
     * 注解类型
     */
    private Integer type;

    /**
     * 注解名称
     */
    private String key;

    /**
     * 注解的值
     */
    private String value;

}
