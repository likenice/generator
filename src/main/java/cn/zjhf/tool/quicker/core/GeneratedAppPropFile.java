package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.model.DataModel;
import cn.zjhf.tool.quicker.model.PropModel;

/**
 * Created by lutiehua on 2017/11/10.
 */
public class GeneratedAppPropFile extends AbstractGeneratedFile {

    private PropModel model;

    private String fileName;

    public GeneratedAppPropFile(GeneratorParam generatorParam) {
        super(generatorParam);

        model = new PropModel();

        int port = generatorParam.getProjectInfo().getPort();
        int managePort = port + 10000;

        String basePackageName = generatorParam.getPackageInfo().getBasePackage();
        String packageName = basePackageName + "." + generatorParam.getPackageInfo().getEntityPackage();

        model.setDbName(generatorParam.getDatabaseInfo().getDbName());
        model.setManagePort(managePort);
        model.setServiceName(generatorParam.getProjectInfo().getName());
        model.setServicePort(port);
        model.setEntityPackage(packageName);

        String rootDir = generatorParam.getPackageInfo().getProjectPath();
        String resourcePath = generatorParam.getPackageInfo().getResourcePath();
        fileName = rootDir + "/" + resourcePath + "/" + "application.properties";

        model.setProjectType(generatorParam.getProjectInfo().getProjectType());
    }

    /**
     * 模板
     *
     * @return
     */
    @Override
    public String getTemplateName() {
        return "app-properties.ftl";
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
