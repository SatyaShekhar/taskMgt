package com.sb.pojo;

import java.util.Date;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class Author {
    private long authorId; // PK
    private String authorName;
    private String password;
    private String fullName;
    private Date creationTime;
    private Organization organization;
    private History history;

    @Override
    public String toString() {
        return "Author (" + authorId + ", " + authorName + ", " + fullName + ", " + creationTime + ")";
    }
    
    public Author() {
        // for hibernate
    }
    public Author(String name, String password, String fullName) {
        authorName = name;
        this.password = password;
        this.fullName = fullName;
        this.creationTime = new Date();
    }
    
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getAuthorId() {
        return authorId;
    }
    public void setAuthorId(long authorId) {
        this.authorId = authorId;
    }
    public String getAuthorName() {
        return authorName;
    }
    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getCreationTime() {
        return creationTime;
    }
    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    /**
     * @return the organization
     */
    public Organization getOrganization() {
        return organization;
    }

    /**
     * @param organization the organization to set
     */
    public void setOrganization(Organization organization) {
        this.organization = organization;
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