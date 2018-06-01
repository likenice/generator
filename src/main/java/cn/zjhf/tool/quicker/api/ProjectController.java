package cn.zjhf.tool.quicker.api;

import cn.zjhf.tool.quicker.common.ProjectType;
import cn.zjhf.tool.quicker.common.ResponseResult;
import cn.zjhf.tool.quicker.core.*;
import cn.zjhf.tool.quicker.dto.GeneratorParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.*;

/**
 * Created by lutiehua on 2017/9/22.
 */
@RestController
@RequestMapping("/api/project")
public class ProjectController extends BaseController {

    @Autowired
    private MybatisGenerator mybatisGenerator;

    @Autowired
    private MybatisXYGenerator mybatisXYGenerator;


    @Autowired
    private SpringMVCXYProjectGenerator xyProjectGenerator;


    @Autowired
    private SpringBootProjectGenerator bootProjectGenerator;

    @Autowired
    private SpringCloudProjectGenerator cloudProjectGenerator;

    @Autowired
    private SpringMVCGenerator springMVCGenerator;

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseResult generate(@RequestBody Map<String, Object> param) throws Exception {

        GeneratorParam generatorParam = super.getParamObject(param, GeneratorParam.class);

        if (generatorParam.getTables().size() == 0) {
            ResponseResult responseResult = new ResponseResult();
            responseResult.setCode(ResponseResult.EXCEPTION);
            responseResult.setMessage("待生成列表不能为空，请添加数据库表到待生成列表!");
            return responseResult;
        }

        String projectType = generatorParam.getProjectInfo().getProjectType();
        if (ProjectType.PROJECT_TYPE_BOOT.equalsIgnoreCase(projectType)) {
            return generateSpringBootProject(generatorParam);
        }if (ProjectType.PROJECT_TYPE_MVC.equalsIgnoreCase(projectType)) {
            return generateSpringMVCProject(generatorParam);
        } else if (ProjectType.PROJECT_TYPE_CLOUD.equalsIgnoreCase(projectType)) {
            return generateSpringCloudProject(generatorParam);
        } else {
            ResponseResult responseResult = new ResponseResult();
            responseResult.setCode(ResponseResult.EXCEPTION);
            String message = String.format("unknown projectType=%s", projectType);
            responseResult.setData(message);
            return responseResult;
        }
    }

    protected ResponseResult generateSpringMVCProject(GeneratorParam generatorParam) throws Exception {
        // 生成项目文件
        xyProjectGenerator.generateCode(generatorParam);

        // 生成CRUD
        mybatisXYGenerator.generateCode(generatorParam);

        // 生成Controller/Service/Model
        springMVCGenerator.generateCode(generatorParam);

        String message = String.format("成功生成项目到\"%s\"目录下。", generatorParam.getPackageInfo().getProjectPath());
        ResponseResult responseResult = new ResponseResult();
        responseResult.setCode(ResponseResult.OK);
        responseResult.setData(message);
        return responseResult;
    }

    protected ResponseResult generateSpringBootProject(GeneratorParam generatorParam) throws Exception {
        // 生成项目文件
        bootProjectGenerator.generateCode(generatorParam);

        // 生成CRUD
        mybatisGenerator.generateCode(generatorParam);

        // 生成Controller/Service/Model
        springMVCGenerator.generateCode(generatorParam);

        String message = String.format("成功生成项目到\"%s\"目录下。", generatorParam.getPackageInfo().getProjectPath());
        ResponseResult responseResult = new ResponseResult();
        responseResult.setCode(ResponseResult.OK);
        responseResult.setData(message);
        return responseResult;
    }


    protected ResponseResult generateSpringCloudProject(GeneratorParam generatorParam) throws Exception {
        // 生成项目文件
        cloudProjectGenerator.generateCode(generatorParam);

        String message = String.format("成功生成项目到\"%s\"目录下。", generatorParam.getPackageInfo().getProjectPath());
        ResponseResult responseResult = new ResponseResult();
        responseResult.setCode(ResponseResult.OK);
        responseResult.setData(message);
        return responseResult;
    }
}