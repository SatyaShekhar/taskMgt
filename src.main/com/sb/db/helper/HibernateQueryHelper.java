package com.sb.db.helper;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.sb.pojo.Author;
import com.sb.pojo.Iteration;

/**
 * TODO : check and remove if not applicable
 * 
 * @author satya60.shekhar@gmail.com
 * 
 */
@Deprecated
public class HibernateQueryHelper {

    public static Author isValidUser(String user, String password) {
        Author author = getAuthor(user);
        if (author == null) {
            return null;
        }
        if (!author.getPassword().equals(password)) {
            return null;
        }
        return author;
    }

    public static Author getAuthor(String userName) {
        Session session = ConnectionProvider.openSession();
        // TODO why not to filter user by comparing the password as well
        Query query = session.createQuery("from Author where authorName ='"
                + userName + "'");
        if (query.list().isEmpty()) {

            ConnectionProvider.closeSessionAndDissconnect(session);
            return null;
        }
        Author author = (Author) query.list().get(0);
        ConnectionProvider.closeSessionAndDissconnect(session);
        return author;
    }

    public static void saveWithOpeningAndClosingSession(Object object) {
        Session session = ConnectionProvider.openSession();
        session.save(object);
        ConnectionProvider.closeSessionAndDissconnect(session);
        System.out.println("QuestionComment successfully saved");
    }

    public static List<String> getIterationNames(String projectName) {
        Session session = ConnectionProvider.openSession();
        List<String> list = new ArrayList<>();
        String queryStr = "from Iteration where project.projectName = '" + projectName + "'";
        for(Object obj : session.createQuery(queryStr).list()) {
            Iteration iteration = (Iteration) obj;
            list.add(iteration.getName());
        }
        ConnectionProvider.closeSessionAndDissconnect(session);
        System.out.println("QuestionComment successfully saved");
        return list;
    }

   

}
