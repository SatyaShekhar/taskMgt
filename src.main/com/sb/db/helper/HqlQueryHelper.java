package com.sb.db.helper;

import java.util.List;

import org.hibernate.Session;

import com.sb.pojo.Author;
import com.sb.pojo.Bug;
import com.sb.pojo.Iteration;
import com.sb.pojo.Project;
import com.sb.pojo.Task;
import com.sb.pojo.UserStory;

/**
 * Hibernate query helper static query provider from hibernate generic type to Java typed type
 * 
 * @author satya60.shekhar@gmail.com
 * 
 * TODO adopt all method java doc as required
 *
 */
public class HqlQueryHelper {

    /**
     * 
     * @param session
     *            currently open session instance
     * @param userstoryId
     *            user story ID
     * @return task present under the US, never null
     */
    public static List<Task> getTasksUnderUserStory(Session session, long userstoryId) {
        if (!session.isOpen()) {
            throw new IllegalStateException("This method should be called under a open hibernate session");
        }
        return session.createQuery("from Task where userStory.userstoryId = '" + userstoryId + "'").list();
    }
    
    /**
     * 
     * @param session
     *            currently open session instance
     * @param userstoryId
     *            user story ID
     * @return bugs present under the US, never null
     */
    public static List<Bug> getBugsUnderUserStory(Session session, long userstoryId) {
        if (!session.isOpen()) {
            throw new IllegalStateException("This method should be called under a open hibernate session");
        }
        return session.createQuery("from Bug where userStory.userstoryId = '" + userstoryId + "'").list();
    }

    /**
     * 
     * @param session
     *            currently open session instance
     * @param projectId
     *            project id
     * @return iterations
     */
    public static List<Iteration> getIterationsUnderProject(Session session, long projectId) {
        return session.createQuery("from Iteration where project.projectId = '" + projectId + "'").list();
    }

    /**
     * {@link Deprecated} as this is a bug after the introduction of the organization above an author
     * It should be replaced by {@link #getAuthors(Session, long)}
     * 
     * <br>NOTE : should be removed by the final release/commit
     * 
     * @param session
     * @return
     */
    @Deprecated
    public static List<Author> getAuthors(Session session) {
        return session.createQuery("from Author").list();
    }

    /**
     * 
     * @param session
     *            currently open session instance
     * @param organizationId
     *            organization id
     * @return All authors working under same organization
     */
    public static List<Author> getAuthors(Session session, long organizationId) {
        return session.createQuery("from Author where organization.id = '" + organizationId + "'").list();
    }

    public static List<Project> getProjects(Session session, long organizationId) {
        return session.createQuery("from Project where organization.id ='"+ organizationId +"'").list();
    }
    
    public static List<UserStory> getUserStorys(Session session, long iterationId) {
        return session.createQuery("from UserStory where iteration.iterationId ='"+ iterationId +"'").list();
    }
}
