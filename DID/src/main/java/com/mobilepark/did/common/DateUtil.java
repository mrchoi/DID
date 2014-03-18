package com.mobilepark.did.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	  public static long diffOfDate(String start, String end, String format) throws Exception
	  {
	    SimpleDateFormat formatter = new SimpleDateFormat(format);

	    Date startDate = formatter.parse(start);
	    Date endDate = formatter.parse(end);

	    long diff = endDate.getTime() - startDate.getTime();
	    long diffDays = diff / (24 * 60 * 60 * 1000);

	    return diffDays;
	  }

		public static String today()
		{
			String DATE_FORMAT = "yyyyMMdd";
			SimpleDateFormat sdf =
			new SimpleDateFormat(DATE_FORMAT);
			Calendar c1 = Calendar.getInstance(); // today
			String date = sdf.format(c1.getTime());
			//System.out.println("Today is " + sdf.format(c1.getTime()));
			return date;
		}
		
		public static String dateFormat(String date, String pattern){
			
			long dateTime = DateUtil.getTimeMillis(date, "yyyy-MM-dd");
			Date d = new Date(dateTime);
			String dateformat = "";
			if(pattern.equals("yyyy.MM.dd")) dateformat = DateUtil.getTimeMillis(d.getTime(), "yyyy.MM.dd");
			if(pattern.equals("yyyy년 MM월 dd일")) dateformat = DateUtil.getTimeMillis(d.getTime(), "yyyy년 MM월 dd일");
			if(pattern.equals("yyyyMMdd")) dateformat = DateUtil.getTimeMillis(d.getTime(), "yyyyMMdd");
			
			return dateformat;
		}

		public static String getCurrentTime(String pattern)
		{
			SimpleDateFormat dataFormat = new SimpleDateFormat (pattern);
			Date date = new Date();
			date.setTime ((long) (System.currentTimeMillis ()));
			return dataFormat.format(date);
		}

		public static long getTimeMillis(String time, String pattern)
		{
			long retTime = 0;
			try
			{
				SimpleDateFormat format = new SimpleDateFormat(pattern);
				Date date = format.parse(time);
				retTime = date.getTime();
			}
			catch (Exception e) {}

			return retTime;
		}

		public static String getTimeMillis(long time, String pattern)
		{
			SimpleDateFormat format = new SimpleDateFormat(pattern);
			Date date = new Date();
			date.setTime(time);
			return format.format(date);
		}
		
		public static String getDate(String date, String sourceFormat, String targetFormat) {

	        String strDate = date;

	        try
	        {
	            SimpleDateFormat  format = new SimpleDateFormat(sourceFormat);
	            Date newDate = format.parse(date);

	            SimpleDateFormat  newFormat = new SimpleDateFormat(targetFormat);
	            strDate = newFormat.format(newDate);
	        }
	        catch (Exception e) {
	            e.getMessage();
	        }

	        return strDate;
	    }

	    public static String getDate(String date, String sourceFormat, String targetFormat, int oneDate) {

	        String strDate = date;

	        try
	        {
	            SimpleDateFormat  format = new SimpleDateFormat(sourceFormat);
	            Date newDate = format.parse(date);
	            long time = newDate.getTime() + ((long)(24 * 60 * 60 * 1000) * oneDate);
	            newDate.setTime (time);

	            SimpleDateFormat  newFormat = new SimpleDateFormat(targetFormat);
	            strDate = newFormat.format(newDate);
	        }
	        catch (Exception e) {
	            e.getMessage();
	        }

	        return strDate;
	    }
	    
	    public static String setDate(Date date){
	    	String tmpDate = "0";
	    	 try
		        {
	    		 SimpleDateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
	    	
	    		 tmpDate = sdFormat.format(date); 
		        }
	    	 catch (Exception e) {
		            e.getMessage();
		        }
	    	 return tmpDate;
	    	
	    }
	  
}
