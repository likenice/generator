package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.common.KeyType;
import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.dto.TableInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 生成SpringCloud项目文件
 *
 * @author lutiehua
 * @date 2017/11/10
 */
@Component
public class SpringCloudProjectGenerator implements Generator {

    @Autowired
    private MybatisGenerator mybatisGenerator;

    @Autowired
    private SpringMVCGenerator springMVCGenerator;

    /**
     * 自动生成代码
     *
     * @param generatorParam
     */
    @Override
    public void generateCode(GeneratorParam generatorParam) throws Exception {

        List<AbstractGeneratedFile> generatedFileList = new ArrayList();

        /**
         * 最外层的项目文件
         */

        // POM.xml
        generatedFileList.add(new GeneratedCloudPomFile(generatorParam));

        // Git ignore
        generatedFileList.add(new GeneratedGitIgnoreFile(generatorParam));

        String rootDir = generatorParam.getPackageInfo().getProjectPath();
        String projectName = generatorParam.getProjectInfo().getArtifactId();

        /**
         * 接口项目文件
         */

        // 修改根目录
        String projectDir = rootDir + "/" + projectName + "-facade";
        generatorParam.getPackageInfo().setProjectPath(projectDir);

        // 接口项目的pom.xml
        generatedFileList.add(new GeneratedCloudFacadePomFile(generatorParam));

        // 遍历每个表生成对应的接口类文件
        for (TableInfo tableInfo : generatorParam.getTables()) {
            // DTO
            generatedFileList.add(new GeneratedJavaDTOClass(generatorParam, tableInfo));

            // QueryParamDTO
            generatedFileList.add(new GeneratedJavaQueryClass(generatorParam, tableInfo));

            // VO
            generatedFileList.add(new GeneratedJavaVOClass(generatorParam, tableInfo));

            // Client
            generatedFileList.add(new GeneratedJavaControllerFacadeClass(generatorParam, tableInfo));

            // Fallback
            generatedFileList.add(new GeneratedJavaControllerFacadeFallbackClass(generatorParam, tableInfo));
        }

        // FeignConfig
        generatedFileList.add(new GeneratedJavaFeignConfigClass(generatorParam, null));


        /**
         * 服务项目文件
         */

        // 修改根目录
        projectDir = rootDir + "/" + projectName + "-server";
        generatorParam.getPackageInfo().setProjectPath(projectDir);

        // 接口项目的pom.xml
        generatedFileList.add(new GeneratedCloudServerPomFile(generatorParam));

        // Application
        generatedFileList.add(new GeneratedJavaAppClass(generatorParam));

        // ApplicationTest
        generatedFileList.add(new GeneratedJavaAppTestClass(generatorParam));

        // application.properties
        generatedFileList.add(new GeneratedAppPropFile(generatorParam));

        // application-dev.properties
        generatedFileList.add(new GeneratedAppDevPropFile(generatorParam));

        // application-test1.properties
        generatedFileList.add(new GeneratedAppTestPropFile(generatorParam));

        // application-test2.properties

        // application-local.properties

        // boot.properties
        generatedFileList.add(new GeneratedBootPropFile(generatorParam));

        // log4j2
        generatedFileList.add(new GeneratedLog4j2File(generatorParam));

        // 生成实体类对象
        mybatisGenerator.generateCode(generatorParam);

        // WebConfig
        generatedFileList.add(new GeneratedJavaConfigClass(generatorParam, null));

        // 遍历每个表生成对应的服务类文件
        for (TableInfo tableInfo : generatorParam.getTables()) {
            // Controller
            generatedFileList.add(new GeneratedJavaControllerImplClass(generatorParam, tableInfo));

            // Service
            generatedFileList.add(new GeneratedJavaServiceClass(generatorParam, tableInfo));

            // ServiceImpl
            generatedFileList.add(new GeneratedJavaServiceImplClass(generatorParam, tableInfo));

            // InsertListMapper
            if (KeyType.KEY_TYPE_ID.equalsIgnoreCase(tableInfo.getKeyType())) {
                generatedFileList.add(new GeneratedJavaInsertListMapperClass(generatorParam, tableInfo));
            }
        }

        /**
         * 统一生成文件
         */

        // 生成代码
        for (AbstractGeneratedFile generatedFile : generatedFileList) {
            generatedFile.generateFile();
        }
    }
}
