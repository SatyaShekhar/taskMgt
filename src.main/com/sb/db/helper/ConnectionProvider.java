package com.sb.db.helper;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;

import com.sb.message.log.MessageLogger;

/**
 * Connection provider helper class
 * 
 * @author satya60.shekhar@gmail.com
 * 
 */
public class ConnectionProvider {
    private static MessageLogger logger = new MessageLogger(ConnectionProvider.class);

    private static SessionFactory factory = getSessionFactory();
    private static ServiceRegistry serviceRegistry;
    
    /**
     * Create an session factory from hibernate.config.xml and returns an open session (it also begins the transaction)
     * 
     * @return {@link Session} instance 
     */
    public static Session openSession() {
        Session session = getSessionFactory().openSession();
        session.beginTransaction();
        return session;
    }

    private static SessionFactory getSessionFactory() {
        if (factory != null) {
            logger.info("Great session factory already present");
            return factory;
        }
        logger.info("Session factory created for the first time");
        Configuration configuration = new Configuration().configure("hibernate.config.xml");
        serviceRegistry = new StandardServiceRegistryBuilder().applySettings(configuration.getProperties()).build();
        return configuration.buildSessionFactory(serviceRegistry);
    }

    /**
     * Closes the session and associated session factory. <br> Also commits the transaction before closing the session
     * 
     * @param session should not be null
     */
    public static void closeSessionAndDissconnect(Session session) {
        session.getTransaction().commit();
        session.close();
        logger.info("Transaction comitted and session is closed.");
    }
}
