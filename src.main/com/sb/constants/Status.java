package com.sb.constants;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public enum Status {

    New(1),
    Assigned(1),
    Open(2),
    Resolved(3),
    Verified(4),
    Junk(5),
    Close(6),
    Reopened(7);
    
    private int value;

    private Status(int value) {
        this.value = value;
    }

    public static Status valueOf(int value) {
        for (Status status : values()) {
            if (status.getValue() == value) {
                return status;
            }
        }
        return null;
    }

    public int getValue() {
        return value;
    }
}
