package ${packageName};

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import com.domes.generatortools.model.ResponseResult;
import com.domes.generatortools.exception.BusinessException
import com.domes.generatortools.vo.ListResultVO;
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
     * @param id
     * @return
     * @throws BusinessException
     */
    @GetMapping(value = "/${classMapping}/{id}")
    ResponseResult<${voClassName}> get(@PathVariable(value = "id") Long id) throws BusinessException;

    /**
     * 更新
     *
     * @param id
     * @param param
     * @return
     * @throws BusinessException
     */
    @PutMapping(value = "/${classMapping}/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    ResponseResult<String> update(@PathVariable(value = "id") Long id, @RequestBody ${dtoClassName} param) throws BusinessException;

    /**
     * 删除
     *
     * @param id
     * @return
     * @throws BusinessException
     */
    @DeleteMapping(value = "/${classMapping}/{id}")
    ResponseResult<String> delete(@PathVariable(value = "id") Long id) throws BusinessException;
}