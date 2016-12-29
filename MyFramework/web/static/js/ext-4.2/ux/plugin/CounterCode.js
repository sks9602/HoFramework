/**
 * 코드 수 확인..
 */
Ext.define('Ext.ux.plugins.CounterCode', {
    extend: 'Ext.util.Observable',
    alias: 'plugin.counterCode',
    
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
    	
	    field.counterEl = field.labelEl.appendChild({ // appendChild  insertAfter
	    	tag: 'span',
	    	style: 'width: 100%;text-align:center;margin-right:10px;',
	    	html: ''
	    },  'after');
        this.tip = Ext.create('Ext.tip.ToolTip', {
        	title : field.getFieldLabel(),
            target: field.counterEl,
            html: ''
        });

        
	    field.enableKeyEvents = true;
    },

    updateCounter: function(textField)
    {
    	if( textField.getValue() && typeof(textField.getValue()) === 'object' ) {
	    	var x = Object.keys( textField.getValue() ).length;
	        textField.counterEl.update( x == 0 ? '' : (' ['+ x +']') ); // textField.getValue().length
	        
	        if( this.tip ) {
	        	this.tip.update(textField.getRawValue())
	        }
    	}
    }
    
});