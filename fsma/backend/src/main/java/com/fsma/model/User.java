package com.fsma.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="user")
public class User{

	@Id
	private String email;
	@Column(name="username", nullable=false)
	private String username;
	@Column(name="password", nullable=false)
	private String password;
	@Column(name="image", nullable=false)
	private String image;
	@Column(name="language", nullable=true)
	private String language;
	@Column(name="region", nullable=true)
	private String region;
	
	
	public User() {
		
	}
	
	public User(String email, String username, String password,String image, String language, String region) {
		this.email = email;
		this.username = username;
		this.password = password;
		this.image = image;
		this.language=language;
		this.region = region;
	}
	
	public String toString() {
		return username + " - "+language;
	}
	

}
