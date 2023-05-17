package com.fsma.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "series")
public class Series {
	
	@Id
	private String apiKey;
	
	@Column(name = "score")
	private float score;
	
	@Column(name = "userHaveWatched")
	private int userHaveWached;
	
}
