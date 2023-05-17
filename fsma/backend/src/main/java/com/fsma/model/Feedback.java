package com.fsma.model;

import lombok.Data;

@Data
public class Feedback {
	
	private String apikey;
	
	private String email;
	
	private String review;
	
	private float userscore;
	
	private int timesWatched;
	
}
