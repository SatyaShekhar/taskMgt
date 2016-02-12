/**
 * 
 */
package com.sb.sample.creation.helper;

import java.util.Date;

import org.hibernate.Query;
import org.hibernate.Session;

import com.sb.constants.Priority;
import com.sb.db.helper.ConnectionProvider;
import com.sb.pojo.Author;
import com.sb.pojo.Iteration;
import com.sb.pojo.Organization;
import com.sb.pojo.Project;
import com.sb.pojo.UserStory;

/**
 * Note :
 * This helper class will be used as a backup of all task i am going to create now till the basic flow of db is not clear. So over all
 * creation and populating initial user story and tasks will be done here and in future once this product is stable and having its own life
 * cycle this class will be deprecated till then it will be the key <br><br>
 * 
 * {@link Deprecated} as it its creating some entry which can not be reverted due to inconsistent DB population
 * 
 * @author sbarik
 * 
 */
@Deprecated
public class HelperClassForSampleDB {

    /**
     * @param args
     */
    public static void main(String[] args) {
        createOrganizationAuthorAndIteration();
        Session session = ConnectionProvider.openSession();

        Query iterations = session.createQuery("from Iteration where name='Unscheduled'");
        
        
        Iteration iteration = (Iteration) iterations.list().get(0);
       
        String [][] userStories =  {
                { "Log message geneation and saving in a separate log file", "log formate desc" },
                { "Formating of all modules per project (resuable components)", "log formate desc" },
                { "Hibernate mapping like task : Connection Pooling for hibernate and bi directional mapping call optimization", "log formate desc" }, 
                { "Hibernate adoption for annotations", "log formate desc" },
                { "Unit testing (JUnit) for business logic + hibernate testing", "log formate desc" },
                { "Unit Testing for JSP", "Desc"},
                { "Performance Testing", "Desc"},
                { "Tutorial Home page", "Desc"},
                { "Tutorial Sub page", "Desc"},
                { "Question entry page", "Desc"},
                { "Question entry edit and update", "Desc"},
                { "Maintaining the history of activities for all actions (by User, Project, Task, Iteration)", "User Story is for Task management module"},
                { "Overall report using some analyisis from previous task completed/inprogress", "Desc"},
                { "<b>Change log management for data base changes and incremental DB update</b>", "Desc"},
                { "<b>Upgrade, Backup and restore of data base from old database</b>", "Desc"},
                { "Finding of all topics and Question entry (50 per each topic)", "1. One use story can contain 10 tasks (i.e. 10 Task x 5 Question/Task x 3 Topics" +
                		"2. List down all topics, 3. Testing of each question readbility and speelling, formating"},
                { "Error management for all pages in Web application and logging in separate log file", "Desc"},
                { "Hosting of Website and finalization of steps", "Desc"},
                { "Google optimization in HTML file header for search topics", "Desc"},
                { "Blog entry and related questions to Q&A site", "Desc"},
                { "Interview question Topic separation and entry 20 questions per each topic", "Desc"},
                { "Performacne optimization of page and Enhance GUI implementation", "Desc"},
                { "Test matrix preparation and standadization of best practices in project with Task/Role separation", "Desc"},
                { "Separation of different modules and high level user stories and iterration separation", "Desc"},
                { "Standardizing the documentation for better maintanability", "Desc"},
                { "Increasing the Visitors for website and adverising in our and for our website", "Desc"},
                { "Learning of new topics and adding them to blog with analysis", "Desc"},
                { "Devleopment template preparation and knowledge sharing", "Desc"},
                { "Java Script validation of all pages", "Desc"},
                { "Better scripting and use of JQuert for enhanced GUI like calender", "Desc"}, 
                { "Separate schema mgt for each project", "Desc"}, 
                { "Pagination  (numbers of record per page)", "Desc"}, 
            
        };
        for (int i = 0; i < userStories.length; i++) {
            Query query = session.createQuery("from UserStory where name = '" + userStories[i][0] + "'");
            if (!query.list().isEmpty()) {
                System.out.println("+++++++++++ Already added " + query.list().get(0));
                continue;
            }
            UserStory story = new UserStory(userStories[i][0], userStories[i][1]);
            story.setAuthor(iteration.getAuthor());
            story.setCreationTime(new Date());
            story.setIteration(iteration);
            story.setPlanEstimate(3);
            story.setPriority((byte) Priority.High.getValue());
            session.save(story);
            // Create Task under each user story
            /*Task task = new Task("Sample Task" + i, "Sample Description");
            task.setAuthor(iteration.getAuthor());
            task.setUserStory(story);
            session.save(task);
            
            Bug bug = new Bug("Bug" + i, "Sample Bug Description");
            bug.setUserStory(story);
            
            PastInformation info = new PastInformation("first change", iteration.getAuthor());
            
            History history = new History();
            history.addInfo(info);
            bug.setHistory(history);
            bug.setUserStory(story);
            
            session.save(info);
            session.save(history);
            session.save(bug);*/
            System.out.println(">>>>>>>>> Successful creation of Story " + story);
        }
        // Populate One US with Task and Bugs
        
        ConnectionProvider.closeSessionAndDissconnect(session);
        session.getSessionFactory().close();
    }

    /**
     * STEP 1 : Create organization : OpenSource@Satya
     * STEP 2 : Create USER : satya/satya/Satya Shekhar Barik
     * STEP 3 : Create Project : Common Features
     * STEP 4 : Create Iteration : Unscheduled
     */
    public static void createOrganizationAuthorAndIteration() {
        Session session = ConnectionProvider.openSession();
        // STEP 1 : Create organization : OpenSource@Satya
        Query organizations = session.createQuery("from Organization where name='OpenSource@Satya'");
        Organization organization;
        if (organizations.list().isEmpty()) {
            organization = new Organization();
            organization.setName("OpenSource@Satya");
            session.save(organization);
        } else {
            organization = (Organization) organizations.list().get(0);
        }
        
        // STEP 2 : Create USER : satya/satya/Satya Shekhar Barik
        Query authors = session.createQuery("from Author where authorName='satya'");
        Author satya;
        if (authors.list().isEmpty()) {
            satya = new Author("satya", "satya", "Satya Shekhar Barik");
            session.save(satya);
        } else {
            satya = (Author) authors.list().get(0);
        }
        satya.setOrganization(organization);
        // STEP 3 : Create Project : Common Features
        Project project = new Project("Common Features", "This project represents all common tasks accross all projects");
        project.setAuthor(satya);
        session.save(project);
        // STEP 4 : Create Iteration : Unscheduled
        Iteration iteration = new Iteration("Unscheduled", "All un scheduled Items");
        iteration.setAuthor(satya);
        iteration.setStartDate(new Date(0));
        iteration.setEndDate(new Date(0));
        iteration.setProject(project);
        session.save(iteration);
        ConnectionProvider.closeSessionAndDissconnect(session);

        System.out.println("Everything completed successfully");
    }
}
