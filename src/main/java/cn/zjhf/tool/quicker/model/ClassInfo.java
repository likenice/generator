package cn.zjhf.tool.quicker.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * 类信息
 *
 * @author lutiehua
 * @date 2017/9/27
 */
@Getter
@Setter
@NoArgsConstructor
public class ClassInfo {

    /**
     * 项目名称
     */
    private String projectName;

    /**
     * 基础类名（可添加后缀）
     */
    private String className;

    /**
     * 类注释
     */
    private String classRemark;

    /**
     * 作者
     */
    private String classAuthor;

    /**
     * 日期
     */
    private String classDate;
}