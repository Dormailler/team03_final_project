package com.project.wm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;

@SpringBootApplication
@Component
@ComponentScan(basePackages = {"main","controller","dto","dao","service","shareboard", "commBoard"})
@MapperScan(basePackages = {"dao","shareboard", "commBoard"})
public class SharemarketApplication {

	public static void main(String[] args) {
		SpringApplication.run(SharemarketApplication.class, args);
	}

}
