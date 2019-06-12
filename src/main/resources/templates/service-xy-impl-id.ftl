package ${packageName};

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.github.pagehelper.PageInfo;
import tk.mybatis.mapper.entity.Example;
import com.domes.generatortools.exception.BusinessException
import com.domes.generatortools.vo.ListResultVO;

<#list imports as import>
import ${import.name};
</#list>

/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
@Service
public class ${className} implements ${serviceClassName} {

    private final Logger logger = LoggerFactory.getLogger(${className}.class);

    @Autowired
    private ${mapperClassName} ${mapperObjectName};

    /**
     * 持久化到数据库
     *
     * @param ${modelObjectName}
     * @throws BusinessException
     */
    @Override
    public int save(${modelClassName} ${modelObjectName}) throws BusinessException {
        ${mapperObjectName}.insertSelective(${modelObjectName});
        return ${modelObjectName}.get${keyFieldName}();
    }


    /**
     * 更新数据库（根据主键更新）
     *
     * @param ${modelObjectName}
     */
    @Override
    public int update(${modelClassName} ${modelObjectName}) throws BusinessException {
        return ${mapperObjectName}.updateByPrimaryKeySelective(${modelObjectName});
    }

    /**
     * 通过主鍵查找
     *
     * @param id
     * @return
     */
    @Override
    public ${modelClassName} get(Integer id) {
        return ${mapperObjectName}.selectByPrimaryKey(id);
    }

    /**
     * 通过主鍵进行逻辑刪除
     *
     * @param id
     */
    @Override
    public int delete(Integer id) {
        // 逻辑删除
        ${modelClassName} ${modelObjectName} = new ${modelClassName}();
        ${modelObjectName}.set${keyFieldName}(id);
        ${modelObjectName}.setDeleteFlag(1);
        return ${mapperObjectName}.updateByPrimaryKeySelective(${modelObjectName});
    }

    /**
     * 根据相等条件进行查询
     *
     * @param queryParam 查询参数
     * @return
     */
    @Override
    public List<${voClassName}> list(${queryDtoClassName} queryParam) {

        // 这里需要指定实体类
        Example condition = new Example(${modelClassName}.class);

        // 创建查询条件
        Example.Criteria criteria = condition.createCriteria();

        // 拼接查询条件，支持链式调用，使用实体类的属性名称

        String paramString = JSON.toJSONString(queryParam);
        Map<String, Object> queryMap = JSON.parseObject(paramString, new TypeReference<HashMap<String, Object>>() {});
        for (Map.Entry<String, Object> entry : queryMap.entrySet()) {
            String property = entry.getKey();
            Object value = entry.getValue();
            // 跳过startRow和pageSize
            if ("startRow".equalsIgnoreCase(property) || "pageSize".equalsIgnoreCase(property)) {
                continue;
            }
            criteria = criteria.andEqualTo(property, value);
        }

        // 分页
        int startRow = queryParam.getStartRow();
        int pageSize = queryParam.getPageSize();
        if (startRow < 0) {
            startRow = 0;
        }
        if (pageSize <= 0) {
            pageSize = 20;
        }
        RowBounds rowBounds = new RowBounds(startRow, pageSize);

        // 排序，使用表的字段名称
        condition.setOrderByClause("create_time desc");

        // 封装ListResultVO
        List<${modelClassName}> list = ${mapperObjectName}.selectByExampleAndRowBounds(condition, rowBounds);

        String jsonString = JSON.toJSONString(list);
        List<${voClassName}> voList = JSON.parseArray(jsonString, ${voClassName}.class);

        return voList;
    }

    /**
     * 根据相等条件进行查询
     *
     * @param queryParam 查询参数
     * @return
     */
    @Override
    public int count(${queryDtoClassName} queryParam) {

        // 这里需要指定实体类
        Example condition = new Example(${modelClassName}.class);

        // 创建查询条件
        Example.Criteria criteria = condition.createCriteria();


        String paramString = JSON.toJSONString(queryParam);
        Map<String, Object> queryMap = JSON.parseObject(paramString, new TypeReference<HashMap<String, Object>>() {});
        for (Map.Entry<String, Object> entry : queryMap.entrySet()) {
            String property = entry.getKey();
            Object value = entry.getValue();
            // 跳过startRow和pageSize
            if ("startRow".equalsIgnoreCase(property) || "pageSize".equalsIgnoreCase(property)) {
                continue;
            }
            criteria = criteria.andEqualTo(property, value);
        }

        // 封装ListResultVO
        int num = ${mapperObjectName}.selectCountByCondition(condition);

        return num;

    }

}