package com.mobilepark.kiosk.client;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
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
	private final int WOL_PORT = 9;
	
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

			if (request.getSubMessageCode() == 0 || request.getSubMessageCode() == 3 || request.getSubMessageCode() == 4)
				response = this.successMessage();
			else
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
	
	private Message successMessage() {
		Message message = new Message();
		message.setBody("SUCCESS");

		return message;
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
	
	public static void main(String[] args) {

	}

	public String adminCall(String ip, int command, int sequence) throws Exception
	{
		KioskClient client = new KioskClient();
		String msg = "";
		
		try {

			switch (command) {
			case 0:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.ON_OFF, "ON"));
				msg = client.kiosk(ip, Message.ON_OFF, "OFF");
				break;

			case 1:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.CLOCK, DateUtil.getCurrentTime("yyyy-MM-dd HH:mm:ss.SSS")));
				msg = client.kiosk(ip, Message.CLOCK, DateUtil.getCurrentTime("yyyy-MM-dd HH:mm:ss"));
				break;

			case 2:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.POPUP, "http://www.naver.com"));
				String popUrl = "http://125.176.115.138:3501/did/user/obstacle.htm?sequence=" + sequence;
				msg = client.kiosk(ip, Message.POPUP, popUrl);
				break;

			case 3:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.POPUP, "http://www.naver.com"));
				msg = client.kiosk(ip, Message.RESTART, "RESTART");
				break;

			case 4:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.POPUP, "http://www.naver.com"));
				msg = client.kiosk(ip, Message.ON_OFF, "ON");
				break;

			case 255:
				// System.out.println("result = " + client.kiosk("127.0.0.1", Message.HEARTBEAT, ""));
				msg = client.kiosk(ip, Message.HEARTBEAT, "");
				break;

			default:
				msg = "kiosk command mismatch";
				break;
			}

		} catch (Exception e) {
			logger.info(e.getMessage(), e);
		}

		return msg;
	}

	public String wakeOnLan(String ipStr, String macStr) {
		String msg = "";

		try {
			byte[] macBytes = getMacBytes(macStr);
			byte[] bytes = new byte[6 + 16 * macBytes.length];
			for (int i = 0; i < 6; i++) {
				bytes[i] = (byte) 0xff;
			}
			for (int i = 6; i < bytes.length; i += macBytes.length) {
				System.arraycopy(macBytes, 0, bytes, i, macBytes.length);
			}

			System.out.println("=====WOL IP:" + ipStr + " MAC:" + macStr);

			InetAddress address = InetAddress.getByName(ipStr);
			DatagramPacket packet = new DatagramPacket(bytes, bytes.length, address, WOL_PORT);
			DatagramSocket socket = new DatagramSocket();
			socket.send(packet);
			socket.close();

			msg = ipStr + " Wake-on-LAN packet sent.";
		} catch (Exception e) {
			msg = "Failed to send Wake-on-LAN packet: " + e;
			System.exit(1);
		}

		return msg;
	}

	private static byte[] getMacBytes(String macStr) throws IllegalArgumentException {
		byte[] bytes = new byte[6];
		String[] hex = macStr.split("(\\:|\\-)");
		if (hex.length != 6) {
			throw new IllegalArgumentException("Invalid MAC address.");
		}
		try {
			for (int i = 0; i < 6; i++) {
				bytes[i] = (byte) Integer.parseInt(hex[i], 16);
			}
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid hex digit in MAC address.");
		}
		return bytes;
	}

}
