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
import com.rent.exception.BusinessException;
import com.rent.model.ListResponseResult;
import com.rent.vo.ListResultVO;

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
        return ${mapperObjectName}.insertSelective(${modelObjectName});
    }

    /**
     * 批量持久化到数据库
     *
     * @param ${modelObjectName}List
     * @throws BusinessException
     */
    @Override
    public int save(List<${modelClassName}> ${modelObjectName}List) throws BusinessException {
        return ${mapperObjectName}.insertList(${modelObjectName}List);
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
    public ${modelClassName} get(Long id) {
        return ${mapperObjectName}.selectByPrimaryKey(id);
    }

    /**
     * 通过主鍵进行逻辑刪除
     *
     * @param id
     */
    @Override
    public int delete(Integer id) {
        // 物理删除
        // return coinMapper.deleteByPrimaryKey(id);

        // 逻辑删除
        ${modelClassName} ${modelObjectName} = new ${modelClassName}();
        ${modelObjectName}.set${keyFieldName}(id);
        //${modelObjectName}.setDeleteFlag(1);
        return ${mapperObjectName}.updateByPrimaryKeySelective(${modelObjectName});
    }

    /**
     * 根据相等条件进行查询
     *
     * @param queryParam 查询参数
     * @return
     */
    @Override
    public ListResponseResult<${voClassName}> query(${queryDtoClassName} queryParam) {

        // 这里需要指定实体类
        Example condition = new Example(${modelClassName}.class);

        // 创建查询条件
        Example.Criteria criteria = condition.createCriteria();

        // 拼接查询条件，支持链式调用，使用实体类的属性名称

        // 此处仅为示例，将对象转为Map可以完成通用的相等判断
        // criteria = criteria.andEqualTo("accountType", "21");
        // criteria = criteria.andEqualTo("accountStatus", 1);

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
        // pagehelper.offset-as-page-num=false，默认false，表示offset,limit，true表示pageNum,pageSize
        // pagehelper.row-bounds-with-count=true，表示先select count()，默认false，不查询count
        Integer startRow = queryParam.getStartRow();
        Integer pageSize = queryParam.getPageSize();
        if (startRow < 0) {
            startRow = 0;
        }
        if (pageSize == null) {
            pageSize = Integer.MAX_VALUE;
        }
        RowBounds rowBounds = new RowBounds(startRow, pageSize);

        // 排序，使用表的字段名称
        // condition.setOrderByClause("create_time desc");

        // 封装ListResultVO
        List<${modelClassName}> list = ${mapperObjectName}.selectByExampleAndRowBounds(condition, rowBounds);
        PageInfo pageInfo = new PageInfo(list);
        String jsonString = JSON.toJSONString(list);
        List<${voClassName}> voList = JSON.parseArray(jsonString, ${voClassName}.class);

        ListResultVO<${voClassName}> resultVO = new ListResultVO();
        resultVO.setCount(pageInfo.getTotal());
        //resultVO.setPageCount(pageInfo.getPages());
        //resultVO.setPageNum(pageInfo.getPageNum());
        //resultVO.setPageSize(pageInfo.getPageSize());
        resultVO.setList(voList);

        ListResponseResult<${voClassName}> result = new ListResponseResult();
        result.setData(resultVO);
        return result;
    }
}