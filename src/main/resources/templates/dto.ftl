package ${packageName};

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import com.domes.generatortools.dto.ParamDTO;
import com.domes.generatortools.validation.InsertGroup;
import com.domes.generatortools.validation.UpdateGroup;

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
public class ${className} extends ParamDTO {

    <#list fields as field>
    /**
     * ${field.remark}
     *
     */
    <#list field.annotations as annotation>
    @${annotation.show}
    </#list>
    <#if field.value?exists>
    private ${field.type} ${field.name} = ${field.value};
    <#else>
    private ${field.type} ${field.name};
    </#if>

    </#list>
}