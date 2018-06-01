package cn.zjhf.tool.quicker.core;

import org.mybatis.generator.api.ProgressCallback;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * @author lutiehua
 * @date 2017/11/9
 */
@Component
public class MybatisProgressCallback implements ProgressCallback {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * Called to note the start of the introspection phase, and to note the
     * maximum number of startTask messages that will be sent for the
     * introspection phase.
     *
     * @param totalTasks the maximum number of times startTask will be called for the
     *                   introspection phase.
     */
    @Override
    public void introspectionStarted(int totalTasks) {

    }

    /**
     * Called to note the start of the generation phase, and to note the maximum
     * number of startTask messages that will be sent for the generation phase.
     *
     * @param totalTasks the maximum number of times startTask will be called for the
     *                   generation phase.
     */
    @Override
    public void generationStarted(int totalTasks) {
        logger.info("生成mybatis代码开始，一共{}步", totalTasks);
    }

    /**
     * Called to note the start of the file saving phase, and to note the
     * maximum number of startTask messages that will be sent for the file
     * saving phase phase.
     *
     * @param totalTasks the maximum number of times startTask will be called for the
     *                   file saving phase.
     */
    @Override
    public void saveStarted(int totalTasks) {
        logger.info("开始写文件到磁盘，一共{}步", totalTasks);
    }

    /**
     * Called to denote the beginning of a save task
     *
     * @param taskName a descriptive name of the current work step
     */
    @Override
    public void startTask(String taskName) {
        logger.info("开始 {}", taskName);
    }

    /**
     * This method is called when all generated files have been saved
     */
    @Override
    public void done() {
        logger.info("任务完成");
    }

    /**
     * The method is called periodically during a long running method.
     * If the the implementation throws <code>InterruptedException</code> then
     * the method will be canceled. Any files that have already been saved will
     * remain on the file system.
     *
     * @throws InterruptedException if the operation should be halted
     */
    @Override
    public void checkCancel() throws InterruptedException {

    }
}
