package com.fsma.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("com.fsma.model")
@EnableJpaRepositories(basePackages = "com.fsma.repository")
@ComponentScan(basePackages = {
		"com.fsma.service","com.fsma.config","com.fsma.controller"}
)
public class FsmaApplication {

	public static void main(String[] args) {
		SpringApplication.run(FsmaApplication.class, args);
	}

}
