package com.sb.constants;


public enum Action {
    Create(1),
    Edit(2),
    Delete(3),
    Update(4),
    Manage(5),
    Duplicate(6);
    
    private int value;

    private Action(int value) {
        this.value = value;
    }
    
    public int getValue() {
        return value;
    }
}
