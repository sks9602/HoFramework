<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:functions  targetId="search_1">
	<jun:function action="목록" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>

	<jun:function action="검색" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>

</jun:functions>

<jun:functions  targetId="dtl1">

	<jun:function action="초기화" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
</jun:functions>

<jun:functions  targetId="dtl2">

	<jun:function action="초기화2" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	</jun:function>
</jun:functions>

<jun:functions  targetId="grid_2">
	
	<jun:function action="추가" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	alert( 'Example.v_list_formlist.jsp -> 추가');
	</jun:function>

	<jun:function action="클릭" args=" table_name" url="/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	alert( 'Example.v_list_formlist.jsp -> 클릭');
	</jun:function>
</jun:functions>

<jun:printScriptOut>
	function fs_${p_action_flag}_클릭() {
		alert('fs_${p_action_flag}_클릭()');
	}
</jun:printScriptOut>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" id="search_1" action="/example/example.do" gridId="grid_1" button="목록,조회,검색" position="north">
		<jun:itemText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:itemText>
		<jun:itemText  type="text"   name="email" title="E-mail"       ></jun:itemText>
		<jun:itemCode  type="combo"  name="combo1" title="타이틀"  groupCode="SYS001" colspan="3"></jun:itemCode>
		<jun:itemCode  type="checkbox"  name="checkbox1" title="제목"    groupCode="SYS003" colspan="4"></jun:itemCode>
		<jun:itemCode  type="radio"  name="radio1" title="제목"    groupCode="SYS002" colspan="4"></jun:itemCode>
	</jun:form>

	<jun:data><!-- layout :  vbox, tab -->
		<jun:grid id="grid_1" action="/example/example.do"  width="500" fields="Sample.selectTableList" page="5" position="west">
			<jun:columns>
				<jun:column title="성명" column="TNAME" flex="1"></jun:column>
				<jun:column title="사번" column="TABLE_NAME" ></jun:column>
			</jun:columns>
		</jun:grid>
		<jun:data>
			<jun:form section="search" id="search_2" action="/example/example.do" gridId="grid_2" title="검색조건2" position="north">
				<jun:itemText  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:itemText>
				<jun:itemText  type="text"   name="email" title="E-mail"       ></jun:itemText>
				<jun:itemCode  type="combo"  name="combo1" title="타이틀"  groupCode="SYS001" colspan="3"></jun:itemCode>
				<jun:itemCode  type="checkbox"  name="checkbox1" title="제목"    groupCode="SYS003" colspan="4"></jun:itemCode>
				<jun:itemCode  type="radio"  name="radio1" title="제목"    groupCode="SYS002" colspan="4"></jun:itemCode>
			</jun:form>
			<jun:grid id="grid_2" action="/example/example.do" button="추가" page="10" lead="radio" fields="Sample.selectTableList">
				<jun:columns>
					<jun:column title="이름" column="table_name" locked="Y" renderer="function" editor="link" >
						renderer : function (value, p, record){
	
							return Ext.String.format(
								"<div style=\"cursor:hand;\" onclick=\"fs_${p_action_flag}_클릭('{1}');\"><b>{0}</b></div>",
							value,
							record.data.table_name,
							// "{"+ arg.join(",")+"}",
							p );
						},
					</jun:column>
					<jun:column title="설명" column="table_comments" flex="1" align="left" width="200" editor="textfield"></jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" ></jun:column>
					<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
					<jun:columnGrp title="연락처">
						<jun:column title="전화번호" column="phone_number"  width="150"></jun:column>
						<jun:column title="휴대폰번호" column="hp_number"  width="150"></jun:column>
					</jun:columnGrp>
				</jun:columns>
			</jun:grid>

		</jun:data>
	</jun:data>
</jun:body>