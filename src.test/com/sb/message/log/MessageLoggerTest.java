package com.sb.message.log;

/**
 * This class does not extends JUnit and using simple mechanism to test manually
 * 
 * @author sbarik
 * 
 */
public class MessageLoggerTest {

    public static void main(String[] args) {
        testMessageFormat();
    }

    private static void testMessageFormat() {
        MessageLogger.info("Hello", MessageLoggerTest.class);
        MessageLogger.error("Hello", MessageLoggerTest.class);
    }
}