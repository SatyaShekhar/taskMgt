package com.sb.test.save;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class InlineEditTaskDetailsManager
 * 
 * @author satya60.shekhar@gmail.com
 */
@WebServlet(description = "this class is used to upate task manager", urlPatterns = { "/inlineEditTaskManager" })
public class InlineEditTaskDetailsManager extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InlineEditTaskDetailsManager() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 		String value = request.getParameter("value");
		System.out.println("InlineEditTaskDetailsManager.doGet()" + request.getParameterNames());
        System.out.println("Request saved successfullt after click ::: " + value);
        response.getWriter().write(value);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Enumeration<String> names = request.getParameterNames();
        System.out.println();
        while (names.hasMoreElements()) {
            String parameter = names.nextElement();
            System.out.println( parameter + " = " + request.getParameter(parameter));
        }
        String value = request.getParameter("value");
        System.out.println("Request saved successfullt after click ::: " + value);
        response.getWriter().write(value);
    }

}
