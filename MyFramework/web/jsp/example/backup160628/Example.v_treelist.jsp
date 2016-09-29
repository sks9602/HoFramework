<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
%>
<%@ include file="/jsp/common/include/include_include.jsp"
%><%@ taglib prefix="jun"  tagdir="/WEB-INF/tags" %>
<jun:function action="다운로드" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	fs_AddTab_v_tree_detail(args);

	if( Ext.getCmp('v_list_list')) {
		fs_AddTab_v_detail_list();
	}

	if( !Ext.getCmp('v_list_detail_list')) {
		fs_AddTab_v_list_detail_list();
	}

	if( Ext.getCmp('v_list_detail')) {
		fs_AddTab_v_list_list();
	}

	if( Ext.getCmp('v_detail')) {
		fs_AddTab_v_list_detail();
	}
	if( !Ext.getCmp('v_detail')) {
		fs_AddTab_v_detail();
	}

	// Tab (Example.v_tpl.jsp) 생성
	fs_AddTab_v_tpl();
	// Example.v_tpl.jsp에 item추가
	var cmpTpl = Ext.getCmp('v_tpl_data_tab_idx_1');
	// item추 가
	cmpTpl.add({ xtype: 'fieldcontainer', layout: { type: 'hbox', defaultMargins: {top: 0, right: 5, bottom: 0, left: 0} }
				, items: [{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: 'E-mail',labelSeparator : '',
							msgTarget: 'side'
						},{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: '다른 Title',labelSeparator : '',
							msgTarget: 'side'
						}]
				});
	cmpTpl.add([{
							xtype     : 'textfield',
							width:          300,
							name      : '',
							fieldLabel: 'E-mail',labelSeparator : '',
							msgTarget: 'side'
						},{
							xtype     : 'textfield',
							width:          300,
							id : 'zzzzzzzzzz',
							name      : '',
							fieldLabel: '다른 Title',labelSeparator : '',
							msgTarget: 'side'
						}]);	
	// item삭제 테스트...
	cmpTpl.remove('zzzzzzzzzz');
						
	fs_AddTab_v_list_tab_list();
	
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');
	/*
	for( var i in args) {
 		var tgt = Ext.DomQuery.select('div[id=v_tree_detail] *[name='+i+']');
 		for(var j=0; j< tgt.length ; j++ ) {
 			tgt[j].value = args[i];
 		}

	 	var tgt2 = Ext.DomQuery.select('div[id=v_tree_detail] *[id='+i+'_label]');

	 	for(var j=0; j< tgt2.length ; j++ ) {
			Ext.get(tgt2[j].id).update(args[i]);
	 	}
	}
	*/

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('id_detail_v_tree_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}
		// TODO
        //form.loadRecord(_records[0]);
	});
	<jun:window id="id_window_1" >
		<jun:grid action="/example/example.do" title="두번째 목록 타이틀.." id="id_2" page="3" width="500" fields="Sample.selectTableList">
			<jun:columns>
				<jun:column title="성명" column="NAME" ></jun:column>
				<jun:column title="사번" column="MEMBER_NO" ></jun:column>
			</jun:columns>
		</jun:grid>
	</jun:window>
</jun:function>

<jun:function action="조회Depricated" args=" table_name, comments">
	// Ext.Msg.show({title : '버튼 호출..', msg : 'here', buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
	fs_AddTab_v_list_anchor();
	fs_AddTab_v_tree_detail();


	if( Ext.getCmp('v_list_list')) {
		fs_AddTab_v_detail_list();
	}

	if( !Ext.getCmp('v_list_detail_list')) {
		fs_AddTab_v_list_detail_list();
	}

	if( Ext.getCmp('v_list_detail')) {
		fs_AddTab_v_list_list();
	}

	if( Ext.getCmp('v_detail')) {
		fs_AddTab_v_list_detail();
	}
	if( !Ext.getCmp('v_detail')) {
		fs_AddTab_v_detail();
	}
	fs_AddTab_v_tpl();

	hoConfirm('Are you sure you want to do that?', function(btn) {
		if( btn == 'yes' ) {
			if( this.up('form').getForm().isValid() ) {
				var param = getParam(this, 'b_insert');

				Ext.Ajax.request({
	                                url: '/s/example/example.do',
	                                method: 'POST',
	                                params: param,
	                                success : function(response,options){
										hoMessage('성공..');
	                                },
	                                failure: function(){
	                                	/*
										for( var x in arguments[0] ) {
											alert( arguments[0][x])
										}
										for( var x in arguments[1] ) {
											alert( arguments[1][x])
										}
										for( var x in arguments[2] ) {
											alert( arguments[2][x])
										}
										*/
	                                    hoError('오류');
	                                },
	                                scope: this
	                            });
			}
			// Ext.Msg.show({title : '버튼 호출..', msg : 'btn [' + btn +']' , buttons: Ext.Msg.YESNO, icon: Ext.Msg.QUESTION});
		} else {
			// hoError('다운로드');
		}
	}, this );

