package com.sb.pojo;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class Organization {
    private long id;
    private String name;
    // Organization history!! how it will be maintained as there will not be any author while creating.
    // So no author while creating the organization add when modified later.
    private History history;

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * @param id
     *            the id to set
     */
    public void setId(long id) {
        this.id = id;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the history
     */
    public History getHistory() {
        return history;
    }

    /**
     * @param history the history to set
     */
    public void setHistory(History history) {
        this.history = history;
    }

    @Override
    public String toString() {
        return "Organization(Name:"+getName()+")";
    }
}
