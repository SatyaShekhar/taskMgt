package com.sb.constants;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public enum BugStatus {

    New(1),
    Assigned(2),
    Open(3),
    Resolved(4),
    Verified(5),
    Junk(6),
    Close(7),
    Reopened(8);
    
    private int value;

    private BugStatus(int value) {
        this.value = value;
    }

    public static BugStatus valueOf(int value) {
        for (BugStatus status : values()) {
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
