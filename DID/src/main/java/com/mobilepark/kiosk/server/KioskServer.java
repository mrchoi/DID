package com.mobilepark.kiosk.server;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;

import org.apache.log4j.Logger;

import com.mobilepark.kiosk.common.ByteUtil;
import com.mobilepark.kiosk.common.IOUtil;
import com.mobilepark.kiosk.model.Message;
import com.mobilepark.kiosk.model.Packet;

public class KioskServer
{
	private final Logger logger = Logger.getLogger(this.getClass().getName());
	
	private final int DEFAULT_PORT = 5555;
	private KioskService service;
	
	public KioskServer()
	{
		service = new KioskServiceImpl();
	}
	
	private void writeMessage(SocketChannel client, ByteBuffer buffer, Message request) throws IOException
	{
		Message response = service.getResponse(request);  
		if (response == null) return;
		
		buffer.clear();
		Packet.messageToPacket(buffer, response);
        buffer.flip();
		client.write(buffer);
		
		logger.info("[SERVER<-KIOSK] " + response.toString());
		logger.info("[SERVER<-KIOSK] " + ByteUtil.hexString(buffer.array()));
		logger.info("[SERVER<-KIOSK] Write " + buffer.position() + " Bytes");
	}
	
	private Message readMessage(ByteBuffer buffer, int read) throws Exception
	{
		buffer.flip();
		Message request = Packet.packetToMessage(buffer);
		
		logger.info("[SERVER->KIOSK]" + ByteUtil.hexString(buffer.array()));
		logger.info("[SERVER->KIOSK] Read " + read + " Bytes");
		logger.info("[SERVER->KIOSK] " + request.toString());
		
		return request;
	}
	
	private void receiveClient(SocketChannel client)
	{
		Selector selector = null;
		try
		{
			client.configureBlocking(false);  
			selector = Selector.open();  

			client.register(selector, SelectionKey.OP_READ);  

			ByteBuffer buffer = ByteBuffer.allocate(1024);  
              
			//while (true) // 연결 유지시 필요
			{
				selector.select(3000);  

				Iterator<SelectionKey> iter = selector.selectedKeys().iterator();  
				while (iter.hasNext())
				{
					SelectionKey key = iter.next();  
					if (!key.isReadable()) continue;
						
					int read = client.read(buffer);  
					if (read < 0) break;
					else if (read == 0) continue;
					
					Message request = this.readMessage(buffer, read);
					this.writeMessage(client, buffer, request);
				}
			}  
			
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		finally
		{
			IOUtil.close(client);
			IOUtil.close(selector);
		}
	}
	
	private void accept()
	{
		ServerSocketChannel server = null;  
		Selector selector = null;  

		try
		{
			logger.info("Server :: started");  
            
			server = ServerSocketChannel.open();  
			server.socket().bind(new InetSocketAddress("", DEFAULT_PORT));  
			server.configureBlocking(false);  

			selector = Selector.open();  
			server.register(selector, SelectionKey.OP_ACCEPT);

			logger.info("Server :: waiting for accept");  
			
			while (true)
			{  
				selector.select(3000);  

				Iterator<SelectionKey> iter = selector.selectedKeys().iterator();  
				while (iter.hasNext())
				{  
					SelectionKey key = iter.next();  
					if (key.isAcceptable())
					{
						SocketChannel client = server.accept();  
						if (client == null) continue;
						this.receiveClient(client);
					}  
				}  
			}  
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
		}
		finally
		{
			IOUtil.close(server);
			IOUtil.close(selector);
		}
	}
	
	public static void main(String[] args)
	{
		KioskServer server = new KioskServer();
		server.accept();
	}
}
