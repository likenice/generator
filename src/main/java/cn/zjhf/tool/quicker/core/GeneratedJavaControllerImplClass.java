package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.common.KeyType;
import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.dto.PackageInfo;
import cn.zjhf.tool.quicker.dto.TableInfo;
import com.google.common.base.CaseFormat;

/**
 *
 * @author lutiehua
 * @date 2017/9/28
 */
public class GeneratedJavaControllerImplClass extends AbstractGeneratedJavaTemplateClass {

    public GeneratedJavaControllerImplClass(GeneratorParam generatorParam, TableInfo tableInfo) {
        super(generatorParam, tableInfo);

        // 基础表名
        String tableName = tableInfo.getName();

        // 基础类名
        String modelName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, tableName.toLowerCase());

        // Package信息
        PackageInfo packageInfo = generatorParam.getPackageInfo();

        // 基础包名
        String basePackage = packageInfo.getBasePackage();

        // Facade类
        String facadeClassName = String.format("%s.%s.%sClient", basePackage, packageInfo.getControllerPackage(), modelName);
        facadeClassName = super.parseJavaImportType(facadeClassName);
        model.setFacadeClassName(facadeClassName);

        String keyFieldName = tableInfo.getKey();
        if (null != keyFieldName) {
            keyFieldName = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.UPPER_CAMEL, keyFieldName);
            model.setKeyFieldName(keyFieldName);
        }
    }

    /**
     * 包名
     *
     * @return
     */
    @Override
    public String getJavaPackageName() {
        return generatorParam.getPackageInfo().getControllerPackage();
    }

    /**
     * 类名后缀
     *
     * @return
     */
    @Override
    public String getJavaClassNamePostfix() {
        return "Controller";
    }

    /**
     * 类说明后缀
     *
     * @return
     */
    @Override
    public String getJavaClassRemarkPostfix() {
        return "";
    }

    /**
     * 模板
     *
     * @return
     */
    @Override
    public String getTemplateName() throws Exception {
        if (KeyType.KEY_TYPE_UUID.equalsIgnoreCase(tableInfo.getKeyType())) {
            return "cloud/controller-impl-uuid.ftl";
        } else if (KeyType.KEY_TYPE_ID.equalsIgnoreCase(tableInfo.getKeyType())) {
            return "cloud/controller-impl-id.ftl";
        } else {
            throw new Exception("Unexpected key type = [" + tableInfo.getKeyType() + "]");
        }
    }
}
