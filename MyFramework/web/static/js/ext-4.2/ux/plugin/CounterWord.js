/**
 * 코드 수 확인..
 */
Ext.define('Ext.ux.plugins.CounterWord', {
    extend: 'Ext.util.Observable',
    alias: 'plugin.counterWord',
    
    constructor: function (config)
    {
        Ext.apply(this, config || {});
        this.callParent(arguments);
    },

    init: function (field)
    {
        field.on({
            scope: field,
            keyup: this.updateCounter,
            focus: this.updateCounter,
            change : this.updateCounter
        });
        if (!field.rendered) {
            field.on('afterrender', this.handleAfterRender, field);
            field.on('afterrender', this.updateCounter, field);
        } else {
            this.handleAfterRender(field);
        }
    },

    handleAfterRender: function(field, plugin)
    {
    	var labelCmp = field.fieldLabelId ? Ext.getCmp(field.fieldLabelId) : field;
    	
    	labelCmp.counterEl = labelCmp.labelEl.appendChild({ // appendChild  insertAfter
	    	tag: 'span',
	    	style: 'width: 100%;text-align:center;margin-right:10px;',
	    	html: ''
	    },  'after');
        this.tip = Ext.create('Ext.tip.ToolTip', {
        	title : labelCmp.getFieldLabel(),
            target: labelCmp.counterEl,
            html: ''
        });

        
	    field.enableKeyEvents = true;
    },

    updateCounter: function(textField)
    {	

    	var labelCmp = textField.fieldLabelId ? Ext.getCmp(textField.fieldLabelId) : textField;

    	if( textField.getValue()  ) {
    		var w = textField.getValue().slice(0,-1);
	    	var x = w.split(",").length;
	    	labelCmp.counterEl.update( x == 0 ? '' : (' ['+ x +']') ); // textField.getValue().length
	        
	        if( this.tip ) {
	        	this.tip.update(textField.getValue())
	        }
    	}
    }
    
});