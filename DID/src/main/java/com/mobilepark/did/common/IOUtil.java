package com.mobilepark.did.common;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.Writer;
import java.net.Socket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mobilepark.did.HomeController;

public class IOUtil
{
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	public static void close(Socket socket)
	{
		try
		{
			if (socket != null)
			{
				socket.close();
				socket = null;
			}
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
	}
	
	public static void close(InputStream in)
	{
		try
		{
			if (in != null)
			{
				in.close();
				in = null;
			}
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
	}

	public static void close(OutputStream out)
	{
		try
		{
			if (out != null)
			{
				out.close();
				out = null;
			}
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
	}

	public static void close(Reader reader)
	{
		try
		{
			if (reader != null)
			{
				reader.close();
				reader = null;
			}
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
	}

	public static void close(Writer writer)
	{
		try
		{
			if (writer != null)
			{
				writer.close();
				writer = null;
			}
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
	}
}