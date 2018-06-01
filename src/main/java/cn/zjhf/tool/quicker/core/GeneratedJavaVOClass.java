package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.dto.TableInfo;
import cn.zjhf.tool.quicker.entity.DBField;
import cn.zjhf.tool.quicker.model.JavaField;
import com.google.common.base.CaseFormat;

import java.util.List;

/**
 * 生成VO类
 *
 * Created by lutiehua on 2017/9/26.
 */
public class GeneratedJavaVOClass extends AbstractGeneratedJavaDatabaseClass {

    /**
     * 构造函数
     *
     * @param generatorParam
     * @param tableInfo
     */
    public GeneratedJavaVOClass(GeneratorParam generatorParam, TableInfo tableInfo) {
        super(generatorParam, tableInfo);

        List<DBField> fieldList = null;
        try {
            fieldList = getTableColumns();
            for (DBField field : fieldList) {
                JavaField javaField = new JavaField();
                // 将数据库字段名转化为Java属性名，product_type => productType
                String fieldName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, field.getColumnName());
                javaField.setName(fieldName);
                String fieldType = toJavaType(field.getTypeName());
                fieldType = super.parseJavaImportType(fieldType);
                javaField.setType(fieldType);
                javaField.setRemark(field.getRemarks());

                // API文档的注解
                javaField.getAnnotations().add(getApiDocumentAnnotation(field));

                javaFieldList.add(javaField);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getTemplateName() {
        return "vo.ftl";
    }

    /**
     * 包名
     *
     * @return
     */
    @Override
    public String getJavaPackageName() {
        return generatorParam.getPackageInfo().getVoPackage();
    }

    /**
     * 类名后缀
     *
     * @return
     */
    @Override
    public String getJavaClassNamePostfix() {
        return "VO";
    }

    /**
     * 类说明后缀
     *
     * @return
     */
    @Override
    public String getJavaClassRemarkPostfix() {
        return "返回值对象";
    }
}