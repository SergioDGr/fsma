package com.fsma.model;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.Data;

@Data
public class Media {
	@Id
	private String apiKey;
	
	@Column(name = "score")
	private float score;
	
	@Column(name = "userHaveWatched")
	private int userHaveWached;
}
