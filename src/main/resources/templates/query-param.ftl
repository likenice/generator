package ${packageName};

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import com.rent.dto.QueryParam;
<#list imports as import>
import ${import.name};
</#list>

/**
 * ${classRemark}
 *
 * @author ${author}
 * @date ${date}
 */
@Getter
@Setter
@ToString
public class ${className} extends QueryParam {

    <#list fields as field>
    /**
     * ${field.remark}
     *
     */
    <#list field.annotations as annotation>
    @${annotation.show}
    </#list>
    private ${field.type} ${field.name};

    </#list>

}