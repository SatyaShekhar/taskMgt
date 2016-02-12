package com.sb.pojo;

import java.util.Date;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class UserStory implements Comparable<UserStory> {
    private long userstoryId;
    private String name;
    private String description;
    private float planEstimate;
    private Date creationTime;
    private String comment;
    private Author author;
    private Iteration iteration;
    private byte priority;
    private History history;
    
    public UserStory() { }
    public UserStory(String name, String description) { this.name = name; this.description = description; }
    
    @Override
    public String toString() {
        return "UserStory(" + userstoryId + ", " + name + ", " + description + ", " + planEstimate + ", " + iteration.getName() + ", " + author.getAuthorName();
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((iteration == null) ? 0 : iteration.hashCode());
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        return result;
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        UserStory other = (UserStory) obj;
        if (iteration == null) {
            if (other.iteration != null)
                return false;
        } else if (!iteration.equals(other.iteration))
            return false;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        return true;
    }
    public long getUserstoryId() {
        return userstoryId;
    }
    public void setUserstoryId(long userstoryId) {
        this.userstoryId = userstoryId;
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
    public float getPlanEstimate() {
        return planEstimate;
    }
    public void setPlanEstimate(float planEstimate) {
        this.planEstimate = planEstimate;
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
    public Author getAuthor() {
        return author;
    }
    public void setAuthor(Author author) {
        this.author = author;
    }
    public Iteration getIteration() {
        return iteration;
    }
    public void setIteration(Iteration iteration) {
        this.iteration = iteration;
    }
    public byte getPriority() {
        return priority;
    }
    public void setPriority(byte priority) {
        this.priority = priority;
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
    public int compareTo(UserStory otherUS) {
        // TODO committed temporaryly return Byte.valueOf(priority).compareTo(otherUS.priority);
        return Long.valueOf(getUserstoryId()).compareTo(otherUS.getUserstoryId());
    }    

}
