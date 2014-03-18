package com.mobilepark.did.common;

import java.text.DecimalFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class NumberUtil
{
	private static Logger logger = LoggerFactory.getLogger(NumberUtil.class);
	
	public static short parseShort(String s)
	{
		return (short) parseLong(s);
	}
	
	public static int parseInt(String s)
	{
		return (int) parseLong(s);
	}
	
	public static long parseLong(String s)
	{
		long longValue = 0;
		try
		{
			DecimalFormat format = new DecimalFormat();
			longValue= format.parse(s).longValue();
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
				
		return longValue;
	}
	
	public static double parseDouble(String s)
	{
		double doubleValue = 0;
		try
		{
			DecimalFormat format = new DecimalFormat();
			doubleValue = format.parse(s).doubleValue();
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
				
		return doubleValue;
	}
	
	public static String format(long l)
	{
		return format(l, "");
	}
	
	public static String format(long l, String pattern)
	{
		String s = "";
		try
		{
			DecimalFormat format = new DecimalFormat(pattern);
			s = format.format(l);
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
		return s;
	}
	
	public static String format(double d)
	{
		return format(d, "");
	}
	
	public static String format(double d, String pattern)
	{
		String s = "";
		try
		{
			DecimalFormat format = new DecimalFormat(pattern);
			s = format.format(d);
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
		return s;
	}
}