/**
 * 
 */
package com.sb.sample.creation.helper;

import org.hibernate.Session;

import com.sb.constants.Priority;
import com.sb.constants.Severity;
import com.sb.constants.Status;
import com.sb.db.helper.ConnectionProvider;
import com.sb.pojo.Author;
import com.sb.pojo.Bug;
import com.sb.pojo.Task;
import com.sb.pojo.UserStory;

/**
 * Note :
 * This helper class will be used as a backup of all task i am going to create now till the basic flow of db is not clear. So over all
 * creation and populating initial user story and tasks will be done here and in future once this product is stable and having its own life
 * cycle this class will be depricated till then it will be the key
 * 
 * @author sbarik
 * 
 */
public class HelperClassForTaskAndBug {

    /**
     * @param args
     */
    public static void main(String[] args) {
        //main1();
        Session session = ConnectionProvider.openSession();

        UserStory story2 = (UserStory) session.load(UserStory.class, 2);
        Author author = (Author) session.load(Author.class, 2l);
        
        Task task1 = new Task("Task 1 : Sample ", "Task Description");
        task1.setActual(1);
        task1.setAuthor(author);
        task1.setPriority((byte) Priority.High.getValue());
        task1.setRemaining(2);
        task1.setTaskEstimate(5);
        task1.setUserStory(story2);
        session.save(task1);
        
        Task task2 = new Task("Task 1 : Sample ", "Task Description");
        task2.setActual(1);
        task2.setAuthor(author);
        task2.setPriority((byte) Priority.High.getValue());
        task2.setRemaining(2);
        task2.setTaskEstimate(5);
        task2.setUserStory(story2);
        session.save(task2);
        
        Bug bug = new Bug("Bug 1", "Bug desc 1");
        bug.setComment("This is a bug comment");
        bug.setCreatedBy(author);
        bug.setEngineer(author);
        bug.setPriority((byte) Priority.High.getValue());
        bug.setSeverity((byte) Severity.Modorate.getValue());
        bug.setStatus((byte) Status.Assigned.getValue());
        bug.setUserStory(story2);
        session.save(bug);
        
        ConnectionProvider.closeSessionAndDissconnect(session);
        session.getSessionFactory().close();
    }
}
