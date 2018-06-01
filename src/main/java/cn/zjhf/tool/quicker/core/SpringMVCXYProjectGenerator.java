package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.dto.GeneratorParam;
import org.springframework.stereotype.Component;

/**
 * 生成SpringBoot项目文件
 *
 * @author lutiehua
 * @date 2017/11/10
 */
@Component
public class SpringMVCXYProjectGenerator implements Generator {

    /**
     * 自动生成代码
     *
     * @param generatorParam
     */
    @Override
    public void generateCode(GeneratorParam generatorParam) throws Exception {

        // Application
        GeneratedJavaAppClass generatedJavaAppClass = new GeneratedJavaAppClass(generatorParam);
        generatedJavaAppClass.generateFile();

        // ApplicationTest
//        GeneratedJavaAppTestClass javaAppTestClass = new GeneratedJavaAppTestClass(generatorParam);
//        javaAppTestClass.generateFile();

        // POM
        GeneratedPomFile generatedPomFile = new GeneratedPomFile(generatorParam);
        generatedPomFile.generateFile();

        // Properties
        GeneratedAppPropFile appPropFile = new GeneratedAppPropFile(generatorParam);
        appPropFile.generateFile();

        GeneratedAppDevPropFile appDevPropFile = new GeneratedAppDevPropFile(generatorParam);
        appDevPropFile.generateFile();

        GeneratedAppTestPropFile appTestPropFile = new GeneratedAppTestPropFile(generatorParam);
        appTestPropFile.generateFile();

        GeneratedBootPropFile bootPropFile = new GeneratedBootPropFile(generatorParam);
        bootPropFile.generateFile();

        // log4j2
        GeneratedLog4j2File log4j2File = new GeneratedLog4j2File(generatorParam);
        log4j2File.generateFile();

        // Git ignore
        GeneratedGitIgnoreFile gitIgnoreFile = new GeneratedGitIgnoreFile(generatorParam);
        gitIgnoreFile.generateFile();
    }
}