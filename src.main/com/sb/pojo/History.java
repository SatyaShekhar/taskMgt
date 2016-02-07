package com.sb.pojo;

import java.util.Set;
import java.util.TreeSet;

public class History {
    private long historyId;
    private Set<PastInformation> informations;
    
    public History() {
    }
    /**
     * @return the historyId
     */
    public long getHistoryId() {
        return historyId;
    }
    /**
     * @param historyId the historyId to set
     */
    public void setHistoryId(long historyId) {
        this.historyId = historyId;
    }

    /**
     * @return the informations
     */
    public Set<PastInformation> getInformations() {
        Set<PastInformation> infos = new TreeSet<>();
        infos.addAll(informations);
        return infos;
    }
    /**
     * @param informations the informations to set
     */
    public void setInformations(Set<PastInformation> informations) {
        this.informations = informations;
    }
    public void addInfo(PastInformation info) {
        if (informations == null) {
            informations = new TreeSet<>();
        }
        informations.add(info);
    }
}
