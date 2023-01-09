package listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import service.SiteCounterService;

@WebListener
public class SiteCounterListener implements HttpSessionListener {
	private SiteCounterService siteCounterService;

	
    public void sessionCreated(HttpSessionEvent se)  { 
    	se.getSession().getServletContext().setAttribute("currentCounter", se.getSession().getServletContext().getAttribute("currentCounter"));
    	System.out.println("세션생성 currentCounter " + se.getSession().getServletContext().getAttribute("currentCounter"));
    	
    	// 전체 or 날짜별 접속자 수
    	siteCounterService = new SiteCounterService();
    	int todayCount;
    	todayCount = siteCounterService.getTodaySiteCounter();
    	if(todayCount==0) {
    		siteCounterService.addSiteCounter();
    	} else {
    		siteCounterService.modifySiteCounter();
    	}
    	//todayCount = siteCounterService
    }

    public void sessionDestroyed(HttpSessionEvent se)  { 
         
    }
	
}
