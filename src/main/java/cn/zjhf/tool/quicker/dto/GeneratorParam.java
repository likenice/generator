package cn.zjhf.tool.quicker.dto;

import lombok.*;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 生成参数
 *
 * Created by lutiehua on 2017/11/9.
 */
@Data
public class GeneratorParam {

    /**
     * 工程相关信息
     */
    @NotNull
    private ProjectInfo projectInfo;

    /**
     * 数据库相关信息
     */
    @NotNull
    private DatabaseInfo databaseInfo;

    /**
     * 程序包相关信息
     */
    @NotNull
    private PackageInfo packageInfo;

    /**
     * 项目依赖信息
     */
    private List<DependecyInfo> dependencies;

    /**
     * 数据库表信息
     */
    @NotNull
    private List<TableInfo> tables;

}
