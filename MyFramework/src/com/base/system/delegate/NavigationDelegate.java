package com.base.system.delegate;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import com.base.system.delegate.validator.SampleValidator;

import project.jun.config.HoConfig;
import project.jun.dao.HoDao;
import project.jun.dao.parameter.HoQueryParameterHandler;
import project.jun.dao.parameter.HoQueryParameterMap;
import project.jun.dao.result.HoList;
import project.jun.dao.result.HoMap;
import project.jun.delegate.HoDelegate;
import project.jun.delegate.validator.HoViolationMap;
import project.jun.util.HoLogging;
import project.jun.util.HoSpringUtil;
import project.jun.was.HoModel;
import project.jun.was.parameter.HoParameter;
import project.jun.was.result.exception.HoException;
import project.jun.was.result.message.HoMessage;
import project.jun.was.spring.HoController;

public class NavigationDelegate extends HoDelegate {

	/**
	 * 기능 목록 조회
	 * @param actionFlag
	 * @param model
	 * @param parameter
	 * @param hoConfig
	 * @return
	 * @throws HoException
	 */
    public Object list(String actionFlag, HoModel model, HoParameter parameter, HoConfig hoConfig) throws HoException, Exception {

		HoDao dao = this.getHoDao();

		HoQueryParameterHandler hqph = new HoQueryParameterHandler(parameter, hoConfig);

		HoQueryParameterMap value = hqph.getForSearch();

		// 파라미터 유효성 검사 - 시작..
		SampleValidator sv = new SampleValidator(dao);
		parameter.infoParameter(true);
		parameter.infoParameterValue(true);

		HoViolationMap hoViolationMap = sv.validate(actionFlag, model, parameter, hoConfig);

		logger.warn( HoLogging.toString(hoViolationMap.getViolationParameterNames()) );
		// 파라미터 유효성 검사 - 끝..

		HoList list = dao.select("Menu.selectAdminToolMenuList", value);

		model.put( KEY_JSON_DATA , list);

		ArrayList<String []> pageList = new ArrayList<String []>();
		if( "/system/menu.do".equals(parameter.get("action")) ) {
			pageList.add(new String[]{"/system/menu.do", "v_treelist_detail", "메뉴 관리"});		
		} else if( "/system/auth.do".equals(parameter.get("action")) ) {		
			pageList.add(new String[]{"/system/auth.do", "v_auth_menu", "권한 관리"});
			pageList.add(new String[]{"/system/auth.do", "v_treelist_auth", "권한별 메뉴"});
		} else if( "/example/example.do".equals(parameter.get("action")) ) {					
			pageList.add(new String[]{"/example/example.do", "v_list", "예제 조회"});
			pageList.add(new String[]{"/example/example.do", "v_detail_list", "상세+목록(탭)"});
			pageList.add(new String[]{"/example/example.do", "v_list_tab_list", "목록+탭+목록(탭)"});
			pageList.add(new String[]{"/example/example.do", "v_detail", "상세(탭)"});
			pageList.add(new String[]{"/example/example.do", "v_tree_detail", "트리+상세 조회"});
			pageList.add(new String[]{"/example/example.do", "v_list_list", "목록+목록"});
			pageList.add(new String[]{"/example/example.do", "v_list_formlist", "목록+(검색조건)목록"});
			
			pageList.add(new String[]{"/example/example.do", "v_tpl", "TPL 생성"});
		}
		model.put( "PAGE_LIST_DATA" , pageList);

    	return null;
    }


}
