package com.sb.constants;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public enum Severity {
    Future(1),
    Cusmetic(2),
    Minor(3),
    Modorate(4),
    Major(5),
    Sever(6);
    private int value;

    private Severity(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static Severity valueOf(int value) {
        for (Severity severity : values()) {
            if (severity.getValue() == value) {
                return severity;
            }
        }
        return null;
    }
}
