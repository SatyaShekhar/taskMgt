package com.sb.pojo;

import java.util.Date;

/**
 * TODO add java doc on the equals and hascode as its dependent to our project implementation
 * 
 * @author sbarik
 *
 */
public class Iteration {
    private long iterationId;
    private String name;
    private String description;
    private Date startDate;
    private Date endDate;
    private Date creationTime;
    private Author author;
    private Project project;
    private History history;
    
    public Iteration() {}
    public Iteration(String name, String description) {
       this.name = name;
       this.description = description;
       this.creationTime = new Date();
    }
    @Override
    public String toString() {
        return "Iteration(" + ", " + iterationId + ", " + name + ", " + description + ", " + author.getAuthorName() + project.getProjectName()+ ")";
    }
    
    
   
    public long getIterationId() {
        return iterationId;
    }
    public void setIterationId(long iterationId) {
        this.iterationId = iterationId;
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
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public Date getCreationTime() {
        return creationTime;
    }
    public void setCreationTime(Date creationTime) {
        this.creationTime = creationTime;
    }
    public Author getAuthor() {
        return author;
    }
    public void setAuthor(Author author) {
        this.author = author;
    }
    
    public Project getProject() {
        return project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + ((project == null) ? 0 : project.hashCode());
        return result;
    }
    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Iteration other = (Iteration) obj;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (project == null) {
            if (other.project != null)
                return false;
        } else if (!project.equals(other.project))
            return false;
        return true;
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
