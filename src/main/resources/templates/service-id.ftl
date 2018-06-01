package ${packageName};

import cn.zjhf.kingold.cloud.common.exception.BusinessException;
import cn.zjhf.kingold.cloud.common.web.ListResponseResult;
import java.util.List;

<#list imports as import>
import ${import.name};
</#list>

/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
public interface ${className} {

    /**
     * 持久化到数据库
     *
     * @param ${modelObjectName}
     * @return
     * @throws BusinessException
     */
    int save(${modelClassName} ${modelObjectName}) throws BusinessException;

    /**
     * 批量持久化到数据库
     *
     * @param ${modelObjectName}List
     * @return
     * @throws BusinessException
     */
    int save(List<${modelClassName}> ${modelObjectName}List) throws BusinessException;

    /**
     * 更新数据库（根据主键更新）
     *
     * @param ${modelObjectName}
     * @return
     * @throws BusinessException
     */
    int update(${modelClassName} ${modelObjectName}) throws BusinessException;

    /**
     * 通过主鍵查找
     *
     * @param id
     * @return
     */
    ${modelClassName} get(Long id);

    /**
     * 通过主鍵进行逻辑刪除
     *
     * @param id
     * @return
     */
    int delete(Long id);

    /**
     * 根据相等条件进行查询
     *
     * @param queryParam 查询参数
     * @return
     */
    ListResponseResult<${voClassName}> query(${queryDtoClassName} queryParam);
}