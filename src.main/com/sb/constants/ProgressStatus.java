package com.sb.constants;

public enum ProgressStatus {
    Defined(1),
    Progress(2),
    Complete(3),
    Accepted(4);
    
    private int value;
    
    private ProgressStatus(int value) {
        this.value = value;
    }

    /**
     * 
     * @param value for whichi status is to be retrieved
     * 
     * @return can return null if status with matching value not found
     */
    public static ProgressStatus valueOf(int value) {
        for (ProgressStatus progressStatus : values()) {
            if (progressStatus.value == value) {
                return progressStatus;
            }
        }
        return null;
    }

    public int getValue() {
        return value;
    }
}
