package com.mobilepark.did;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mobilepark.did.kiosk.model.Kiosk;
import com.mobilepark.did.kiosk.service.KioskService;

@Component("sendDocumentPollingScheduler")
public class KioskScheduled {
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
	
	@Autowired
	private KioskService kioskService;

    @Scheduled(fixedRate = 500000) //50000 ->5분
    public void kioskScheuledStart() {
    	HashMap<String, Object> hash = new HashMap<String, Object>();
    	
    	List<Kiosk> list = kioskService.list(hash);
    	
    	for(int i=0;i<list.size();i++){
    		Kiosk kiosk = list.get(i);
    		System.out.println("ip : " + kiosk.getIp());
    		System.out.println("Mac_address : " + kiosk.getMac_address());
    		System.out.println("Schedule_start : " + kiosk.getSchedule_start());
    		System.out.println("Schedule_end : " + kiosk.getSchedule_end());
    	}
    	
        System.out.println("The time is now " + dateFormat.format(new Date()));
    }

}
