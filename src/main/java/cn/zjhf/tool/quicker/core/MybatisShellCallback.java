package cn.zjhf.tool.quicker.core;

import org.mybatis.generator.api.ShellCallback;
import org.mybatis.generator.exception.ShellException;
import org.springframework.stereotype.Component;

import java.io.File;
import java.util.StringTokenizer;

import static org.mybatis.generator.internal.util.messages.Messages.getString;

/**
 * @author lutiehua
 * @date 2017/11/9
 */
@Component
public class MybatisShellCallback implements ShellCallback {

    public MybatisShellCallback() {
        super();
    }

    /**
     * This method is called to ask the shell to resolve a project/package combination into a directory on the file
     * system. This method is called repeatedly (once for each generated file), so it would be wise for an implementing
     * class to cache results.
     * <p>
     * The returned <code>java.io.File</code> object:
     * <ul>
     * <li>Must be a directory</li>
     * <li>Must exist</li>
     * </ul>
     * <p>
     * The default shell callback interprets both values as directories and simply concatenates the two values to
     * generate the default directory.
     *
     * @param targetProject the target project
     * @param targetPackage the target package
     * @return the directory (must exist)
     * @throws ShellException if the project/package cannot be resolved into a directory on the file system. In this case, the
     *                        generator will not save the file it is currently working on. The generator will add the exception
     *                        message to the list of warnings automatically.
     */
    @Override
    public File getDirectory(String targetProject, String targetPackage) throws ShellException {
        File project = new File(targetProject);
        if (!project.isDirectory()) {
            project.mkdirs();
        }

        StringBuilder sb = new StringBuilder();
        StringTokenizer st = new StringTokenizer(targetPackage, "."); //$NON-NLS-1$
        while (st.hasMoreTokens()) {
            sb.append(st.nextToken());
            sb.append(File.separatorChar);
        }

        File directory = new File(project, sb.toString());
        if (!directory.isDirectory()) {
            boolean rc = directory.mkdirs();
            if (!rc) {
                throw new ShellException(getString("Warning.10", //$NON-NLS-1$
                        directory.getAbsolutePath()));
            }
        }

        return directory;
    }

    /**
     * This method is called if a newly generated Java file would
     * overwrite an existing file. This method should return the merged source
     * (formatted). The generator will write the merged source as-is to the file
     * system.
     * <p>
     * A merge typically follows these steps:
     * <ol>
     * <li>Delete any methods/fields in the existing file that have the
     * specified JavaDoc tag</li>
     * <li>Add any new super interfaces from the new file into the existing file
     * </li>
     * <li>Make sure that the existing file's super class matches the new file</li>
     * <li>Make sure that the existing file is of the same type as the existing
     * file (either interface or class)</li>
     * <li>Add any new imports from the new file into the existing file</li>
     * <li>Add all methods and fields from the new file into the existing file</li>
     * <li>Format the resulting source string</li>
     * </ol>
     * <p>
     * This method is called only if you return <code>true</code> from
     * <code>isMergeSupported()</code>.
     *
     * @param newFileSource        the source of the newly generated Java file
     * @param existingFileFullPath the fully qualified path name of the existing Java file
     * @param javadocTags          the JavaDoc tags that denotes which methods and fields in the
     *                             old file to delete (if the Java element has any of these tags,
     *                             the element is eligible for merge)
     * @param fileEncoding         the file encoding for reading existing Java files.  Can be null,
     *                             in which case the platform default encoding will be used.
     * @return the merged source, properly formatted. The source will be saved
     * exactly as returned from this method.
     * @throws ShellException if the file cannot be merged for some reason. If this
     *                        exception is thrown, nothing will be saved and the
     *                        existing file will remain undisturbed. The generator will add the
     *                        exception message to the list of warnings automatically.
     */
    @Override
    public String mergeJavaFile(String newFileSource, String existingFileFullPath, String[] javadocTags, String fileEncoding) throws ShellException {
        throw new UnsupportedOperationException();
    }

    /**
     * After all files are saved to the file system, this method is called
     * once for each unique project that was affected by the generation
     * run. This method is useful if your IDE needs to be informed that file
     * system objects have been created or updated. If you are running
     * outside of an IDE, your implementation need not do anything in this
     * method.
     *
     * @param project the project to be refreshed
     */
    @Override
    public void refreshProject(String project) {

    }

    /**
     * Return true if the callback supports Java merging, otherwise false.
     * The <code>mergeJavaFile()</code> method will be called only if this
     * method returns <code>true</code>.
     *
     * @return a boolean specifying whether Java merge is supported or not
     */
    @Override
    public boolean isMergeSupported() {
        return false;
    }

    /**
     * Return true if the generator should overwrite an existing file if one exists.
     * This method will be called only if <code>isMergeSupported()</code>
     * returns <code>false</code> and a file exists that would be overwritten by
     * a generated file. If you return <code>true</code>, then we will log a
     * warning specifying what file was overwritten.
     *
     * @return true if you want to overwrite existing files
     */
    @Override
    public boolean isOverwriteEnabled() {
        return true;
    }
}
