package ${packageName};

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import com.domes.generatortools.vo.ResultVO;
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
public class ${className} extends ResultVO {

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