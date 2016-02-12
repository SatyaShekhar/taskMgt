package com.sb.helper;

import java.util.List;

import org.hibernate.Session;

import com.sb.constants.ProgressStatus;
import com.sb.db.helper.HqlQueryHelper;
import com.sb.pojo.Task;
import com.sb.pojo.UserStory;

/**
 * 
 * @author satya60.shekhar@gmail.com
 *
 */
public class UserStoryStatusHelper {

    /**
     * Warning : This method should be called under a open hibernate session other wise it will not get the proxy and will fail to retrieve the details
     * 
     * @param tasks
     * @param session
     * @return
     */
    public float getTotalTodo(List<Task> tasks, Session session) {
        if (!session.isOpen()) {
            throw new IllegalStateException("This method should be called under a open hibernate transaction");
        }
        float totalTodo = 0;
        for(Task task : tasks) {
            totalTodo += task.getRemaining();
        }
        return totalTodo;
    }
    
    /**
     * Warning : This method should be called under a open hibernate session other wise it will not get the proxy and will fail to retrieve the details
     * 
     * @param tasks
     * @param session
     * @return
     */
    public float getTotalActuals(List<Task> tasks, Session session) {
        if (!session.isOpen()) {
            throw new IllegalStateException("This method should be called under a open hibernate transaction");
        }
        float totalActuals = 0;
        for(Task task : tasks) {
            totalActuals += task.getActual();
        }
        return totalActuals;
    }
    
    
    /**
     * Warning : This method should be called under a open hibernate session other wise it will not get the proxy and will fail to retrieve the details
     * 
     * @param tasks
     * @param session
     * @return
     */
    public float getTotalEstimate(List<Task> tasks, Session session) {
        if (!session.isOpen()) {
            throw new IllegalStateException("This method should be called under a open hibernate transaction");
        }
        float totalEstimate = 0;
        for(Task task : tasks) {
            totalEstimate += task.getTaskEstimate();
        }
        return totalEstimate;
    }
    
    
    /**
     * Warning : This method should be called under a open hibernate session other wise it will not get the proxy and will fail to retrieve the details
     * 
     * @param session should not be null and should be opened
     * @param userStory
     * @return
     */
    public ProgressStatus getProgressStatus(Session session, UserStory userStory) {
        boolean complete = false;
        boolean accept = false;
        boolean define = false;
        List<Task> tasks = HqlQueryHelper.getTasksUnderUserStory(session, userStory.getUserstoryId());
        if(tasks.isEmpty()) {
            return ProgressStatus.Defined;
        }
        for (Task task : tasks) {
            ProgressStatus status = ProgressStatus.valueOf(task.getStatus());
            switch (status) {
            case Accepted:
                accept = true;
                break;
            case Complete:
                complete = true;
                break;
            case Defined:
                define = true;
                break;
            case Progress:
                return status;
            default:
                throw new IllegalStateException("Any other mode is not supported by this method yet");
            }
        }
        
        if (define && (!accept) && (!complete)) {
            return ProgressStatus.Defined;
        } else if ((!define) && accept && (!complete)) {
            return ProgressStatus.Accepted;
        }  else if ((!define) && (!accept) && complete) {
            return ProgressStatus.Complete;
        } 
        return ProgressStatus.Progress;
    }
}
