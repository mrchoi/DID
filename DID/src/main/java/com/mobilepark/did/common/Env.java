package com.mobilepark.did.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Enumeration;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author kodaji
 *
 */
public class Env
{
	private static Logger logger = LoggerFactory.getLogger(Env.class);
	
	/**
	 * Properties 생성
	 */
	private static Properties props = new Properties();
	
	/**
	 * zoo.properties 파일 로드 후 console에 출력
	 * @param in - load라는 메소드를 통해서 Properties 파일을 읽어 와야 하는데 이 때 전달되는 인자는 InputStream
	 * @throws Exception
	 */
	public static void load(InputStream in) throws Exception
	{
		props.load(in);
		
		logger.debug("================================ Env Start ================================");
		Enumeration<String> e = propertyNames();
		while(e.hasMoreElements())
		{
			String key = e.nextElement();
			String value = get(key);
			logger.debug(key + " = " + value);
		}
		logger.debug("================================ Env   End ================================");
		IOUtil.close(in);
	}
	
	/** EnvServletContextListener.java 파일에서 부름.
	 *  load 메소드 파라미터 InputStream을 전달하려면 FileInputStream을 만들어서 전달해야 함
	 * @param filename : configFile
	 * @throws Exception
	 */
	public static void load(String filename) throws Exception
	{
		File file = getConfigFile(filename);
		FileInputStream fin = new FileInputStream(file);
		load(fin);
		
		IOUtil.close(fin);
	}
	
	/**
	 * @param filename : configFile
	 * getResource는 클래스 패스내에서 filename을 찾아서 그 URL을 넘겨준다
	 * @return  confileFilename = 파일경로 맨앞 '/'없을 경우 '/' 붙여서 url 생성 후 return
	 * @throws Exception
	 */
	public static File getConfigFile(String filename) throws Exception
	{
		ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
		URL url = classLoader.getResource(filename);
		if (url == null && !filename.startsWith("/")) url = classLoader.getResource("/" + filename);
		String configFilename = url.getFile();
		logger.info("configFilename=" + configFilename);

		File file = new File(configFilename);
		return file;
	}
	
	/**
	 * 
	 * @return propertyNames  method의 Hashtable keys값 리턴.
	 */
	@SuppressWarnings("unchecked")
	public static Enumeration<String> propertyNames()
	{
		return (Enumeration<String>) props.propertyNames();
	}
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	public static String get(String key)
	{
		return props.getProperty(key);
	}
	
	public static int getInt(String key)
	{
		return NumberUtil.parseInt(get(key));
	}
	
	public static boolean getBoolean(String key)
	{
		return getBoolean(key, false);
	}
	
	public static boolean getBoolean(String key, boolean defaultValue)
	{
		boolean b = defaultValue;
		try
		{
			b = Boolean.parseBoolean(get(key));
		}
		catch(Exception e)
		{
			logger.error("", e);
		}
		return b;
	}
}