package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;

/**
 * Created by lutiehua on 2017/11/10.
 */
public class GeneratedAppTestPropFile extends AbstractGeneratedPropFile {

    private String fileName;

    public GeneratedAppTestPropFile(GeneratorParam generatorParam) {
        super(generatorParam);

        String rootDir = generatorParam.getPackageInfo().getProjectPath();
        String resourcePath = generatorParam.getPackageInfo().getResourcePath();
        fileName = rootDir + "/" + resourcePath + "/" + "application-test.properties";
    }

    /**
     * 模板
     *
     * @return
     */
    @Override
    public String getTemplateName() {
        return "app-test-properties.ftl";
    }

    /**
     * 文件名称
     *
     * @return
     */
    @Override
    public String getFileName() {
        return fileName;
    }
}
