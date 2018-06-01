package cn.zjhf.tool.quicker.core;

import cn.zjhf.tool.quicker.common.KeyType;
import cn.zjhf.tool.quicker.dto.GeneratorParam;
import cn.zjhf.tool.quicker.dto.OrderByInfo;
import cn.zjhf.tool.quicker.dto.TableInfo;
import com.google.common.base.Charsets;
import com.google.common.base.Splitter;
import com.google.common.io.Files;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author lutiehua
 * @date 2017/11/14
 */
@Component
public class SpringMVCGenerator implements Generator {

    /**
     * 自动生成代码
     *
     * @param generatorParam
     */
    @Override
    public void generateCode(GeneratorParam generatorParam) throws Exception {
        for (TableInfo tableInfo : generatorParam.getTables()) {
            generateController(generatorParam, tableInfo);
            generateService(generatorParam, tableInfo);
            generateModel2(generatorParam, tableInfo);
//            refreshEntity(generatorParam, tableInfo);
//            if (KeyType.KEY_TYPE_ID.equalsIgnoreCase(tableInfo.getKeyType())) {
//                generateInsertListMapper(generatorParam, tableInfo);
//            }
        }
        //配置文件(java)
//        generateConfig(generatorParam);
    }

    private void generateController(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        // Controller
        GeneratedJavaXYControllerClass javaControllerClass = new GeneratedJavaXYControllerClass(generatorParam, tableInfo);
        javaControllerClass.generateFile();
    }

    private void generateService(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        // Service
        GeneratedJavaXYServiceClass javaServiceClass = new GeneratedJavaXYServiceClass(generatorParam, tableInfo);
        javaServiceClass.generateFile();

        // ServiceImpl
        GeneratedJavaXYServiceImplClass javaServiceImplClass = new GeneratedJavaXYServiceImplClass(generatorParam, tableInfo);
        javaServiceImplClass.generateFile();
    }

    private void generateModel(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        // DTO
        GeneratedJavaDTOClass javaDTOClass = new GeneratedJavaDTOClass(generatorParam, tableInfo);
        javaDTOClass.generateFile();

        // QueryParamDTO
        GeneratedJavaQueryClass javaQueryParamClass = new GeneratedJavaQueryClass(generatorParam, tableInfo);
        javaQueryParamClass.generateFile();

        // VO
        GeneratedJavaVOClass javaVOClass = new GeneratedJavaVOClass(generatorParam, tableInfo);
        javaVOClass.generateFile();
    }

    private void generateModel2(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        // DTO
        GeneratedJavaDTOClass javaDTOClass = new GeneratedJavaDTOClass(generatorParam, tableInfo);
        javaDTOClass.generateFile();

        // QueryParamDTO
        GeneratedJavaQueryClass javaQueryParamClass = new GeneratedJavaQueryClass(generatorParam, tableInfo);
        javaQueryParamClass.generateFile();

        // QueryParamDTO
        GeneratedJavaPageQueryClass javaPageQueryParamClass = new GeneratedJavaPageQueryClass(generatorParam, tableInfo);
        javaPageQueryParamClass.generateFile();

        // VO
        GeneratedJavaVOClass javaVOClass = new GeneratedJavaVOClass(generatorParam, tableInfo);
        javaVOClass.generateFile();
    }


    private void generateConfig(GeneratorParam generatorParam) throws Exception {
        // WebConfig
        GeneratedJavaConfigClass javaConfigClass = new GeneratedJavaConfigClass(generatorParam, null);
        javaConfigClass.generateFile();
    }

    private void generateInsertListMapper(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        GeneratedJavaInsertListMapperClass insertListMapperClass = new GeneratedJavaInsertListMapperClass(generatorParam, tableInfo);
        insertListMapperClass.generateFile();
    }

    /**
     * 更新MybatisGenerator生成的实体类文件，增加@OrderBy注解
     *
     * @param generatorParam
     * @param tableInfo
     * @throws Exception
     */
    private void refreshEntity(GeneratorParam generatorParam, TableInfo tableInfo) throws Exception {
        // 包名
        String basePackage = generatorParam.getPackageInfo().getBasePackage();
        String entityPackage = String.format("%s.%s", basePackage, generatorParam.getPackageInfo().getEntityPackage());
        String rootDir = generatorParam.getPackageInfo().getProjectPath();
        String javaPath = generatorParam.getPackageInfo().getJavaPath();

        List<String> list = Splitter.on(".").splitToList(entityPackage);
        StringBuffer buffer = new StringBuffer();
        for (String path : list) {
            buffer.append(path);
            buffer.append("/");
        }
        String packagePath = buffer.toString();
        String dirName = rootDir + "/" + javaPath + "/" + packagePath;

        // 列出已生成的文件
        List<String> fileList = getFileList(dirName);
        for(String fileName : fileList) {
            File file = new File(fileName);
            List<String> lines = Files.readLines(file, Charsets.UTF_8);
            StringBuffer fileBuffer = new StringBuffer();
            for (String line : lines) {
                fileBuffer.append(line);
                fileBuffer.append("\n");
                for (OrderByInfo orderByInfo : tableInfo.getOrder()) {
                    String column = String.format("@Column(name = \"%s\")", orderByInfo.getField());
                    if (line.indexOf(column) >= 0) {
                        // 排序字段
                        String sort = String.format("\t@OrderBy(value = \"%s\")", orderByInfo.getSort());
                        fileBuffer.append(sort);
                        fileBuffer.append("\n");
                    }
                }
            }
            String fileContent = fileBuffer.toString();
            Files.write(fileContent.getBytes(), file);
        }
    }

    /**
     * 读取目录下的所有文件列表
     *
     * @param dir
     * @return
     */
    private List<String> getFileList(String dir) {
        List<String> listFile = new ArrayList<>();
        File dirFile = new File(dir);
        //如果不是目录文件，则直接返回
        if (!dirFile.isDirectory()) {
            return listFile;
        }

        //获得文件夹下的文件列表，然后根据文件类型分别处理
        File[] files = dirFile.listFiles();
        if (null != files && files.length > 0) {
            for (File file : files) {
                //如果不是目录，直接添加
                if (!file.isDirectory()) {
                    listFile.add(file.getAbsolutePath());
                } else {
                    //对于目录文件，递归调用
                    listFile.addAll(getFileList(file.getAbsolutePath()));
                }
            }
        }

        return listFile;
    }
}
