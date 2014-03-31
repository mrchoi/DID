package com.mobilepark.kiosk.common;

import java.io.IOException;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;

public class IOUtil
{
	public static void close(SocketChannel socketChannel)
	{
		try
		{
			if (socketChannel != null)
			{
				socketChannel.close();
				socketChannel = null;
			}
		}
		catch(IOException e) {}
	}
	
	public static void close(ServerSocketChannel serverSocketChannel)
	{
		try
		{
			if (serverSocketChannel != null)
			{
				serverSocketChannel.close();
				serverSocketChannel = null;
			}
		}
		catch(IOException e) {}
	}
	
	public static void close(Selector selector)
	{
		try
		{
			if (selector != null)
			{
				selector.close();
				selector = null;
			}
		}
		catch(IOException e) {}
	}
	
	public static void sleep(long millis)
	{
		try
		{
			Thread.sleep(millis);
		}
		catch(InterruptedException e) {}
	}
}
