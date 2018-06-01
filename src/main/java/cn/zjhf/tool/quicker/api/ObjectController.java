package cn.zjhf.tool.quicker.api;

import cn.zjhf.tool.quicker.common.ResponseResult;
import cn.zjhf.tool.quicker.core.MybatisGenerator;
import cn.zjhf.tool.quicker.core.SpringBootProjectGenerator;
import cn.zjhf.tool.quicker.core.SpringMVCGenerator;
import cn.zjhf.tool.quicker.dto.GeneratorParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * @author lutiehua
 * @date 2017/9/22.
 */
@RestController
@RequestMapping("/api/object")
public class ObjectController extends BaseController {

    @Autowired
    private MybatisGenerator mybatisGenerator;

    @Autowired
    private SpringBootProjectGenerator projectGenerator;

    @Autowired
    private SpringMVCGenerator springMVCGenerator;

    @PostMapping(value = "")
    public ResponseResult generate(@RequestBody Map<String, Object> param) throws Exception {
        GeneratorParam generatorParam = super.getParamObject(param, GeneratorParam.class);

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
}