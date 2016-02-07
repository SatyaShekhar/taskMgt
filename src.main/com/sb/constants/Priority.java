package com.sb.constants;

public enum Priority {
    Minor(1),
    Midium(2),
    High(3),
    Future(4);
    private int value;
    private Priority(int value) {
        this.value = value;
    }
    
    public int getValue() {
        return value;
    }
    
    public static Priority valueOf(int value) {
        for(Priority priority : values()) {
            if (priority.getValue() == value) {
                return priority;
            }
        }
        return null;
    }
}
