/**
 * 
 */
package com.sb.sample.creation.helper;

import org.hibernate.Session;

import com.sb.constants.Priority;
import com.sb.db.helper.ConnectionProvider;
import com.sb.message.log.MessageLogger;
import com.sb.pojo.Author;
import com.sb.pojo.Iteration;
import com.sb.pojo.Project;
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
public class HelperClassForQuickCreate {

    /**
     * @param args
     */
    public static void main(String[] args) {
        Session session = ConnectionProvider.openSession();
        Author satya = crateAuthorsAndReturnOne_satya(session);
        // Create Projects
        Project projectTaskManagement = new Project(
                "Task Management",
                "This task manamement is completely reffered from rally I am using in VSM and need many improvements in this .. for now the purpose is only to estimate and check for the progress we are doing w.r.t our self developent and it need further improvement");
        projectTaskManagement.setAuthor(satya);
        session.save(projectTaskManagement);
        Project projectTutorial = new Project("Tutorial", "Site Mainly Dedicated to Question answer, tutorail, semister projects");
        projectTutorial.setAuthor(satya);
        session.save(projectTutorial);
        Project projectConsultancy = new Project("Consultancy",
                "Providing consultancy to Comapny and Job Seekers two way process and project sessions");
        projectConsultancy.setAuthor(satya);
        session.save(projectConsultancy);
        // Create Iterations
        Iteration iterationOne = new Iteration("Iteration (17 Mar - 23 Mar)", "Step one major planning and fianlize in one week");
        Iteration iterationTwo = new Iteration("Iteration (24 Mar - 30 Mar)", "Second iteration ");
        Iteration iterationThree = new Iteration("Iteration (31 Mar - 07 APR)", "Third iteration ");
        iterationOne.setAuthor(satya);
        iterationTwo.setAuthor(satya);
        iterationThree.setAuthor(satya);
        iterationOne.setProject(projectConsultancy);
        iterationTwo.setProject(projectConsultancy);
        iterationThree.setProject(projectConsultancy);
        session.save(iterationOne);
        session.save(iterationTwo);
        session.save(iterationThree);

        UserStory story1 = new UserStory("Web site with functionality (Rough design)", "Finalizing the funtionality working");
        story1.setAuthor(satya);
        story1.setIteration(iterationOne);
        story1.setPlanEstimate(3);
        UserStory story2 = new UserStory("User interface with design including template", "Finalize GUI");
        story2.setAuthor(satya);
        story2.setIteration(iterationOne);
        story2.setPlanEstimate(3);
        UserStory story3 = new UserStory("Presentation for Univerity", "Presentaion topics (Subject, offers, planns)");
        story3.setAuthor(satya);
        story3.setIteration(iterationOne);
        story3.setPlanEstimate(6);
        session.save(story1);
        session.save(story2);
        session.save(story3);
        for (int i = 0; i < 10; i++) {
            UserStory story = new UserStory("User Story " + i, "Mock user story description");
            story.setAuthor(satya);
            story.setIteration(iterationTwo);
            story.setPriority((byte) ((i % 3 == 0) ? Priority.High.getValue() : Priority.Midium.getValue()));
            session.save(story);
        }

        // Display
        for (Object author : session.createQuery("from Author").list()) {
            MessageLogger.info(author.toString(), HelperClassForQuickCreate.class);
        }
        for (Object author : session.createQuery("from Project").list()) {
            MessageLogger.info(author.toString(), HelperClassForQuickCreate.class);
        }
        for (Object author : session.createQuery("from Iteration").list()) {
            MessageLogger.info(author.toString(), HelperClassForQuickCreate.class);
        }
        for (Object author : session.createQuery("from UserStory").list()) {
            MessageLogger.info(author.toString(), HelperClassForQuickCreate.class);
        }

        ConnectionProvider.closeSessionAndDissconnect(session);
        session.getSessionFactory().close();

    }

    private static Author crateAuthorsAndReturnOne_satya(Session session) {

        String authorName = "Satyabrata";
        Author author;
        if (session.createQuery("from Author where authorName = '" + authorName + "'").list().size() == 0) {
            author = new Author(authorName, authorName, authorName);
            session.save(author);
        }

        authorName = "Debasmita";
        if (session.createQuery("from Author where authorName = '" + authorName + "'").list().size() == 0) {
            author = new Author(authorName, authorName, authorName);
            session.save(author);
        }
        authorName = "Madhusmita";
        if (session.createQuery("from Author where authorName = '" + authorName + "'").list().size() == 0) {
            author = new Author(authorName, authorName, authorName);
            session.save(author);
        }
        authorName = "Satya";
        if (session.createQuery("from Author where authorName = '" + authorName + "'").list().size() == 0) {
            author = new Author(authorName, authorName, authorName);
            session.save(author);
        } else {
            author = (Author) session.createQuery("from Author where authorName = '" + authorName + "'").list().get(0);
        }
        return author;
    }

}
