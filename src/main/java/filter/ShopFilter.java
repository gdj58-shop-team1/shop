package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

import service.SiteCounterService;


@WebFilter("/*")
public class ShopFilter extends HttpFilter implements Filter {
    private SiteCounterService siteCounterService;
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 모든 컨트롤러 호출 시 "UTF-8" 세팅
		request.setCharacterEncoding("UTF-8");
		
		// 모든 컨트롤러 호출 시 todaySiteCounter, toalSiteCounter 갱신
		
		siteCounterService = new SiteCounterService();

		int todaySiteCounter = siteCounterService.getTodaySiteCounter();
		int totalSiteCounter = siteCounterService.getTotalSiteCounter();

		request.setAttribute("todaySiteCounter", todaySiteCounter);
		request.setAttribute("totalSiteCounter", totalSiteCounter);
		
		chain.doFilter(request, response);
		
		
	}
}
