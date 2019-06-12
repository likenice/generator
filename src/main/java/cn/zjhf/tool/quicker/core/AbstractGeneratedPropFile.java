package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.model.DataModel;
import cn.zjhf.tool.quicker.model.PropModel;

/**
 * 属性文件生成类的抽象基类
 *
 * @author lutiehua
 * @date 2017/11/10
 */
public abstract class AbstractGeneratedPropFile extends AbstractGeneratedFile {

    protected PropModel model;

    public AbstractGeneratedPropFile(GeneratorParam generatorParam) {
        super(generatorParam);

        model = new PropModel();

        int port = generatorParam.getProjectInfo().getPort();
        int managePort = port + 10000;

        model.setDbName(generatorParam.getDatabaseInfo().getDbName());
        model.setManagePort(managePort);
        model.setServiceName(generatorParam.getProjectInfo().getName());
        model.setServicePort(port);
        generatorParam.getDatabaseInfo().getDbUsername();
        generatorParam.getDatabaseInfo().getDbPassword();
        generatorParam.getDatabaseInfo().getDbIP();
        generatorParam.getDatabaseInfo().getDbPort();


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
}
