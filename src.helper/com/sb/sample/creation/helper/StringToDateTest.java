package com.sb.sample.creation.helper;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringToDateTest {

    public static void main(String[] args) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = dateFormat.parse("23/04/2014");
        System.out.println("Date (dd/MM/yyyy) : " + date);
        
        dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        date = dateFormat.parse("04/23/2014");
        System.out.println("Date (MM/dd/yyyy): " + date);
    }
}
