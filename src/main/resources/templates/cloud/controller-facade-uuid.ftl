package ${packageName};

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import com.rent.model.ResponseResult;
import com.rent.exception.BusinessException;
import com.rent.vo.ListResultVO;
import org.springframework.cloud.netflix.feign.FeignClient;

<#list imports as import>
import ${import.name};
</#list>

/**
 * ${classRemark}接口
 *
 * @author ${author}
 * @date ${date}
 */
@FeignClient(value = "${serviceName}", configuration = {FeignConfig.class}, fallback = ${fallbackClassName}.class)
public interface ${className} {

    /**
     * 创建
     *
     * @param param
     * @return
     * @throws BusinessException
     */
    @PostMapping(value = "/${classMapping}", consumes = MediaType.APPLICATION_JSON_VALUE)
    ResponseResult<${voClassName}> create(@RequestBody ${dtoClassName} param) throws BusinessException;

    /**
     * 查询
     *
     * @param queryParam 对应${queryDtoClassName}类
     * @return
     * @throws BusinessException
     */
    @GetMapping(value = "/${classMapping}/query", consumes = MediaType.APPLICATION_JSON_VALUE)
    ResponseResult<ListResultVO<${voClassName}>> query(@RequestBody ${queryDtoClassName} queryParam) throws BusinessException;

    /**
     * 详情
     *
     * @param uuid
     * @return
     * @throws BusinessException
     */
    @GetMapping(value = "/${classMapping}/{uuid}")
    ResponseResult<${voClassName}> get(@PathVariable(value = "uuid") String uuid) throws BusinessException;

    /**
     * 更新
     *
     * @param uuid
     * @param param
     * @return
     * @throws BusinessException
     */
    @PutMapping(value = "/${classMapping}/{uuid}", consumes = MediaType.APPLICATION_JSON_VALUE)
    ResponseResult<String> update(@PathVariable(value = "uuid") String uuid, @RequestBody ${dtoClassName} param) throws BusinessException;

    /**
     * 删除
     *
     * @param uuid
     * @return
     * @throws BusinessException
     */
    @DeleteMapping(value = "/${classMapping}/{uuid}")
    ResponseResult<String> delete(@PathVariable(value = "uuid") String uuid) throws BusinessException;
}