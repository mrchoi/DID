package com.mobilepark.kiosk.client;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.util.Iterator;

import org.apache.log4j.Logger;

import com.mobilepark.kiosk.common.ByteUtil;
import com.mobilepark.kiosk.common.DateUtil;
import com.mobilepark.kiosk.common.IOUtil;
import com.mobilepark.kiosk.model.Message;
import com.mobilepark.kiosk.model.Packet;

public class KioskClient
{
	private final Logger logger = Logger.getLogger(this.getClass().getName());
	
	private final int DEFAULT_PORT = 5555;
	
	private Message readMessage(SocketChannel client, ByteBuffer buffer, Selector selector) throws IOException
	{
		buffer.clear();
		Message response = null;
		
		//while (true) - 연결 유지시 필요
    	selector.select(3000);  
        
    	Iterator<SelectionKey> iter = selector.selectedKeys().iterator();  
		while (iter.hasNext())
		{
            SelectionKey key = iter.next();  
            if (!key.isReadable()) continue;

			int len = client.read(buffer);
			if (len < 0) break;  
			else if (len == 0) continue;
			
			buffer.flip();  
			  
			response = Packet.packetToMessage(buffer);
			
			logger.info("[SERVER<-KIOSK] Read " + len + " Bytes");
			logger.info("[SERVER->KIOSK] " + ByteUtil.hexString(buffer.array()));
			logger.info("[SERVER<-KIOSK] " + response.toString());
        }
		
		return response;
	}
	
	private void writeMessage(SocketChannel client, ByteBuffer buffer, Message request) throws IOException
	{
        Packet.messageToPacket(buffer, request);
        
        buffer.flip();
        client.write(buffer);
        
		logger.info("[SERVER->KIOSK] " + request.toString());
        logger.info("[SERVER->KIOSK] " + ByteUtil.hexString(buffer.array()));
        logger.info("[SERVER->KIOSK] Write " + buffer.position() + " Bytes");
	}
	
	private Message connect(String hostname, Message request)
	{
        Message response = null;
		Selector selector = null;  
		SocketChannel client = null;
		
        ByteBuffer buffer = ByteBuffer.allocate(1024);
        try
		{
			logger.info("Client :: started");  
            
            client = SocketChannel.open();  
            client.configureBlocking(false);  
            client.connect(new InetSocketAddress(hostname, DEFAULT_PORT));  
              
            selector = Selector.open();  
            client.register(selector, SelectionKey.OP_READ);
            
            while (!client.finishConnect())
            {  
                Thread.sleep(10);  
            }  
            
            logger.info("Client :: connected");
            
            this.writeMessage(client, buffer, request);
            response = this.readMessage(client, buffer, selector);
		}
		catch(Exception e)
		{
			logger.info(e.getMessage(), e);
		}
		finally
		{
			IOUtil.close(selector);
			IOUtil.close(client);
		}
        return response;
	}
	
	public String kiosk(String hostname, short subMessageCode, String body)
	{
        Message request = new Message();
        request.setMessageCode(Message.KIOSK_REQ);
        request.setSubMessageCode(subMessageCode);
        request.setBody(body);
        request.setLength(body.getBytes().length);
        
        Message response = this.connect(hostname, request);
        return response.getBody();
	}
	
	public static void main(String[] args)
	{
		KioskClient client = new KioskClient();
		System.out.println("result = " + client.kiosk("127.0.0.1", Message.ON_OFF, "ON"));
		
		IOUtil.sleep(1000);
		System.out.println("result = " + client.kiosk("127.0.0.1", Message.CLOCK, DateUtil.getCurrentTime("yyyy-MM-dd HH:mm:ss.SSS")));
		
		IOUtil.sleep(1000);
		System.out.println("result = " + client.kiosk("127.0.0.1", Message.POPUP, "http://www.naver.com"));

		IOUtil.sleep(1000);
		System.out.println("result = " + client.kiosk("127.0.0.1", Message.HEARTBEAT, ""));
	}
}