</jun:function>

<jun:function action="추가" args=" table_name" fields="Sample.selectTableInfo">
	// var store = Ext.getStore('v_treelist_store_grid_grid_1');
	
	var tree = this.up('treepanel');
	
	var store = tree.getStore();
	var node = tree.getSelectionModel().getSelection();
	
	if( node ) {
		var ran = Math.round(Math.random()*10000000);
		if( node[0].get('leaf') ) {
			node[0].set('leaf', false); 
		}
		
		try {
			node[0].appendChild({
	        id: 'gc_'+ran,
	        text: '* No Title',
	        mode : 'insert',
	        // name: '* No Title',
	        leaf: true
		});
			
			node[0].expand();
		} catch(e) {
			alert('2 :'  + e);
		}
	}

</jun:function>

<jun:function action="저장" args=" table_name" fields="Sample.selectTableInfo">
	var store = Ext.getStore('v_treelist_store_grid_grid_1');
	
	// 파라미터 추가 SinglePost.js에서 처리
	store.getProxy().getWriter().setParams({'bb':'bb', 'cc':'cc'});
	// form추가.. SinglePost.js에서 처리
	store.getProxy().getWriter().setParams('v_treelist_detail_form1');
	// Outline.all_in_one.jsp에 선언됨..
	store.submit('저장', {
		callback : function() {
			store.reload()
		}, 
		success : function(batch, option) {
			alert('성공');
		}, 
		failure : function() {
		 	alert('실패');
		}
	});
	
	// store.sync({});
</jun:function>


<jun:function action="클릭" args=" table_name" url="/s/example/example.do?p_action_flag=r_detail"  fields="Sample.selectTableInfo">
	fs_AddTab_v_tree_detail(args);
	Ext.getCmp('id_main_tabpanel').setActiveTab('v_tree_detail');

	store.on("load", function(_this, _records, _successful, _eOpts ) {

		var form = Ext.getCmp('v_tree_detail_detail_dtl_1');
		//for( var i in  _records[0].data ) {
			// alert( i );
		//}

        form.loadRecord(_records[0]);
	});
	
	Ext.getCmp('id_main_tabpanel').setTitle('Example.v_list.jsp의 클릭에서 Title변경..');
</jun:function>

