package com.sb.pojo;

import java.util.Date;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class Bug {
    private long bugId;
    private String name;
    private String description;
    private byte status;
    private byte priority;
    private byte severity;
    private Date creationTime;
    private String comment;
    private float estimate;
    private float actual;
    private float remaining;
    private Author engineer;
    private Author createdBy;
    private UserStory userStory;
    private History history;
    
    public Bug() {
        // For Hibernate
    }
    
    public Bug(String name, String description) {
        this.name = name;
        this.description = description;
        this.creationTime = new Date();
    }
    
    @Override
    public String toString() {
        return "Bug(" + name + ", " + description + ", " + createdBy.getAuthorName() + ", " + severity;
    }

    public long getBugId() {
        return bugId;
    }

    public void setBugId(long bugId) {
        this.bugId = bugId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public Date getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public byte getPriority() {
        return priority;
    }

    public void setPriority(byte priority) {
        this.priority = priority;
    }

    public byte getSeverity() {
        return severity;
    }

    public void setSeverity(byte severity) {
        this.severity = severity;
    }

    public Author getEngineer() {
        return engineer;
    }

    public void setEngineer(Author engineer) {
        this.engineer = engineer;
    }

    public Author getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Author createdBy) {
        this.createdBy = createdBy;
    }

    public UserStory getUserStory() {
        return userStory;
    }

    public void setUserStory(UserStory userStory) {
        this.userStory = userStory;
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

    /**
     * @return the estimate
     */
    public float getEstimate() {
        return estimate;
    }

    /**
     * @param estimate the taskEstimate to set
     */
    public void setEstimate(float estimate) {
        this.estimate = estimate;
    }

    /**
     * @return the actual
     */
    public float getActual() {
        return actual;
    }

    /**
     * @param actual the actual to set
     */
    public void setActual(float actual) {
        this.actual = actual;
    }

    /**
     * @return the remaining
     */
    public float getRemaining() {
        return remaining;
    }

    /**
     * @param remaining the remaining to set
     */
    public void setRemaining(float remaining) {
        this.remaining = remaining;
    }
    
}