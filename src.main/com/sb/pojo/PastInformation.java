package com.sb.pojo;

import java.util.Date;

public class PastInformation implements Comparable<PastInformation> {
    private long infoId;
    private Date whenCreated;
    private String changeMessage;
    private Author updatedBy;

    PastInformation() {
        // Prefer for persistence only
    }

    public PastInformation(String changeMessage, Author author) {
        this.changeMessage = changeMessage;
        this.updatedBy = author;
        whenCreated = new Date();
    }

    @Override
    public int compareTo(PastInformation o) {
        return -1 * this.whenCreated.compareTo(o.whenCreated);
    }

    /**
     * @return the infoId
     */
    public long getInfoId() {
        return infoId;
    }

    /**
     * @param infoId the infoId to set
     */
    public void setInfoId(long infoId) {
        this.infoId = infoId;
    }

    /**
     * @return the changeMessage
     */
    public String getChangeMessage() {
        return changeMessage;
    }

    /**
     * @param changeMessage the changeMessage to set
     */
    public void setChangeMessage(String changeMessage) {
        this.changeMessage = changeMessage;
    }

    /**
     * @return the updatedBy
     */
    public Author getUpdatedBy() {
        return updatedBy;
    }

    /**
     * @param updatedBy the updatedBy to set
     */
    public void setUpdatedBy(Author updatedBy) {
        this.updatedBy = updatedBy;
    }

    /**
     * @return the whenCreated
     */
    public Date getWhenCreated() {
        return whenCreated;
    }

    /**
     * @param whenCreated the whenCreated to set
     */
    public void setWhenCreated(Date whenCreated) {
        this.whenCreated = whenCreated;
    }
    
    
}
