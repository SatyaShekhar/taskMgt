package com.sb.constants;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public enum Priority {
    High(1),
    Midium(2),
    Minor(3),
    Future(4);
    private int value;

    private Priority(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public static Priority valueOf(int value) {
        for (Priority priority : values()) {
            if (priority.getValue() == value) {
                return priority;
            }
        }
        return null;
    }
}
