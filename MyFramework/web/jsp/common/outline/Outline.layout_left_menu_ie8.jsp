<%@ page language="java" contentType="text/html;  charset=utf-8" pageEncoding="utf-8"%><%@ page	import="project.jun.dao.result.HoList"%><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@include file="/jsp/common/include/include.jsp"%><html>	<head>		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">		<title>#{PROJECT NAME}</title>		<style type="text/css">		p {		    margin:5px;		}				</style>		<link rel="stylesheet" type="text/css" href="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/resources/css/ext-all.css" />				<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ext-base-debug.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ext-all-debug.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/FitToParent.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/ux-all.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/ux-add.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/FeedPanel.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/multidom.js" ></script>		<script type="text/javascript" src="<%= G_CONTEXTROOT %>/static/ext/extJs3.1/ux/mif.js" ></script>				<script>		var G_CONTEXTROOT = '<%=G_CONTEXTROOT%>';    	var feeds = new FeedPanel({ region:'west'});<%	HoList menuList = model.getHoList("listMenu");%> 	   <% for ( int i=0 ; i<menuList.size() ; i++ ) {   			// 하위메뉴만 보이기 일 경우..  			if( !param.get("menu_id").equals("") ) {  				if(  menuList.getString(i, "MENU_ID").startsWith(param.get("menu_id").substring(0,3))) {	  	%>  			feeds.addFeed({  				iconCls : 'none <%= menuList.getString(i, "ICON_CLS")%>',  				cls : '<%= menuList.getString(i, "MENU_ID").equals(param.get("menu_id")) ? "menu x-tree-selected" : "menu" %>',             		expanded: <%= menuList.getString(i, "MENU_ID").length() == 3 || menuList.getString(i, "MENU_ID").equals(param.get("menu_id").substring(0,param.get("menu_id").length()-2)) ? "true" : "false"%>,  				menu_id : '<%= menuList.getString(i, "MENU_ID")%>',  				p_menu_id : '<%= menuList.getString(i, "P_MENU_ID")%>',   		        url:'<%= menuList.getString(i, "PGM_URL")%>',  		        text: '<%= menuList.getString(i, "MENU_NAME")%>'  		    }, false, false);  	<%  				}  			} else {  	%>  				feeds.addFeed({  					iconCls : 'none <%= menuList.getString(i, "ICON_CLS")%>',  					cls : '<%= menuList.getString(i, "MENU_ID").equals(param.get("menu_id")) ? "menu x-tree-selected" : "menu" %>',             			expanded: <%= !param.get("menu_id").equals("") && ( menuList.getString(i, "MENU_ID").equals(param.get("menu_id").substring(0,param.get("menu_id").length()-4)) || menuList.getString(i, "MENU_ID").equals(param.get("menu_id").substring(0,param.get("menu_id").length()-2))) ? "true" : "false"%>,   					menu_id : '<%= menuList.getString(i, "MENU_ID")%>',  					p_menu_id : '<%= menuList.getString(i, "P_MENU_ID")%>',   			        url:'<%= menuList.getString(i, "PGM_URL")%>',  			        text: '<%= menuList.getString(i, "MENU_NAME")%>'  			    }, false, false);  	<% 			  			}  		}   	%>		feeds.addFeed({				iconCls : 'none ',				cls : 'menu',     			expanded: false, 				menu_id : 'BB01',				p_menu_id : 'B', 		        url:'/itinAdminWebApp/system/dataBase.do?p_action_flag=r_list',		        text: '프로그램샘플'		    }, false, false);	        var winLog;    var logData = [];    var storeLog = new Ext.data.SimpleStore({	        fields: [  {name: 'DateTime', type:'date'},			           {name: 'Mode'},			           {name: 'TabName'},			           {name: 'MENU_ID'},			           {name: 'Message'} ]		    });	storeLog.loadData(logData);	var tabDetails ;			Ext.onReady(function(){	    		        // NOTE: This is an example showing simple state management. During development,	        // it is generally best to disable state management as dynamically-generated ids	        // can change across page loads, leading to unpredictable results.  The developer	        // should ensure that stable state ids are set for stateful components in real apps.			Ext.state.Manager.setProvider(new Ext.state.CookieProvider());			var viewport = new Ext.Viewport({	            layout:'border',	            items:[	                new Ext.BoxComponent({ // raw	                    region:'north',	                    el: 'north',	                    height:78	                }), feeds, tabDetails = new Ext.TabPanel({	    				activeTab:0,	    				id : 'tabDetails',	    				region    :'center',	    				border: true,	    				enableTabScroll:true,	    				margins:'0 5 5 0',	    				tabPosition:'top', //'bottom', top	    				defaults: {autoScroll:true},	    				layoutOnTabChange: true,	    				autoScroll:true,	    	        	plugins: new Ext.ux.TabCloseMenu(),	    				items: [{ id: 'mainFrame_1',	    			             xtype : 'iframepanel',	    			             title: '메인화면',	    			             closable : false,	    			             defaultSrc : '/itinAdminWebApp/system/dataBase.do?p_action_flag=r_list' 	    						}, { id: 'mainFrame_2',		    			             xtype : 'iframepanel',		    			             title: '다음화면',		    			             closable : true,		    			             defaultSrc : '/itinAdminWebApp/system/dataBase.do?p_action_flag=r_list' 		    						}]	    	     })/*	                { xtype : 'iframepanel',  						region:'center', 		                id : 'id_iFrameMain',		               	margins:'0 5 5 0',                 		border: true,		                defaultSrc : '/itinAdminWebApp/system/dataBase.do?p_action_flag=r_list'} */	              ] 	        });	       new Ext.Button({	       		renderTo : 'id_log_btn',	       		text : 'Log',	       		handler : fs_ShowWinLog 	       });	       		    function fs_ShowWinLog(b, e){			    if(!winLog){		            winLog = new Ext.Window({		                id          : 'id-win-log',		                layout      : 'fit',		                // minimizable : true,		                width       : 750,		                height      : 300,		                closeAction :'hide',		                plain       : true,		                title       :'Log',		                tbar : [{		                    text     : 'Clear Log',		                    handler  : function(){		                    	logData = [];		                    	storeLog.removeAll();		                    }		                },'-',{		                    text     : 'Close',		                    handler  : function(){		                        winLog.hide();		                    }		                }],						items       : new Ext.grid.GridPanel({	                        border  : false,	                        store   : storeLog,	                        columns : [								{              header: "DateTime", width: 120, sortable: true, dataIndex: 'DateTime', renderer: Ext.util.Format.dateRenderer('Y-m-d  H:i:s'), align : 'center'},								{              header: "Mode"    , width: 60, dataIndex: 'Mode', align : 'center', renderer: function( value, p, record ) { if( value=='ERROR')  {return '<div style=\'color:red;\'>'+value+'<div>'} else {return value} } },								{              header: "Tab Name", width: 100, dataIndex: 'TabName', align : 'center'},								{              header: "MENU ID", width: 60, sortable: true, dataIndex: 'MENU_ID', align : 'center'},								{id:'Message', header: "Message", width: 200, dataIndex: 'Message'}	                        ],							stripeRows: true,							autoExpandColumn: 'Message',							height:200,							width:600                      						})		            });		        }				        winLog.show(b.getId());		    }		    	    });	    		function log(mode, title, menu_id, msg) {			logData.unshift([new Date() , mode, title, menu_id, msg]);						storeLog.loadData(logData);			 		}					</script>	</head>	<body>		<div id="north">			상단 CI / 로그인 정보 / 기능 BUTTON영역			<span id="id_log_btn"></span>		</div>		<div id="west"></div>		<div id="center"><!-- iframe id="id_iFrameMain" src="" style="width:100%;height:100%;border:0px"></iframe --></div>	</body></html>