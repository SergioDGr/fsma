package com.fsma.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fsma.model.User;

public interface UserRepository extends JpaRepository<User, String>{
	
}
