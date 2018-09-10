package ${packageName};

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import com.alibaba.fastjson.JSON;
import com.rent.exception.BusinessException;
import com.rent.validation.InsertGroup;
import com.rent.validation.UpdateGroup;
import com.rent.model.ResponseResult;
import com.rent.model.ListResponseResult;
import com.rent.util.UuidUtil;
import com.rent.vo.ListResultVO;
import com.rent.vo.LeaseResult;
import java.util.List;
import com.rent.common.util.Page;

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
@RequestMapping(value = "/${classMapping}")
public class ${className} {

    private final Logger logger = LoggerFactory.getLogger(${className}.class);

    @Autowired
    private ${serviceClassName} ${serviceObjectName};

    /**
     * 创建
     *
     * @return
     * @throws BusinessException
     */
    @PostMapping(value = "/add")
    @ApiOperation(value = "创建${classRemark}接口", response = ${voClassName}.class)
    public LeaseResult<${voClassName}> create(@RequestBody @ApiParam @Validated({InsertGroup.class}) ${dtoClassName} param) throws BusinessException {
        // ${dtoClassName} 用来接收请求参数
        String jsonString = JSON.toJSONString(param);

        // 转换为${modelClassName}传给业务层处理
        ${modelClassName} ${modelObjectName} = JSON.parseObject(jsonString, ${modelClassName}.class);

        // 持久化到数据库
        int row = ${serviceObjectName}.save(${modelObjectName});
        LeaseResult responseResult = new LeaseResult();
        responseResult.setData(row);
        return responseResult;

    }


    /**
     * 分页查询
     *
     * @return
     * @throws BusinessException
     */
    @GetMapping("/pageList")
    @ApiOperation(value = "查询${classRemark}接口", response = ${voClassName}.class, notes = "list")
    public LeaseResult<Page<${voClassName}>> pagelist(@ApiParam @Validated ${pageQueryDtoClassName} queryParam) throws BusinessException {

        String jsonString = JSON.toJSONString(queryParam);
        ${queryDtoClassName} ${queryDtoObjectName} = JSON.parseObject(jsonString, ${queryDtoClassName}.class);

        int pageSize =0;
        if(queryParam.getPageSize() == null){
            pageSize = 20;
        }else{
            pageSize = queryParam.getPageSize();
        }
        int currentPageNo = queryParam.getCurrentPageNo() > 1 ? queryParam.getCurrentPageNo(): 1;

        ${queryDtoObjectName}.setStartRow((currentPageNo-1)*pageSize);

        // 由于需要处理PageInfo，所以直接在Service中处理返回结果
        List dataList = ${serviceObjectName}.list(${queryDtoObjectName});
        int totalRecord = ${serviceObjectName}.count(${queryDtoObjectName});

        Page<${voClassName}> page = new Page();
        page.setPageSize(${queryDtoObjectName}.getPageSize());
        page.setTotalRecord(totalRecord);
        page.setResult(dataList);

        //计算总页数等间接指标
        page.calculate();
        LeaseResult lResult = new LeaseResult();
        lResult.setData(page);
        return lResult;

    }


    /**
     * 查询
     *
     * @return
     * @throws BusinessException
     */
    @GetMapping("/list")
    @ApiOperation(value = "查询${classRemark}接口", response = ${voClassName}.class, notes = "list")
    public LeaseResult list(@ApiParam @Validated ${queryDtoClassName} queryParam) throws BusinessException {
        if(queryParam == null){
            queryParam = new ${queryDtoClassName}();
        }
        if(queryParam.getPageSize() == null){
            queryParam.setPageSize(20);
        }
        // 由于需要处理PageInfo，所以直接在Service中处理返回结果
        List dataList = ${serviceObjectName}.list(queryParam);

        LeaseResult lResult = new LeaseResult();
        lResult.setData(dataList);
        return lResult;
    }

    /**
     * 查询总数
     *
     * @return
     * @throws BusinessException
     */
    @GetMapping("/count")
    @ApiOperation(value = "查询${classRemark}接口数量", response = Integer.class)
    public LeaseResult count(@ApiParam @Validated ${queryDtoClassName} queryParam) throws BusinessException {
        if(queryParam == null){
            queryParam = new ${queryDtoClassName}();
        }

        int dataCount = ${serviceObjectName}.count(queryParam);

        LeaseResult lResult = new LeaseResult();
        lResult.setData(dataCount);
        return lResult;
    }


    /**
     * 详情
     *
     * @return
     * @throws BusinessException
     */
    @GetMapping(value = "/get")
    @ApiOperation(value = "获取${classRemark}详情接口", response = ${voClassName}.class)
    public LeaseResult<${voClassName}> get(@RequestParam Integer id) throws BusinessException {
        // Service层返回的是与数据库表对应的实体类对象
        ${modelClassName} ${modelObjectName} = ${serviceObjectName}.get(id);

        // 转换为返回值对象
        String jsonString = JSON.toJSONString(${modelObjectName});
        ${voClassName} ${voObjectName} = JSON.parseObject(jsonString, ${voClassName}.class);

        // 返回数据
        LeaseResult responseResult = new LeaseResult();
        responseResult.setData(${voObjectName});
        return responseResult;
    }

    /**
     * 更新
     *
     * @return
     * @throws BusinessException
     */
    @PostMapping(value = "/update")
    @ApiOperation(value = "更新${classRemark}接口")
    public LeaseResult update(@RequestParam Integer id, @RequestBody @ApiParam @Validated({UpdateGroup.class}) ${dtoClassName} param) throws BusinessException {
        // ${dtoClassName} 用来接收请求参数
        String jsonString = JSON.toJSONString(param);
        ${modelClassName} ${modelObjectName} = JSON.parseObject(jsonString, ${modelClassName}.class);
        ${modelObjectName}.set${keyFieldName}(id);

        // 转换为${modelClassName}传给业务层处理
        // 此处根据实际情况判断row=0是否需要抛出异常
        int row = ${serviceObjectName}.update(${modelObjectName});

        // 返回影响的行数，正常情况为1

        LeaseResult responseResult = new LeaseResult();
        responseResult.setData(row);
        return responseResult;
    }

    /**
     * 删除
     *
     * @param id
     * @return
     * @throws BusinessException
     */
    @PostMapping(value = "/delete")
    @ApiOperation(value = "删除${classRemark}接口")
    public LeaseResult delete(@RequestParam Integer id) throws BusinessException {
        // 此处根据实际情况判断row=0是否需要抛出异常
        int row = ${serviceObjectName}.delete(id);

        // 返回影响的行数，正常情况为1
        LeaseResult responseResult = new LeaseResult();
        responseResult.setData(row);
        return responseResult;
    }
}