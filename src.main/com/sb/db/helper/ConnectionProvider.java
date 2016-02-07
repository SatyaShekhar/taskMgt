package com.sb.db.helper;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.sb.message.log.MessageLogger;

/**
 * Connection provider helper class
 * 
 * @author sbarik
 * 
 */
public class ConnectionProvider {
    private static MessageLogger logger = new MessageLogger(ConnectionProvider.class);

    private static SessionFactory factory = getSessionFactory();
    
    /**
     * Create an session factory from hibernate.config.xml and opens a session returns
     * 
     * @return
     */
    public static Session openSession() {
        Session session = getSessionFactory().openSession();
        session.beginTransaction();
        return session;
    }

    private static SessionFactory getSessionFactory() {
        if (factory != null) {
            logger.info("Session factory already exists reuse it");
            return factory;
        }
        logger.info("Session factory created for the first time");
        Configuration configuration = new Configuration().configure("hibernate.config.xml");
        SessionFactory factory = configuration.buildSessionFactory();
        return factory;
    }

    /**
     * Closes the session and associated session factory
     * 
     * @param session
     */
    public static void closeSessionAndDissconnect(Session session) {
        session.getTransaction().commit();
        session.close();
        logger.info("Transaction comited and session is closed.");
    }
}
