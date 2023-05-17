package com.fsma.model;

import java.util.Date;

import lombok.Data;

@Data
public class SeriesList {

	private String apikey;
	
	private String email;
	
	private Date stardate;
	
	private Date finishdate;
	
	private String status;
}
