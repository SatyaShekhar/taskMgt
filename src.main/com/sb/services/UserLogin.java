package com.sb.services;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sb.constants.PropertyNames;
import com.sb.db.helper.HibernateQueryHelper;
import com.sb.pojo.Author;


/**
 * Servlet implementation class UserLogin
 * 
 * @author satya60.shekhar@gmail.com
 */
@WebServlet("/userLogin")
public class UserLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogin() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // no implementation required
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter(PropertyNames.USER_NAME);
        String password = request.getParameter(PropertyNames.PASSWORD);
        HttpSession session = request.getSession(true);
        Author user = HibernateQueryHelper.isValidUser(userName, password);
        if(user != null) {
            session.setAttribute(PropertyNames.USER, user);
            response.sendRedirect("MyAccount.jsp");
            return;
        } else {
            session.setAttribute(PropertyNames.INVALID_USER_ERROR_MESSAGE, "UsrName or password is invalid");
            response.sendRedirect("index.jsp");
            return;
        }
    }

}
