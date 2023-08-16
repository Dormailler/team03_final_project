package com.project.wm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"main","controller","dto","service"}) 
@MapperScan(basePackages = {"dao"})
public class SharemarketApplication {

	public static void main(String[] args) {
		SpringApplication.run(SharemarketApplication.class, args);
	}

}
