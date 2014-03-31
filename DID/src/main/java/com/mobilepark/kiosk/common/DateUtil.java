package com.mobilepark.kiosk.common;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

public class DateUtil
{
	public static String getCurrentTime(String pattern)
	{
		return getCurrentTime(pattern, Locale.getDefault());
	}
	
	public static String getCurrentTime(String pattern, Locale locale)
	{
		SimpleDateFormat dataFormat = new SimpleDateFormat (pattern, locale);
		Date date = new Date();
		date.setTime (System.currentTimeMillis());
		return dataFormat.format(date);
	}
	
	public static String getPreTime(String pattern, int preTime)
	{
		SimpleDateFormat dataFormat = new SimpleDateFormat(pattern);
		Date date = new Date();

		long yesterDayTime = System.currentTimeMillis () - ( 24 * 60 * 60 * 1000 * preTime );
		date.setTime (yesterDayTime);
		return dataFormat.format(date);
	}
	
	public static String getDate(String date, String sourceFormat, String targetFormat)
	{
		return getDate(date, sourceFormat, targetFormat, Locale.getDefault());
	}
	
	public static String getDate(String date, String sourceFormat, String targetFormat, Locale locale)
	{
		String strDate = date;

		try {
			SimpleDateFormat  format = new SimpleDateFormat(sourceFormat);
        	Date newDate = format.parse(date);

        	SimpleDateFormat  newFormat = new SimpleDateFormat(targetFormat);
        	strDate = newFormat.format(newDate);
		} catch (Exception e) {
			e.getMessage();
		}

		return strDate;
	}
	
	public static String getDatetoString(Date date, String sourceFormat)
	{
		String strDate = "";
		
		if(date != null)
		{	
			try {
				SimpleDateFormat  format = new SimpleDateFormat(sourceFormat);
	        	strDate = format.format(date);
			} catch (Exception e) {
				e.getMessage();
			}
		}
		
		return strDate;
	}

	public static long getTimeMillis(String time, String pattern)
	{
		return getTimeMillis(time, pattern, Locale.getDefault());
	}
	
	public static long getTimeMillis(String time, String pattern, Locale locale)
	{
		long retTime = 0;
		try
		{
			SimpleDateFormat format = new SimpleDateFormat(pattern, locale);
			Date date = format.parse(time);
			retTime = date.getTime();
		}
		catch (Exception e) {}

		return retTime;
	}
	
	public static String getTimeMillis(long time, String pattern)
	{
		return getTimeMillis(time, pattern, Locale.getDefault());
	}

	public static String getTimeMillis(long time, String pattern, Locale locale)
	{
		SimpleDateFormat format = new SimpleDateFormat(pattern, locale);
		Date date = new Date();
		date.setTime(time);
		return format.format(date);
	}
	
	
	/**
	 * @Ses XML DateTime(XMLGregorianCalendar) -> Date
	 * @param calendar
	 * @return
	 */
	public synchronized static Date toDate(XMLGregorianCalendar calendar){
        if(calendar == null) {
            return null;
        }
        
	   return calendar.toGregorianCalendar().getTime();
	}

	/**
	 * 
	 * @param start
	 * @param stop
	 * @return
	 */
    public synchronized static long getDurationMillis(Date start, Date stop){
    	
		long duration = 0;
		
		Calendar cal01 = Calendar.getInstance();
		Calendar cal02 = Calendar.getInstance();
	
		cal01.setTime(start);
		cal02.setTime(stop);
		
		duration = (cal02.getTime().getTime() - cal01.getTime().getTime()) ;
	
		return duration;
    }
    
    
    /**
     * 
     * @param start
     * @param stop
     * @return
     */
    public synchronized static int getDurationSecond(Date start, Date stop){
    	
		long duration = 0;
		
		Calendar cal01 = Calendar.getInstance();
		Calendar cal02 = Calendar.getInstance();
	
		cal01.setTime(start);
		cal02.setTime(stop);
		
		duration = (cal02.getTime().getTime() - cal01.getTime().getTime()) / 1000;
	
		return (int)duration;
    }
  
    
    /**
     * 
     * @param c
     * @return
     */
    public static XMLGregorianCalendar toXMLGregorianCalendar(Calendar c){
		 GregorianCalendar gc = new GregorianCalendar();
		 gc.setTimeInMillis(c.getTimeInMillis());
		 XMLGregorianCalendar xc= null;
		try {
		    xc = DatatypeFactory.newInstance().newXMLGregorianCalendar(gc);
		} catch (DatatypeConfigurationException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}
		 return xc;
	}
    
    /**
     * 
     * @param c
     * @return
     */
    public static XMLGregorianCalendar toXMLGregorianCalendar(Date date){
		
		 return toXMLGregorianCalendar(DateToCalendar(date));
	}
    
    /**
     * 
     * @param date
     * @return
     */
    public static Calendar DateToCalendar(Date date ) 
    { 
    	 Calendar cal = Calendar.getInstance();

    	 cal.setTime(date);
    	  
    	 return cal;
    }
}

