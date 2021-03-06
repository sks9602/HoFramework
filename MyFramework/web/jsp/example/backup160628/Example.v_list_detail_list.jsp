<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="목록" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">

	var buttons = []
	buttons.push({
		        type : 'buttons',
		        text : 'It Does',
		        iconAlign : 'top',
		        // icon : 'images/tick.png',
		        handler : function() {
		        	alert(1);
		        }
		    });
	buttons.push({
		        type : 'buttons',
		        text : 'It Doesn\'t',
		        iconAlign : 'top',
		        // icon : 'images/cross.png',
		        handler : function() {
		        	alert(2);
		        }
		    });
	buttons.push({
		        type : 'buttons',
		        text : 'Dunno',
		        iconAlign : 'top',
		        // icon : 'images/delete.png',
		        handler : function() {
		        	alert(3);
		        }
		    });
	buttons.push({
		        type : 'buttons',
		        text : 'Dunno1',
		        iconAlign : 'top',
		        // icon : 'images/delete.png',
		        handler : function() {
		        	alert(4);
		        }
		    });
	buttons.push({
		        type : 'buttons',
		        text : 'Dunno2',
		        iconAlign : 'top',
		        // icon : 'images/delete.png',
		        handler : function() {
		        	alert(5);
		        }
		    });	    
	hoCustomMessage("Test Big Buttons", "Does the buttons show correctly? Does it, does it, does it does does it?", buttons );

	Ext.MessageBox.show({
	    title:'Messagebox Title',
	    msg: 'Are you sure want to delete?',
	    buttonText: { 
	    	ok : 'Some Button 0',
	        yes: 'Some Button 1',
        	no: 'Some Button 2',
        	cancel: 'Some Button 3'
	    }
	});
	
</jun:function>

<jun:function action="검색" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="초기화" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
</jun:function>

<jun:function action="추가" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
alert( 'Example.v_list_detail_list.jsp -> 추가');
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:form section="search" action="/example/example.do" button="목록,조회,검색" position="north">
		<jun:item_search  type="text"   name="" title="E-mail"       ></jun:item_search>
		<jun:item_search  type="combo"  name="" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
		<jun:item_search  type="radio"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
		<jun:item_search  type="checkbox"  name="" title="제목"    groupCode="B20" first="all"></jun:item_search>
	</jun:form>

	<jun:data ><!-- layout :  vbox, tab -->
		<jun:grid action="/example/example.do"  width="500" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:columns>
		</jun:grid>
	</jun:data>
	<jun:data position="east" title="오른쪽 정보" >
		<jun:form action="/example/example.do" title="상세정보" button="초기화" id="dtl1" position="north">
			<jun:section title="섹션 E-mail">
				<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
				<jun:item_detail  type="text"   name="" title="E-mail"       ></jun:item_detail>
			</jun:section>
			<jun:section title="섹션 COMBO">
				<jun:item_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:item_detail>
			</jun:section>
			<jun:item_detail  type="radio"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
			<jun:item_detail  type="checkbox"  name="" title="제목"    groupCode="W02" first="all"></jun:item_detail>
		</jun:form>

		<jun:grid id="grid_1" action="/example/example.do" button="추가" page="10" lead="checkbox" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="이름" column="table_name" locked="Y" renderer="function" editor="link" >
					function (value, p, record){
						/*
						var arg = [];
						for( var x in record.data ) {
							arg.push("'"+x+"' : "+ "'" + record.data[x]  +"'")
						}
						*/

						return Ext.String.format(
							"<div style=\"cursor:hand;\" onclick=\"fs_클릭('{1}');\"><b>{0}</b></div>",
						value,
						record.data.table_name,
						// "{"+ arg.join(",")+"}",
						p );
					}
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
</jun:body>