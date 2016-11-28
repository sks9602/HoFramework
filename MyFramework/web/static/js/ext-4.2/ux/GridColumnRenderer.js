


GridColumnRenderer = function() {

}

GridColumnRenderer.rowspanRenderer = function(value, meta, record, rowIndex, colIndex, store) {
	var getId = this.dataIndex; // 'industry'
	var first = !rowIndex || value !== store.getAt(rowIndex - 1).get(getId),
	    last = rowIndex >= store.getCount() - 1 || value !== store.getAt(rowIndex + 1).get(getId);
	meta.css += 'row-span' + (first ? ' row-span-first' : '') +  (last ? ' row-span-last' : '');
	if (first) {
		var i = rowIndex + 1;
		while (i < store.getCount() && value === store.getAt(i).get(getId)) {
			i++;
		}
		var rowHeight = 20, padding = 6,
			height = (rowHeight * (i - rowIndex) - padding) + 'px';
		meta.attr = 'style="height:' + height + ';line-height:' + height + ';"';
	}
	return first ? value : '';
}

GridColumnRenderer.renderBool = function(v) {
    var checkedImg   = '/s/static/js/ext-4.2/resources/ext-theme-classic/images/menu/checked.gif';
    var uncheckedImg = '/s/static/js/ext-4.2/resources/ext-theme-classic/images/menu/unchecked.gif';
    
    return String.format('<div style="text-align:center;height:13px;overflow:visible"><img style="vertical-align:-3px" src="{0}" /></div>', (v ? checkedImg : uncheckedImg));
    /*
    var cb = '<div style="text-align:center;height:13px;overflow:visible"><img style="vertical-align:-3px" src="'
        + (v ? checkedImg : uncheckedImg)
        + '" /></div>'
    ;
    return cb;
    */
}  

/**
 * 소수 조회..
 */
GridColumnRenderer.decFormat = function(v, defalutVal, precision) {
	if( Ext.isNumeric( v ) ) {
		var p = "".rpad('0', precision||2 );
		
		return Ext.util.Format.number(v, '0,0.'+p);		
	} else {
		return defalutVal||'-';
	}
}

/**
 * 소수 조회..
 */
GridColumnRenderer.signDecFormat = function(v, precision) {
	var val = GridColumnRenderer.decFormat(v, precision);
	
	if( val.charAt(0) == '0' || val.charAt(0) == '-' ) {
		return val;
	} else {
		return '+'+val;
	}
}

/**
 * 정수 조회..
 */
GridColumnRenderer.intFormat = function(v) {
	if( Ext.isNumeric( v ) ) {
		return Ext.util.Format.number(v, '0,0');
	} else {
		return '0';
	}
}

GridColumnRenderer.signIntFormat = function(v) {
	var val = GridColumnRenderer.intFormat(v);
	
	if( val == '0' || val.charAt(0) == '-' ) {
		return val;
	} else {
		return '+'+val;
	}
}

/**
 * 부호없는 소수점..
 */
GridColumnRenderer.decRendererFormat = function() {
	return "<div style='text-align:right;'>{1}</div>"
}

GridColumnRenderer.decRenderer = function(value, p, rec) {
	return String.format(GridColumnRenderer.decRendererFormat(), value, GridColumnRenderer.decFormat(value));
}


/**
 * 부호있는 소수점..
 */
GridColumnRenderer.signDecimalRenderer = function(value, p, rec) {
	
}

/**
 * 부호대신 색깔 있는 소수점..
 */
GridColumnRenderer.colorDecimalRenderer = function(value, p, rec) {
	
}

/**
 * 부호없는 통화(금액)점..
 */
GridColumnRenderer.moneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호있는 통화(금액)점..
 */
GridColumnRenderer.signMoneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호대신 색깔 통화(금액)점..
 */
GridColumnRenderer.colorMoneyRenderer = function(value, p, rec) {
	
}

/**
 * 부호없는 정수..
 */
GridColumnRenderer.intRenderer = function(value, p, rec) {
	
}

/**
 * 부호있는 정수..
 */
GridColumnRenderer.signIntRenderer = function(value, p, rec) {
	
}
/**
 * 부호대신 색깔 정수..
 */
GridColumnRenderer.colorIntRenderer = function(value, p, rec) {
	
}

/**
 * 좌파정렬
 */
GridColumnRenderer.alignLeftRenderer = function(value, p, rec) {
	
}

/**
 * 중도정렬
 */
GridColumnRenderer.alignCenterRenderer = function(value, p, rec) {
	
}

/**
 * 우파정렬
 */
GridColumnRenderer.alignRightRenderer = function(value, p, rec) {
	
}

/**
 * 날짜
 */
GridColumnRenderer.dateRenderer = function(value, p, rec) {
	
}
