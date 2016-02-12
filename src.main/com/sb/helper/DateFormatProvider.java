package com.sb.helper;

import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

/**
 * @author satya60.shekhar@gmail.com
 *
 */
public class DateFormatProvider {

    /**
     * Return the current day in 'dd-MMM-yyyy' format
     * 
     * @return never null
     */
    public static String getCurrentDay() {
        GregorianCalendar fmt = new GregorianCalendar();
        SimpleDateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
        return df.format(fmt.getTime());
    }
}
