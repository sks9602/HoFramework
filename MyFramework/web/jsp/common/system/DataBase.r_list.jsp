<%@ page language="java" contentType="text/html;  charset=utf-8" pageEncoding="utf-8" session="true"%><%@ page	import="project.jun.dao.result.HoList"	import="project.jun.util.HoValidator"%><%@include file="/jsp/common/include/include.jsp"%><%	HoList list = model.getHoList("list");%><script type="text/javascript">	function fs_view(url) {		top.detail.location.href = url+ '&p_action_flag=r_detail';		var obj = parent.document.getElementById('main_frameset');		obj.cols='620,350,*';				top.view.location.href = url+ '&p_action_flag=r_detail_option';	}	function fs_info(url) {		top.detail.location.href = url+ '&p_action_flag=r_info';				var obj = parent.document.getElementById('main_frameset');		obj.cols='620,20,*';				top.view.location.href = 'about:blank';	}		function fs_join() {		document.join_form.p_action_flag.value = 'r_join_table';		document.join_form.target="view";		document.join_form.submit();		top.detail.location.href = "about:blank";	}	function fs_checkAll(obj) {		var doc1 = document.join_form;		if( doc1.table_name_es.length) {			for( var i=0 ; i<doc1.table_name_es.length; i++ ){				doc1.table_name_es[i].checked = obj.checked;			}		} else {			doc1.table_name_es.checked = obj.checked;		}	}	function fs_make() {		document.join_form.p_action_flag.value = 'b_make_table_info';		document.join_form.target="_self";		document.join_form.submit();		top.view.location.href = "about:blank";		top.detail.location.href = "about:blank";	}	function fs_RemoveCache() {		top.view.location.href = '/system/reload.do';		top.detail.location.href = "about:blank";	}</script><% String OWNER = "SKS9602"; %><form name="search_form" method="post" action="<%=G_CONTEXTROOT %>/system/dataBase.do">	<input type="hidden" name="p_action_flag" value="r_list"></input>	<input type="text" name="S_TABLE_NM" value="<%= param.get("S_TABLE_NM") %>" style="width:80%" ></input>	<input type="submit" value="찾기"></inpu>	<a href="/s/j_spring_security_logout">Logout</a></form><span><form name="join_form" method="post" action="<%=G_CONTEXTROOT %>/system/dataBase.do" target="view">	<input type="hidden" name="p_action_flag" value="r_join_table"></input>	<input type="hidden" name="owner" value="<%=OWNER%>"></input>	<table border="1">		<colgroup>			<col width="15" style="text-align:right"/>			<col width="200"/>			<col width="200"/>			<col width="50"/>			<col width="115"/>			<col width="30" style="text-align:center"/>			<col width="35" style="text-align:center"/>		</colgroup>		<thead>			<tr>				<td style="text-align:center" rowspan="2"></td>				<td style="text-align:center" rowspan="2">					테이블명(컬럼수)<br>					<input type="checkbox" name="table_name_mater" value="" onclick="fs_checkAll(this)"/><input type="button" value="컬럼정보 생성" onclick="fs_make()"></input>				</td>				<td style="text-align:center" rowspan="2">COMMENTS</td>				<td style="text-align:center" rowspan="2">ALIAS</td>				<td style="text-align:center" rowspan="2">QUERY</td>				<td style="text-align:center">JOIN</td>				<td >INLINE</td>			</tr>			<tr>				<td colspan="2" style="text-align:center"><input type="button" value="JOIN 설정" onclick="fs_join()"></input></td>			</tr>		</thead>		<tbody>	<%for(int i=0; list!=null && i<list.size(); i++ ) { %>			<tr>				<td style="text-align:center"><%=i+1 %></td>				<td><input type="checkbox" name="table_name_es" value="<%= list.getString(i, "TNAME") %>" id="id_<%= list.getString(i, "TNAME") %>"/><label for="id_<%= list.getString(i, "TNAME") %>"><%= list.getString(i, "TNAME") %> (<%= list.getString(i, "CNT") %>)</label></td>				<td><%=  HoValidator.isEmpty(list.getString(i, "TABLE_NAME")) ? "<span style='color:red'>미생성</span>" : list.getString(i, "TABLE_COMMENTS") %></td>				<td><%= list.getString(i, "TABLE_ALIAS") %></td>				<td style="text-align:center">					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=select&cs=Y&cf=Y&cw=Y')">S</a>					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=insert&cf=Y&ci=Y&cv=Y&cs=Y')">I</a>					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=update&cf=Y&cu=Y&cw=Y')">U</a>					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=merge&cf=Y&ci=Y&cv=Y&cs=Y')">M</a>					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=delete&cf=Y&cw=Y')">D</a>					<a href="javascript:fs_view('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=param')">P</a>					<a href="javascript:fs_info('<%=G_CONTEXTROOT %>/system/dataBase.do?owner=<%=OWNER%>&table_name=<%= list.getString(i, "TABLE_NAME") %>&type=info')">F</a>				</td>				<td style="text-align:center"><input type="checkbox" name="join" value="<%= list.getString(i, "TABLE_NAME") %>"></input></td>				<td style="text-align:center"><input type="checkbox" name="inline" value="<%= list.getString(i, "TABLE_NAME") %>"></input></td>			</tr>	<% } %>		</tbody>	</table></form></span><input type="button" value="Cache삭제 " onclick="fs_RemoveCache()">