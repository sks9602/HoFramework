<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:functions  targetId="form_1">

	<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
	alert( 'Example.v_tpl.jsp -> 저장');
	</jun:function>
	
	<jun:function action="삭제" args=" table_name" fields="Sample.selectTableInfo">
	alert( 'Example.v_tpl.jsp -> 삭제');
	</jun:function>

</jun:functions>

<jun:functions  targetId="grid_1">

	<jun:function action="상세조회" args=" table_name">
	Ext.Msg.prompt( "입력", "날짜 수", function(buttonId, text) {
		if( Ext.isNumeric(text)) {
			var cmpTpl = Ext.getCmp('${p_action_flag}_detail_form_1');

			var myMask = new Ext.LoadMask(cmpTpl, {msg:"생성 중입니다. <br/>잠시만 기다려주세요...."});
			myMask.show();

			cmpTpl.removeAll();	
		
			Ext.Function.defer(	function() {
				var dt = new Date(); // ('1/10/2016 03:05:01 PM GMT-0600');
			
				var itemGrids = new Array();
				for( var x=0 ; x < text ; x++) {
					var dt1 = Ext.Date.add(dt, Ext.Date.DAY, x);
					
					//요일 조회.
					var day = Ext.Date.format(dt1, 'D');
					
					if( day == '일'  ) {
						continue;
					}
					
					var itemGrid = 	<jun:item>
										<jun:section title="" maxItem="4" id="random">
											<jun:itemText  type="text"  id="random" name="mail" title="E-mail"  vtype="email" colspan="4"></jun:itemText>
											<jun:itemGrid id="random" action="/example/example.do" page="5" fields="Sample.selectTableList" width="800" height="200" editable="Y"> <!--  lead="checkbox"  -->
												<jun:columns>
													<jun:column title="이름" column="TNAME"  width="150" align="left" ></jun:column>
													<jun:column title="이름2" column="TABLE_NAME" width="150"></jun:column>
													<jun:column title="설명" column="TABLE_COMMENTS" flex="1" align="left" width="100" editor="textfield">
														<jun:columnText type="text" require="Y"></jun:columnText>
													</jun:column>
												</jun:columns>
											</jun:itemGrid>
										</jun:section>
									</jun:item>;
					
					itemGrid.setTitle( '&nbsp;' + Ext.Date.format(dt1, 'Y.m.d (D)') );
					
					if( x != 0  ) {
						itemGrid.collapse();
					}
					
					itemGrids.push(itemGrid);
					// cmpTpl.add( itemGrid );	
				}
				
				var panelItem =	<jun:itemPanel id="panel_1" action="/example/example.do" title="상세정보" position="center">
										<jun:itemText  type="text"  id="random" name="mail" title="E-mail"  vtype="email" colspan="4"></jun:itemText>		
								</jun:itemPanel>;
				
				itemGrids.push(panelItem);
				// cmpTpl.add(panelItem);	
				
				cmpTpl.add(itemGrids);
				
				myMask.hide();
			}, 5 );
		}
	}, {}, false, 5 );

	
	</jun:function>
	
	<jun:function action="펼치기">
		var form_1 = Ext.getCmp('v_tpl_detail_form_1');
		
		var sections = form_1.query('fieldset');
		for( var x in sections ) {
			sections[x].expand();
		}
	</jun:function>
	
	<jun:function action="접기">
		var form_1 = Ext.getCmp('v_tpl_detail_form_1');
		
		var sections = form_1.query('fieldset');
		for( var x in sections ) {
			sections[x].collapse();
		}
	</jun:function>
	
	
</jun:functions>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:grid id="grid_1" action="/example/example.do"  width="500" fields="Sample.selectTableList" editable="Y" position="west" button="상세조회,펼치기,접기">
			<jun:columns>
				<jun:column title="학습일자" column="EDU_DT"  width="150" align="left" ></jun:column>
				<jun:column title="Combo Editor" column="email2" width="100" resize="N" sortable="N"  editor="combotipple" >
					<jun:columnCode type="combo" groupCode="SYS001"  ></jun:columnCode>
				</jun:column>
				<jun:columnGrp title="교시">
					<jun:column title="0교시" column="COLUMN_YN"  width="60"></jun:column>
					<jun:column title="8/9/10교시" column="OWNER"  width="100" ></jun:column>
				</jun:columnGrp>
			</jun:columns>
		</jun:grid>
				
		<jun:form id="form_1" action="/example/example.do" title="상세정보" button="저장,삭제" position="center">
		
		</jun:form>
	</jun:data>
</jun:body>