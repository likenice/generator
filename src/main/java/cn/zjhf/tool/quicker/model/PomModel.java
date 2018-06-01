package cn.zjhf.tool.quicker.model;

import cn.zjhf.tool.quicker.common.ProjectType;
import cn.zjhf.tool.quicker.dto.DependecyInfo;
import cn.zjhf.tool.quicker.dto.ProjectInfo;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

/**
 * Created by lutiehua on 2017/11/10.
 */
@Getter
@Setter
@NoArgsConstructor
public class PomModel extends DataModel {

//    private String groupId;
//
//    private String artifactId;
//
//    private String version;
//
//    private String name;
//
//    private String description;
//
//    private String springBootVersion;
//
//    private String javaVersion;

    private ProjectInfo projectInfo;

    private List<DependecyInfo> dependencies;

    /**
     * 项目类型
     */
    private String projectType = ProjectType.PROJECT_TYPE_BOOT;

}
