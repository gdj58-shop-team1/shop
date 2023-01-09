package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class BootListenr implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce)  {
		// context(application)영역에 현재접속자 수를 저장할 속성변수(attribute) 생성, 초기화
		sce.getServletContext().setAttribute("currentCounter", 0);
		
		// 드라이브 로딩
        try {
        	Class.forName("org.mariadb.jdbc.Driver");
        } catch(Exception e) {
        	e.printStackTrace();
        }
	}
}
