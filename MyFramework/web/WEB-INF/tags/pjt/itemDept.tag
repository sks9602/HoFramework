<%@ tag language="java" pageEncoding="UTF-8"
	import="project.jun.was.HoModel"
	import="project.jun.was.spring.HoController"
	import="project.jun.util.HoUtil"
	import="project.jun.was.parameter.HoParameter"
	import="project.jun.dao.HoDao"
	import="project.jun.dao.result.HoList"
	import="project.jun.config.HoConfig"
	import="org.springframework.web.context.support.WebApplicationContextUtils"
	import="org.springframework.web.context.WebApplicationContext"
	import="project.jun.dao.parameter.HoQueryParameterMap"
	import="java.util.List"
	import="java.util.Date"
	import="java.text.DateFormat"
	import="project.jun.util.asp.HoAspUtil"
	import="project.jun.util.HoUtilExtjs"
	import="project.jun.util.HoValidator"
	import="project.jun.util.HoServletUtil"
	import="project.jun.util.HoSpringUtil"
	import="project.jun.util.cache.HoCache"	
	import="project.jun.util.cache.HoEhCache"
	import="project.jun.dao.result.HoMap"
	import="project.jun.dao.parameter.HoQueryParameterHandler"
	import="project.jun.dao.result.transfigure.HoMapHasList"
%><%-- 공통코드를 이용한 기본 검색 조건 생성 - combobox, radio, checkbox --%><%@ 
include file="../include.tag" %><%@ 
attribute name="type"   type="java.lang.String"  required="true"%><%--  combo, radio, checkbox --%><%@ 
attribute name="title"  type="java.lang.String"  %><%@ 
attribute name="value"   type="java.lang.String" %><%-- 설정 값  , 여러 값일 경우 ","로 구분 ex1) "B1010" ex2) "B1010,B1020" multiSelect가 "Y"인 경우에만 다중 선택 됨.--%><%@ 
attribute name="require" type="java.lang.String" %><%@ 
attribute name="colspan"    type="java.lang.String" %><%@ 
attribute name="rowspan"    type="java.lang.String" %><%

	String name = "dept";

 	if( isScript || isScriptOut ) {
		String nowArea = HoServletUtil.getNowArea(request);

		if( !"fieldcontainer".equals(nowArea)) {
			HoServletUtil.setInArea(request, "fieldcontainer");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( itemsRow > 0 ? "," : "");
		}		
		
		int itemNowIndex = HoServletUtil.getIndex(request, HoServletUtil.getArea(request));
		int increaseIndex = getIndexIncrement( type );

		if( itemNowIndex + increaseIndex > getMaxItemByArea(request)  ) { // MAX_ROW_ITEM_SEARCH
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request)+">item_row");
			HoServletUtil.initIndex(request, HoServletUtil.getArea(request));
			String area = HoServletUtil.getNowArea(request);

			HoServletUtil.setOutArea(request);
			HoServletUtil.setInArea(request, "fieldcontainer");
			int itemsRow = HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row");
			HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");
			out.print( itemsRow > 0 ? "," : "");
		}


		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request), increaseIndex );
		HoServletUtil.setInArea(request, "item");
		out.println(HoServletUtil.getIndex(request, HoServletUtil.getArea(request)+"_row") > 0 ? "," : "");
		HoServletUtil.increaseIndex(request, HoServletUtil.getArea(request)+"_row");

%>

<%
// TODO - 나중에 삭제..
HoList list = null;
String groupCode = "SYS002";
// 쿼리를 통해 구성하는 경우
if( groupCode.indexOf(".")>0) {
	HoQueryParameterHandler hqph = new HoQueryParameterHandler(param, hoConfig);

	HoQueryParameterMap value = hqph.getForDetail();

	list = dao.select(groupCode, value);
} 
// 공통코드로 구하는 경우.
else {
	list = cache.getHoList(groupCode); // cache defined in "include.tag"
}
HoAspUtil  aspUtil = new HoAspUtil();

HoList aspHoList = null;
if( list != null ) {
	aspHoList = aspUtil.getHoListAsp( list, "0000", "1000", "COMPANY_ID", "CD");
}

%>
		{ 	layout: { type : 'table' , columns: 7 }, // 'hbox',
			border : 0,
			colspan : <%= HoUtil.replaceNull(colspan, "4") %>,<%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
			<%= HoValidator.isNotEmpty(rowspan) ? "rowspan: "+rowspan+"," : ""  %>
			items : [
						{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>0',
		        fieldLabel    : '<%= title %>', <%= HoValidator.isIn(require, new String[]{"Y","true"}, true) ? "allowBlank : false, labelCls   : 'x-form-item-label x-form-item-label-required'," : "" %>
		        labelWidth : <%=labelWidth %>,
		        name          : '<%= name %>',
		        code          : '<%= groupCode %>', 
				value : '',
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : [<%= list!=null ? list.getMetaDataString() : "" %> ],
		            data      : [<%
						out.println("{NAME : '- 본부 -',   VALUE : ''  , group : ''},");
		            
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
		        })
			}, 
			{xtype           :'label', text : ' > ', labelCls : 'x-form-item-label', margin : '0 5 0 5'  },
			{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>1',
				width    : 200,
		        name          : '<%= name %>',
		        code          : '<%= groupCode %>', 
				value : '',
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : [<%= list!=null ? list.getMetaDataString() : "" %> ],
		            data      : [<%
						out.println("{NAME : '- 센터 -',   VALUE : ''  , group : ''},");
		            
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
		        })
			} , 
			{xtype           :'label', text : ' > ', labelCls : 'x-form-item-label', margin : '0 5 0 5'  },
			{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>2',
				width    : 200,
		        name          : '<%= name %>',
		        code          : '<%= groupCode %>', 
				value : '',
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : [<%= list!=null ? list.getMetaDataString() : "" %> ],
		            data      : [<%
						out.println("{NAME : '- 팀 -',   VALUE : ''  , group : ''},");
		            
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
		        })
			} , 
			{xtype           :'label', text : ' > ', labelCls : 'x-form-item-label', margin : '0 5 0 5'  },
			{
				xtype         : 'combotipple_ux', 
				id            : 'id_cmp_<%=p_action_flag %>_<%=HoServletUtil.getString(request, "form-id") %>_<%= name %>3',
				width    : 200,
		        name          : '<%= name %>',
		        code          : '<%= groupCode %>', 
				value : '',
		        <jsp:doBody></jsp:doBody>
		        store         : Ext.create('Ext.data.Store', {
		            fields    : [<%= list!=null ? list.getMetaDataString() : "" %> ],
		            data      : [<%
						out.println("{NAME : '- 부서 -',   VALUE : ''  , group : ''},");
		            
						for(int i=0; aspHoList!=null && i<aspHoList.size(); i++) {
							out.print((i>0 ? "," : "") + " {" + aspHoList.toJson(i) + "}");
						}					
		            %>
		            ]
		        })
			} 
			]
		}
<%
		HoServletUtil.setOutArea(request);
	}
%>

<%
	if( isHtml ) {
%>
<jsp:doBody/>
<%	} %>
