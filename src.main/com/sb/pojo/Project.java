package com.sb.pojo;

import java.util.Date;

/**
 * Cloneable is implemented for project object where ever it is called it should be either in a transaction or a object in egar fetched one
 * 
 * @author sbarik
 *
 */
public class Project implements Cloneable {
    private long projectId;
    private String projectName;
    private String projectDescription;
    private Date creationDate;
    private Author author;
    private History history;
    
    public Project() { /* For Hibernate */ }
    
    public Project(String name, String description) {
        this.projectName = name;
        this.projectDescription = description;
        this.creationDate = new Date();
    }
    
    @Override
    public String toString() {
        return "Project(" + projectId + ", " + projectName + ", " + projectDescription + ", " + author.getAuthorName() + ", " + creationDate ;
    }

    public long getProjectId() {
        return projectId;
    }

    public void setProjectId(long projectId) {
        this.projectId = projectId;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getProjectDescription() {
        return projectDescription;
    }

    public void setProjectDescription(String projectDescription) {
        this.projectDescription = projectDescription;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Author getAuthor() {
        return author;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((projectName == null) ? 0 : projectName.hashCode());
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
        Project other = (Project) obj;
        if (projectName == null) {
            if (other.projectName != null)
                return false;
        } else if (!projectName.equals(other.projectName))
            return false;
        return true;
    }
    
    /**
     * Warning : Cloneable is implemented for project object where ever it is called it should be either in a transaction or a object in egar fetched one
     * 
     * 1. It will copy all attributes other then the projectId (used as primary key)
     * 2. Creation date will be modified as per current system date and time
     * 
     */
    @Override
    public Object clone() throws CloneNotSupportedException {
        Project project = new Project(this.projectName, this.projectDescription);
        project.creationDate = new Date();
        project.author = this.author;
        // TODO - Bidirectionla mapping is required to keep iterations and same it required for all other child implementation to clone
        return project;
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
