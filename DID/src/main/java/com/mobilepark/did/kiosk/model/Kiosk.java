package com.mobilepark.did.kiosk.model;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class Kiosk implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int sequence;
	private String kiosk;
	private String location;
	private String ip;
	private String status;
	private String obstacle_contents;
	private String obstacle_status;
	private String schedule_start;
	private String schedule_end;
	private String mac_address;

	private Date register_date;
	private Date update_date;
	
	public int getSequence() {
		return sequence;
	}

	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	public String getKiosk() {
		return kiosk;
	}

	public void setKiosk(String kiosk) {
		this.kiosk = kiosk;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
		
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getObstacle_contents() {
		return obstacle_contents;
	}

	public void setObstacle_contents(String obstacle_contents) {
		this.obstacle_contents = obstacle_contents;
	}
	
	public String getObstacle_status() {
		return obstacle_status;
	}

	public void setObstacle_status(String obstacle_status) {
		this.obstacle_status = obstacle_status;
	}
	
	public String getSchedule_start() {
		return schedule_start;
	}

	public void setSchedule_start(String schedule_start) {
		this.schedule_start = schedule_start;
	}
	
	public String getSchedule_end() {
		return schedule_end;
	}

	public void setSchedule_end(String schedule_end) {
		this.schedule_end = schedule_end;
	}
	
	public Date getRegister_date() {
		return register_date;
	}

	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}

	public Date getUpdate_date() {
		return update_date;
	}

	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	
	public String getMac_address() {
		return mac_address;
	}

	public void setMac_address(String mac_address) {
		this.mac_address = mac_address;
	}

	public String toString() {
		return ToStringBuilder.reflectionToString(this,
				ToStringStyle.MULTI_LINE_STYLE);
	}

}
