package com.sb.test.save;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestSaveEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Request saved successfullt after click");
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Request saved successfullt after click");
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Thread.sleep(1000 * 3);
        } catch (InterruptedException exception) {
            // TODO Auto-generated catch block
            exception.printStackTrace();
        }
        String value = req.getParameter("value");
        System.out.println("Request saved successfullt after click ::: " + value);
        resp.getWriter().write(value);
    }
}