<jun:body pageIndex="<%= TAB_INDEX %>">
	<jun:data>
		<jun:form section="search"  button="조회,다운로드" action="/example/example.do" gridId="grid_1" position="north">
			<jun:item_search  type="text"   name="mail" title="E-mail"  vtype="email"     ></jun:item_search>
			<jun:item_search  type="combo"  name="title1" title="타이틀"  groupCode="B20" first="none"></jun:item_search>
			<jun:item_search  type="period"  name="edu_dt" title="학습시작일" value="week"></jun:item_search>
			<jun:item_searchCode  type="checkbox"  name="animal" title="Checkbox"    groupCode="B20" first="all" value="B2010,B2020"></jun:item_searchCode>
			<jun:item_search  type="radio"  name="color"  title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="checkbox"  name="animal" title="제목"    groupCode="B20" first="all"></jun:item_search>
			<jun:item_search  type="text"   name="table_nm" title="테이블명"       ></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_json_tree" ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		</jun:form>
		<jun:form section="detail"  button="다운로드" action="/example/example.do" gridId="grid_1" hidden="Y" id="form1">
			<jun:item_search  type="text"   name="table_nm" title="테이블명"       ></jun:item_search>
			<jun:item_search  type="hidden"  name="p_action_flag" value="r_list_data" ></jun:item_search>
			<jun:item_search  type="text"   name="mail" title="E-mail"       ></jun:item_search>
		</jun:form>
		<jun:data>
			<jun:treegrid id="grid_1" action="/example/example.do" button="추가,저장" page="5" lead="checkbox" fields="Sample.selectTableList" >
				<jun:toolbars>
					<jun:toolbar_detail  type="combo"  name="" title="타이틀"  groupCode="B02" first="none"></jun:toolbar_detail>
					<jun:toolbar_detail  type="button"  name="" title="타이틀" ></jun:toolbar_detail>
				</jun:toolbars>
				<jun:columns>
					<jun:treecolumn title="이름" column="text" locked="Y" align="left" renderer="function" editor="textfield" > <!--  locked="Y" 때문에 editor안됨.. -->
						function (value, p, record){
							return Ext.String.format(
								"<span style=\"cursor:pointer;text-align:left;\" onclick=\"hoAlert('{0}', Ext.emptyFn, 2000);\"><b>{0}</b></span>",
							value,
							record.data.text,
							p );
						}
					</jun:treecolumn>
					<jun:column title="설명" column="id" flex="1" align="left" width="200" editor="textfield"></jun:column>
					<jun:column title="E-Mail" column="email" width="100" resize="N" sortable="N" editor="email" ></jun:column>
					<jun:column title="팩스" column="fax_number"  width="150" editor="numberfield, minValue:10, maxValue:100"  renderer="rowspanRenderer"></jun:column>
					<jun:columnGrp title="연락처">
						<jun:column title="전화번호" column="phone_number"  width="150" editor="editors" >
							getEditor : function( record, defaultField) { 
		                        if ( record.get('table_name') == 'COMPET' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Text')
		                            });
		                        } else if ( record.get('table_name') == 'CERT_INFO' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Date')
		                            });
		                        } else if ( record.get('table_name') == 'S_ZIP_CODE' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: { xtype : 'checkboxfield'} 
		                                	/* {
									            xtype      : 'radiogroup',
									            layout: 'hbox',
									            items: [
									                {
									                    boxLabel  : 'Blue',
									                    name      : 'color',
									                    inputValue: 'blue',
									                    id        : 'radio4'
									                }, {
									                    boxLabel  : 'Grey',
									                    name      : 'color',
									                    inputValue: 'grey',
									                    id        : 'radio5'
									                }, {
									                    boxLabel  : 'Black',
									                    name      : 'color',
									                    inputValue: 'black',
									                    id        : 'radio6'
									                }
									            ]
									        } */
		                            });
		                        } else if ( record.get('table_name') == 'HR_RESUME_TRAIN' ) {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: {
								            xtype      : 'checkboxgroup',
								            layout: 'hbox',
								            items: [
								                {
								                    boxLabel  : 'Blue',
								                    name      : 'animal',
								                    inputValue: 'blue',
								                    id        : 'radio4'
								                }, {
								                    boxLabel  : 'Grey',
								                    name      : 'animal',
								                    inputValue: 'grey',
								                    id        : 'radio5'
								                }, {
								                    boxLabel  : 'Black',
								                    name      : 'animal',
								                    inputValue: 'black',
								                    id        : 'radio6'
								                }
								            ]
								        }
		                            });
		                        } else {
		                            return Ext.create('Ext.grid.CellEditor', {
		                                field: Ext.create('Ext.form.field.Number')
		                            });
		                        }
							}
						</jun:column>
						<jun:column title="휴대폰번호" column="TABLE_TYPE"  width="150" editor="checkbox" storeId="v_list_store_grid_grid_1">
							function( _column, _rowIndex, _checked, _eOpts) {  
								
								var store = Ext.getStore('v_list_store_grid_grid_1');
								
								var record = store.getAt(_rowIndex);
								var columnIndex = _column.getIndex();
								
								record.set('hp_number', _checked );
							}
						</jun:column>
					</jun:columnGrp>
					<jun:column title="팩스" column="fax_number"  width="150" renderer="actioncolumn">
					 items: [{
		                    icon   : '/s/static/js/ext-4.2/ux/image/fam/delete.gif',  // Use a URL in the icon config
		                    tooltip: 'Sell stock',
		                    handler: function(grid, rowIndex, colIndex) {
		                    	var store = grid.getStore();
		                        var rec = store.getAt(rowIndex);
		                        alert("Sell " + rec.get('table_comments'));
		                    }
		                }, {
		                    getClass: function(v, meta, rec) {          // Or return a class from a function
		                        if ( rec.get('table_name') ==  'HR_CONSULTING') {
		                            return 'alert-col';
		                        } else {
		                            return 'buy-col';
		                        }
		                    },
		                    getTip: function(v, meta, rec) {
		                        if ( rec.get('table_name') ==  'HR_CONSULTING' ) {
		                            return 'Hold stock';
		                        } else {
		                            return 'Buy stock -' + rec.get('table_name') ;
		                        }
		                    },
		                    handler: function(grid, rowIndex, colIndex) {
		                    	var store = grid.getStore();
		                        var rec = store.getAt(rowIndex);
		                        alert((rec.get('table_name') ==  'HR_CONSULTING' ? "Hold " : "Buy ") + rec.get('table_name'));
		                    }
		                }]
					</jun:column>
				</jun:columns>
				<jun:gridViewConfig></jun:gridViewConfig>
			</jun:treegrid>
		</jun:data>
	</jun:data>
</jun:body>