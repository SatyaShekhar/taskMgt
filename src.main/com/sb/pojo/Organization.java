package com.sb.pojo;

public class Organization {
    private long id;
    private String name;
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

}
