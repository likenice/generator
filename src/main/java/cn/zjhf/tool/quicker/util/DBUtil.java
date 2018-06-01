package cn.zjhf.tool.quicker.util;

import com.google.common.base.Strings;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by lutiehua on 2017/9/26.
 */
public class DBUtil {

    private static final String SEPARATOR = "_";

    /**
     * 数据库字段名转Java成员变量名
     *
     * @param filedName
     * @return
     */
    public static String toJavaPropertyName(String filedName) {
        String [] item = filedName.split(SEPARATOR);
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i<item.length; i++) {
            if (0 == i) {
                buffer.append(item[i].toLowerCase());
            } else {
                buffer.append(toUpperFirstChar(item[i]));
            }
        }
        return buffer.toString();
    }

    /**
     * 首字母大写
     *
     * @param data
     * @return
     */
    public static String toUpperFirstChar(String data) {
        if (Strings.isNullOrEmpty(data)) {
            return null;
        }

        if (data.length() <= 1) {
            return data.toUpperCase();
        }

        String first = data.substring(0, 1);
        String remain = data.substring(1);
        return first.toUpperCase() + remain.toLowerCase();
    }

    private static final Map<String, String> DB_TYPE_2_JAVA_TYPE = new HashMap<>();

    static {
        DB_TYPE_2_JAVA_TYPE.put("varchar", "java.util.String");
        DB_TYPE_2_JAVA_TYPE.put("char", "java.util.String");
        DB_TYPE_2_JAVA_TYPE.put("text", "java.util.String");
        DB_TYPE_2_JAVA_TYPE.put("json", "java.util.String");
        DB_TYPE_2_JAVA_TYPE.put("boolean", "java.lang.Integer");
        DB_TYPE_2_JAVA_TYPE.put("tinyint", "java.lang.Integer");
        DB_TYPE_2_JAVA_TYPE.put("smallint", "java.lang.Integer");
        DB_TYPE_2_JAVA_TYPE.put("int", "java.lang.Integer");
        DB_TYPE_2_JAVA_TYPE.put("bigint", "java.lang.Long");
        DB_TYPE_2_JAVA_TYPE.put("id", "java.lang.Long");
        DB_TYPE_2_JAVA_TYPE.put("float", "java.lang.Float");
        DB_TYPE_2_JAVA_TYPE.put("double", "java.lang.Double");
        DB_TYPE_2_JAVA_TYPE.put("decimal", "java.math.BigDecimal");
        DB_TYPE_2_JAVA_TYPE.put("date", "java.util.Date");
        DB_TYPE_2_JAVA_TYPE.put("time", "java.util.Date");
        DB_TYPE_2_JAVA_TYPE.put("datetime", "java.util.Date");
        DB_TYPE_2_JAVA_TYPE.put("timestamp", "java.util.Date");
    }

    /**
     * 数据库类型转Java类型
     *
     * @param dbType
     * @return
     */
    public static String toJavaType(String dbType) {
        dbType = dbType.toLowerCase();
        if (DB_TYPE_2_JAVA_TYPE.containsKey(dbType)) {
            return DB_TYPE_2_JAVA_TYPE.get(dbType);
        } else {
            return null;
        }
    }
}
