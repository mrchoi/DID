package com.mobilepark.did.kiosk.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mobilepark.did.framework.dao.GenericDao;
import com.mobilepark.did.framework.service.GenericServiceImpl;
import com.mobilepark.did.kiosk.dao.KioskDao;
import com.mobilepark.did.kiosk.model.Kiosk;
import com.mobilepark.kiosk.client.KioskClient;

@Service
@Transactional
public class KioskServiceImpl extends GenericServiceImpl<Kiosk> implements KioskService {
	
	@Autowired
	private KioskDao kioskDao;
	
	KioskClient client = new KioskClient();

	@Override
	protected GenericDao<Kiosk> getGenericDao() {
		return kioskDao;
	}

	/*public void heartbeatUpdate(List<Kiosk> kioskList) {
	 * 
	 * try { long time = System.currentTimeMillis(); SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss"); String str =
	 * dayTime.format(new Date(time)); System.out.println("=====heartbeatUpdate start: " + str); long start = System.currentTimeMillis(); long end =
	 * System.currentTimeMillis();
	 * 
	 * for (Kiosk kiosk : kioskList) { KioskThreadHeartbeat Heartbeat = new KioskThreadHeartbeat(kiosk); Heartbeat.start(); Heartbeat.join(); }
	 * 
	 * end = System.currentTimeMillis(); System.out.println("=====heartbeatUpdate end: " + (end - start) / 1000 + " 초걸림");
	 * 
	 * } catch (Exception e) { // TODO Auto-generated catch block e.printStackTrace(); } } */

	public void heartbeatUpdate(List<Kiosk> kioskList) {

		try {
			long time = System.currentTimeMillis();
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));
			System.out.println("=====heartbeatUpdate start: " + str);
			long start = System.currentTimeMillis();
			long end = System.currentTimeMillis();

			try {
				for (Kiosk kiosk : kioskList) {
					String heartbeat = client.adminCall(kiosk.getIp(), 255, kiosk.getSequence());

					System.out.println("===== KioskThreadHeartbeat ip:" + kiosk.getIp());

					if (kiosk.getStatus().equals("1") && !heartbeat.equals("SUCCESS")) {
						kiosk.setStatus("0");
						kioskDao.update(kiosk);
					}

					if (kiosk.getStatus().equals("0") && heartbeat.equals("SUCCESS")) {
						kiosk.setStatus("1");
						kioskDao.update(kiosk);
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			end = System.currentTimeMillis();
			System.out.println("=====heartbeatUpdate end: " + (end - start) / 1000 + " 초걸림");

		} catch (Exception e) { // TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}