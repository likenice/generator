package cn.zjhf.tool.quicker.util;

/**
 * Created by lutiehua on 2017/9/26.
 */
public class DirUtil {

    private static final String SEPARATOR = "\\.";

    public static String package2Dir(String packageName) {
        String [] item = packageName.split(SEPARATOR);
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i<item.length; i++) {
            if (i  > 0) {
                buffer.append("/");
            }
            buffer.append(item[i]);
        }
        return buffer.toString();
    }
}
