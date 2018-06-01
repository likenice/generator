package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.dto.TableInfo;

/**
 * 生成配置文件类
 *
 * Created by lutiehua on 2017/11/14.
 */
public class GeneratedJavaConfigClass extends AbstractGeneratedJavaClass {

    public GeneratedJavaConfigClass(GeneratorParam generatorParam, TableInfo tableInfo) {
        super(generatorParam, tableInfo);
    }

    /**
     * 模板名称
     *
     * @return
     */
    @Override
    public String getTemplateName() {
        return "web-config.ftl";
    }

    /**
     * 包名
     *
     * @return
     */
    @Override
    public String getJavaPackageName() {
        return generatorParam.getPackageInfo().getConfigPackage();
    }

    /**
     * 留给子类覆盖用
     *
     * @return
     */
    @Override
    protected String getJavaClassName() {
        return "WebConfig";
    }

    /**
     * 类名后缀
     *
     * @return
     */
    @Override
    public String getJavaClassNamePostfix() {
        return "";
    }

    /**
     * 留给子类覆盖用
     *
     * @return
     */
    @Override
    protected String getJavaClassRemark() {
        return "WEB配置类";
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
}
