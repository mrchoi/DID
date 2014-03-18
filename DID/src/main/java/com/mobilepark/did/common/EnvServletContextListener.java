package com.mobilepark.did.common;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author kas0610
 *
 */
public class EnvServletContextListener implements ServletContextListener
{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public void contextDestroyed(ServletContextEvent arg0) 
	{
	}


	/**
	 * ServletContextEvent : web 웹어플리케이션의 서블릿 컨텍스트의 변경에 대한 알림을 처리하기 위한 이벤트 클래스
	 * configFile = ServletContext를 이벤트로 붙여 받아옴(생성)
	 */
	public void contextInitialized(ServletContextEvent event)
	{
		String configFile = event.getServletContext().getInitParameter("configFile");
		logger.info("Config File [" + configFile + "]");
		try
		{
			Env.load(configFile);
		}
		catch(Exception e)
		{
			logger.error("Config File [" + configFile + "] Read Error !!!");
		}
	}
}