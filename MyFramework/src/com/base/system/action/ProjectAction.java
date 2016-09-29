package com.base.system.action;import org.springframework.security.core.Authentication;import org.springframework.security.core.context.SecurityContextHolder;import org.springframework.web.servlet.ModelAndView;import project.jun.util.HoUtil;import project.jun.was.HoModel;import project.jun.was.servlet.HoServlet;import project.jun.was.spring.HoController;import project.jun.was.parameter.HoParameter;import org.apache.log4j.MDC;public abstract class ProjectAction extends HoController {    /**     * 실제 biz logic실행전 실행될 method     * @param actionFlag     * @throws Exception     */    public void beforeExecute( String actionFlag, HoModel model, HoParameter parameter, HoServlet   hoServlet) throws Exception {		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();		    	if (authentication!=null) {    		String   userId = hoServlet.getHoSession().getString("USER_ID") ;    					MDC.put("USER_NAME", HoUtil.replaceNull(authentication.getName()));    		if( userId != null ) {    			MDC.put("USER_ID", HoUtil.replaceNull(userId));    		}    	}    	    	/*    	 * Authentication 사용시 최종 로그인 정보만 출력되는 문제... 발생..    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();    	Object principal = auth.getPrincipal();    	System.out.println("-ccccc->" + principal.getClass().getName());		HttpServletRequest httprequest = (HttpServletRequest) hoServlet.getRequest();    	SecurityContext context =	(SecurityContext) httprequest.getSession().getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY);     	if( context!=null ) {			Authentication authentication = context.getAuthentication();	    	System.out.println("-Name->" +  authentication.getName() );    	}    	    	if (principal instanceof UserInfo) {    		String username = ((UserInfo) principal).getUsername();    		String password = ((UserInfo) principal).getPassword();    		String userId = ((UserInfo) principal).getUserId();        	System.out.println("-userId->" + userId );    		MDC.put("USER_ID", userId);    	} else {    		MDC.put("USER_ID", "");    	}    	*//* * HoServlet으로 정보저장 안되는 문제...     	hoServlet.getHoSession().setObject("COMPANY_CD", "0001");    	if( !hoServlet.getHoSession().getString("USER_ID").equals("") ) {    		MDC.put("USER_ID", hoServlet.getHoSession().getString("USER_ID"));    	}*/    }    /**     * 실제 biz logic실행후 실행될 method     * @param actionFlag     * @throws Exception     */    public void afterExecute( String actionFlag, ModelAndView mav) throws Exception { }    /**     * exception발생시 실행될 method     * @param actionFlag     * @throws Exception     */    public void exceptionExecute( String actionFlag, ModelAndView mav) throws Exception { }    /**     * 항상 실행될 method     * @param actionFlag     * @throws Exception     */    public void finallyExecute( String actionFlag, ModelAndView mav) throws Exception { }}