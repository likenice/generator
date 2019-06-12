package ${packageName};

import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import com.alibaba.fastjson.JSON;
import com.domes.generatortools.exception.BusinessException
import com.domes.generatortools.exception.MybatisException;
import com.domes.generatortools.validation.InsertGroup;
import com.domes.generatortools.validation.ParamTool;
import com.domes.generatortools.validation.UpdateGroup;
import com.domes.generatortools.model.ResponseResult;
import com.domes.generatortools.web.SimpleResponseResult;
import com.domes.generatortools.model.ListResponseResult;
import com.domes.generatortools.util.UuidUtil;
import com.domes.generatortools.vo.ListResultVO;

<#list imports as import>
import ${import.name};
</#list>

/**
 * ${classRemark}接口
 *
 * @author ${author}
 * @date ${date}
 */
@RestController
public class ${className} implements ${facadeClassName} {

    private final Logger logger = LoggerFactory.getLogger(${className}.class);

    @Autowired
    private ${serviceClassName} ${serviceObjectName};

    /**
     * 创建
     *
     * @return
     * @throws BusinessException
     */
    @Override
    @ApiOperation(value = "创建${classRemark}接口", response = ${voClassName}.class)
    public ResponseResult<${voClassName}> create(@RequestBody @ApiParam @Validated({InsertGroup.class}) ${dtoClassName} param) throws BusinessException {
        // ${dtoClassName} 用来接收请求参数
        String jsonString = JSON.toJSONString(param);

        // 转换为${modelClassName}传给业务层处理
        ${modelClassName} ${modelObjectName} = JSON.parseObject(jsonString, ${modelClassName}.class);

        // 生成UUID
        String uuid = UuidUtil.getUuid();
        ${modelObjectName}.set${keyFieldName}(uuid);

        // 持久化到数据库
        int row = ${serviceObjectName}.save(${modelObjectName});
        if (row > 0) {
            ResponseResult responseResult = new ResponseResult();
            jsonString = JSON.toJSONString(${modelObjectName});
            ${voClassName} ${voObjectName} = JSON.parseObject(jsonString, ${voClassName}.class);
            responseResult.setData(${voObjectName});
            return responseResult;
        } else {
            throw new MybatisException();
        }
    }

    /**
     * 查询
     *
     * @return
     * @throws BusinessException
     */
    @Override
    @ApiOperation(value = "查询${classRemark}接口", response = ${voClassName}.class, notes = "list")
    public ResponseResult<ListResultVO<${voClassName}>> query(@RequestBody ${queryDtoClassName} queryParam) throws BusinessException {
        // 由于需要处理PageInfo，所以直接在Service中处理返回结果
        return ${serviceObjectName}.query(queryParam);
    }

    /**
     * 详情
     *
     * @return
     * @throws BusinessException
     */
    @Override
    @ApiOperation(value = "获取${classRemark}详情接口", response = ${voClassName}.class)
    public ResponseResult<${voClassName}> get(@PathVariable String uuid) throws BusinessException {
        // Service层返回的是与数据库表对应的实体类对象
        ${modelClassName} ${modelObjectName} = ${serviceObjectName}.get(uuid);

        // 转换为返回值对象
        String jsonString = JSON.toJSONString(${modelObjectName});
        ${voClassName} ${voObjectName} = JSON.parseObject(jsonString, ${voClassName}.class);

        // 返回数据
        ResponseResult responseResult = new ResponseResult();
        responseResult.setData(${voObjectName});
        return responseResult;
    }

    /**
     * 更新
     *
     * @return
     * @throws BusinessException
     */
    @Override
    @ApiOperation(value = "更新${classRemark}接口")
    public ResponseResult<String> update(@PathVariable String uuid, @RequestBody @ApiParam @Validated({UpdateGroup.class}) ${dtoClassName} param) throws BusinessException {
        // ${dtoClassName} 用来接收请求参数
        String jsonString = JSON.toJSONString(param);
        ${modelClassName} ${modelObjectName} = JSON.parseObject(jsonString, ${modelClassName}.class);
        ${modelObjectName}.set${keyFieldName}(uuid);

        // 转换为${modelClassName}传给业务层处理
        // 此处根据实际情况判断row=0是否需要抛出异常
        int row = ${serviceObjectName}.update(${modelObjectName});

        // 返回影响的行数，正常情况为1
        SimpleResponseResult responseResult = new SimpleResponseResult(Integer.toString(row));
        return responseResult;
    }

    /**
     * 删除
     *
     * @param uuid
     * @return
     * @throws BusinessException
     */
    @Override
    @ApiOperation(value = "删除${classRemark}接口")
    public ResponseResult<String> delete(@PathVariable String uuid) throws BusinessException {
        // 此处根据实际情况判断row=0是否需要抛出异常
        int row = ${serviceObjectName}.delete(uuid);

        // 返回影响的行数，正常情况为1
        SimpleResponseResult responseResult = new SimpleResponseResult(Integer.toString(row));
        return responseResult;
    }
}