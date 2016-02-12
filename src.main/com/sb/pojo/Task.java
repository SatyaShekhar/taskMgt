package com.sb.pojo;

import java.util.Date;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class Task {
    private long taskId;
    private String name;
    private String description;
    private float taskEstimate;
    private float actual;
    private float remaining;
    private Date creationTime;
    private String comment;
    private byte priority;
    private Author author;
    private UserStory userStory;
    private byte status;
    private History history;
    
    public Task() {} // hibernate use only
    public Task(String name, String description) {
        this.name = name;
        this.description = description;
        this.creationTime = new Date();
    }
    
    @Override
    public String toString() {
        return "Task(" + name + ", " + description + ", User Story : " + userStory.getName() + ")";
    }

    public long getTaskId() {
        return taskId;
    }

    public void setTaskId(long taskId) {
        this.taskId = taskId;
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

    public float getTaskEstimate() {
        return taskEstimate;
    }
    public void setTaskEstimate(float taskEstimate) {
        this.taskEstimate = taskEstimate;
    }
    public float getActual() {
        return actual;
    }
    public void setActual(float actual) {
        this.actual = actual;
    }
    public float getRemaining() {
        return remaining;
    }
    public void setRemaining(float remaining) {
        this.remaining = remaining;
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

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public UserStory getUserStory() {
        return userStory;
    }

    public void setUserStory(UserStory userstory) {
        this.userStory = userstory;
    }
    public byte getStatus() {
        return status;
    }
    public void setStatus(byte status) {
        this.status = status;
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