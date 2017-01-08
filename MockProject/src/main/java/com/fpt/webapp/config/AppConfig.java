package com.fpt.webapp.config;

import java.io.IOException;
import java.util.Properties;

import javax.sql.DataSource;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.fpt.webapp.dao.EmployeeDaoImpl;
import com.fpt.webapp.dao.UserDaoImpl;
import com.fpt.webapp.utils.EmployeeDAO;
import com.fpt.webapp.utils.UserDAO;

@Configuration
@ComponentScan("com.fpt.webapp.*")
@PropertySource("classpath:ds-hibernate-cfg.properties")
@EnableTransactionManagement
public class AppConfig {
	
	@Autowired
	Environment env;
	
	@Bean
	public ResourceBundleMessageSource messageSource() {
	   ResourceBundleMessageSource rb = new ResourceBundleMessageSource();
	   // Load property in message/validator.properties
	   rb.setBasenames(new String[] { "messages/validator"});
	   return rb;
	}
	
	@Autowired
	  @Bean(name = "transactionManager")
	  public HibernateTransactionManager getTransactionManager(SessionFactory sessionFactory) {
	      HibernateTransactionManager transactionManager = new HibernateTransactionManager(sessionFactory);
	 
	      return transactionManager;
	  }
	
	@Bean(name = "viewResolver")
	  public InternalResourceViewResolver getViewResolver() {
	      InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
	      viewResolver.setPrefix("/WEB-INF/views/");
	      viewResolver.setSuffix(".jsp");
	      return viewResolver;
	  }
	 
	 @Bean(name = "dataSource")
	  public DataSource getDataSource() {
	      DriverManagerDataSource dataSource = new DriverManagerDataSource();
	 
	      dataSource.setDriverClassName(env.getProperty("ds.database-driver"));
	      dataSource.setUrl(env.getProperty("ds.url"));
	      dataSource.setUsername(env.getProperty("ds.username"));
	      dataSource.setPassword(env.getProperty("ds.password"));
	 
	      return dataSource;
	  }
	 
	 @Autowired
	 @Bean(name = "sessionFactory")
	 public SessionFactory getSessionFactory(DataSource dataSource) throws IOException{
		 Properties properties = new Properties();
	      properties.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
	      properties.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
	      properties.put("current_session_context_class", env.getProperty("current_session_context_class"));
	      
	 
	      LocalSessionFactoryBean factoryBean = new LocalSessionFactoryBean();
	      factoryBean.setPackagesToScan(new String[] { "com.fpt.webapp.entity" });
	      factoryBean.setDataSource(dataSource);
	      factoryBean.setHibernateProperties(properties);
	      factoryBean.afterPropertiesSet();
	      //
	      SessionFactory sf = factoryBean.getObject();
	      return sf;

	 }
	 
	 @Bean(name="logindao")
	 public UserDAO getLogindao(){
		 return new UserDaoImpl();
	 }
	 @Bean(name="employeedao")
	 public EmployeeDAO getEmployeedao(){
		 return new EmployeeDaoImpl();
	 }
	 
}
