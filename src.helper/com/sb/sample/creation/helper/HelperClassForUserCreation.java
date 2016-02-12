package com.sb.sample.creation.helper;

import java.util.TreeSet;

import org.hibernate.Query;
import org.hibernate.Session;

import com.sb.db.helper.ConnectionProvider;
import com.sb.message.log.MessageLogger;
import com.sb.pojo.Author;
import com.sb.pojo.History;
import com.sb.pojo.Organization;
import com.sb.pojo.PastInformation;

/**
 * Helper to create multiple users with organization
 * 
 * @author satya60.shekhar@gmail.com
 */
public class HelperClassForUserCreation {
    private MessageLogger logger = new MessageLogger(getClass());
    
    public static void main(String[] args) {
        HelperClassForUserCreation creator = new HelperClassForUserCreation();
        creator.createOrganizationAuthorAndIteration();
        Session session = ConnectionProvider.openSession();

      /*  Query iterations = session.createQuery("from Iteration where name='Unscheduled'");
        
        
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
            Task task = new Task("Sample Task" + i, "Sample Description");
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
            session.save(bug);
            System.out.println(">>>>>>>>> Successful creation of Story " + story);
        }*/
        // Populate One US with Task and Bugs
        
        ConnectionProvider.closeSessionAndDissconnect(session);
        session.getSessionFactory().close();
    }

    /**
     * STEP 1 : Create organizations : 1. Task Manager, 2. Space Crafter, 3. My Blogger
     * STEP 2 : Create USER : 
     *              1. Satya (TM), Debasmita (TM), Sanjiv (TM)
     *              2. Satya (SC), Debasmita (SC), Sanjiv (SC)
     *              3. Satya (MB), Debasmita (MB), Sanjiv (MB)
     * STEP 3 : ?
     * STEP 4 : ?
     */
    public void createOrganizationAuthorAndIteration() {
        Session session = ConnectionProvider.openSession();
        // STEP 1 : Create organization : OpenSource@Satya
        Organization organizationTaskManager = createOrganization(session, "Task Manager");
        Organization organizationSpaceCrafter = createOrganization(session, "Space Crafter");
        Organization organizationMyBlogger = createOrganization(session, "My Blogger");
        // STEP 2.1 : Create USER : 1. Satya (TM), Debasmita (TM), Sanjiv (TM)
        createAuthor(session, "Satya (TM)", organizationTaskManager);
        createAuthor(session, "Debasmita (TM)", organizationTaskManager);
        createAuthor(session, "Sanjiv (TM)", organizationTaskManager);
        // STEP 2.2 : Create USER : 2. Satya (SC), Debasmita (SC), Sanjiv (SC)
        createAuthor(session, "Satya (SC)", organizationSpaceCrafter);
        createAuthor(session, "Debasmita (SC)", organizationSpaceCrafter);
        createAuthor(session, "Sanjiv (SC)", organizationSpaceCrafter);
        // STEP 2.3 : Create USER : 3. Satya (MB), Debasmita (MB), Sanjiv (MB)
        createAuthor(session, "Satya (MB)", organizationMyBlogger);
        createAuthor(session, "Debasmita (MB)", organizationMyBlogger);
        createAuthor(session, "Sanjiv (MB)", organizationMyBlogger);
        
        /*// STEP 2 : Create USER : satya/satya/Satya Shekhar Barik
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
        session.save(iteration);*/
        ConnectionProvider.closeSessionAndDissconnect(session);

        System.out.println("Everything completed successfully");
    }

    private Author createAuthor(Session session, String name, Organization organization) {
        Query authors = session.createQuery("from Author where authorName='" + name + "'");
        Author author;
        if (authors.list().isEmpty()) {
            String fullName = name + " Full Name";
            if (name.startsWith("Satya")) {
                fullName = "Shekhar Shekhar Barik";
            }
            author = new Author(name, "password@12345", fullName);
            session.save(author);
            author.setOrganization(organization);
            logger.info("Author created with name: " + author.getAuthorName());
        } else {
            author = (Author) authors.list().get(0);
            logger.info("Author already created with name " + author.getAuthorName());
        }
        return author;
    }

    private Organization createOrganization(Session session, String name) {
        Query organizations = session.createQuery("from Organization where name='"+ name +"'");
        Organization organization;
        if (organizations.list().isEmpty()) {
            organization = new Organization();
            History history = new History();
            history.setInformations(new TreeSet<PastInformation>());
            organization.setHistory(history);
            organization.setName(name);
            session.save(history);
            session.save(organization);
            logger.info("Organization created with name: " + organization.getName());
        } else {
            organization = (Organization) organizations.list().get(0);
            logger.info("Organizations already created " + organization);
        }
        return organization;
    }
}
