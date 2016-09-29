<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ tag
	import="project.jun.was.HoModel"
	import="project.jun.util.HoUtil"
	import="project.jun.util.HoServletUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoValidator"
%><%@ include file="include.tag" %>
<%@ attribute name="rownum" type="java.lang.String"
%><%@ attribute name="align" type="java.lang.String"
%><%

	int gridIndex = HoServletUtil.getIndex(request, "grid_index");

	boolean isDockedItem = HoServletUtil.getArea(request).indexOf("dockedItems") > 0;
%>


<% if( (isScript || isScriptOut) && isDockedItem) {

		HoServletUtil.setInArea(request, "toolbars");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
		
		if( !"left".equals(HoUtil.replaceNull(align))) {
			HoServletUtil.setString(request, "dockedItems-align", "right");
		}
%>
	    <jsp:doBody></jsp:doBody>
<%
		HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">toolbar_row");
		HoServletUtil.setOutArea(request);
 } %>

<% if( isHtml ) {%>
<% } %>