package com.example.mycontactlist;

import android.text.format.Time;

public class Contact {
	private int contactID;
	private String contactName;
	private String streetAddress;
	private String city;
	private String state;
	private String zipCode;
	private String phoneNumber;
	private String cellNumber;
	private String eMail;
	private Time birthday;
	
	public Contact() {
		contactID = -1;
		Time t = new Time();
		t.setToNow();
		birthday = t;
	}

	public int getContactID() {
		return contactID;
	}
	public void setContactID(int i) {
		contactID = i;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String s) {
		contactName = s;
	}
	public Time getBirthday() {
		return birthday;
	}
	public void setBirthday(Time t) {
		birthday = t;
	}
	public String getStreetAddress() {
		return streetAddress;
	}
	public void setStreetAddress(String s) {
		streetAddress = s;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String s) {
		city = s;
	}
	public String getState() {
		return state;
	}
	public void setState(String s) {
		state = s;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String s) {
		zipCode = s;
	}
	public void setPhoneNumber(String s) {
		phoneNumber = s;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setCellNumber(String s) {
		cellNumber = s;
	}
	public String getCellNumber() {
		return cellNumber;
	}
	public void setEMail(String s) {
		eMail = s;
	}
	public String getEMail() {
		return eMail;
	}
}