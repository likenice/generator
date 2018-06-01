package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.model.DataModel;
import cn.zjhf.tool.quicker.model.Log4j2Model;

/**
 * Created by lutiehua on 2017/11/10.
 */
public class GeneratedLog4j2File extends AbstractGeneratedFile {

    private Log4j2Model model;

    private String fileName;

    public GeneratedLog4j2File(GeneratorParam generatorParam) {
        super(generatorParam);

        String basePackageName = generatorParam.getPackageInfo().getBasePackage();
        String mapperPackageName = basePackageName + "." + generatorParam.getPackageInfo().getDaoPackage();

        model = new Log4j2Model();
        model.setName(generatorParam.getProjectInfo().getName());
        model.setMapperPackage(mapperPackageName);

        String rootDir = generatorParam.getPackageInfo().getProjectPath();
        String resourcePath = generatorParam.getPackageInfo().getResourcePath();
        fileName = rootDir + "/" + resourcePath + "/" + "log4j2.xml";
    }

    /**
     * 模板
     *
     * @return
     */
    @Override
    public String getTemplateName() {
        return "log4j2.ftl";
    }

    /**
     * 变量数据
     *
     * @return
     */
    @Override
    public DataModel getDataModel() {
        return model;
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
