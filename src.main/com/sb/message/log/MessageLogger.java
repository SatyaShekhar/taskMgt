package com.sb.message.log;

import java.util.Date;

/**
 * This class is used to provide the message is a proper format which should be replaced by logging mechanism
 * 
 * @author satya60.shekhar@gmail.com
 * 
 */
public class MessageLogger {
    private Class<?> classType;

    public MessageLogger(Class<?> classType) {
        this.classType = classType;
    }

    public void info(String message) {
        System.out.println(new Date().toString() + " - INFO - " + classType.getName() + " - " + message);
    }

    public void error(String message) {
        System.out.println(new Date().toString() + " <<<<<<<<<<<< ERROR >>>>>>>>>>>> " + classType.getName() + " - " + message);
    }

    public void warning(String message) {
        System.out.println(new Date().toString() + " :::: WARNING :::: " + classType.getName() + " - " + message);
    }
    
    /**
     * Better use instance method of info and error
     * 
     * @param message
     * @param classType
     */
    @Deprecated
    public static void info(String message, Class<?> classType) {
        System.out.println(new Date().toString() + " - INFO - " + classType.getName() + " - " + message);
    }

    /**
     * Better use instance method of info and error
     * 
     * @param message
     * @param classType
     */
    @Deprecated
    public static void error(String message, Class<?> classType) {
        System.out.println(new Date().toString() + " - ERROR - " + classType.getName() + " - " + message);
    }
}
