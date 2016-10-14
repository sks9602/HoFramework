/*
Usage 1:
{
    "xtype" : "radiogroupcolumn",
    "text" : "Radio Group Test",
    "width" : 160,
    "radioValues" : ["yes", "no", "maybe"],
    "dataIndex" : "radio"
}

Usage 2:
{
    "xtype" : "radiogroupcolumn",
    "text" : "Radio Group Test",
    "width" : 160,
    "radioValues" : [{
            "fieldValue" : "yes",
            "fieldDisplay" : "Yes"
        }, {
            "fieldValue" : "no",
            "fieldDisplay" : "No"
        }, {
            "fieldValue" : "maybe",
            "fieldDisplay" : "Maybe"
        }
    ],
    "dataIndex" : "radio"
}
*/

Ext.define('Ext.ux.grid.column.RadioGroupColumn', {
    extend: 'Ext.grid.column.Column',
    alias: 'widget.radiogroupcolumn',

    /* author: Alexander Berg, Hungary */ 
    defaultRenderer: function(value, metadata, record, rowIndex, colIndex, store, view) {
      var column = view.getGridColumns()[colIndex];
      var html = '';
      if (column.radioValues) {
          for (var x in column.radioValues) {
              var radioValue = column.radioValues[x], radioDisplay;
              if (radioValue && radioValue.fieldValue) {
                  radioDisplay = radioValue.fieldDisplay;
                  radioValue = radioValue.fieldValue;
              } else {
                  radioDisplay = radioValue;
              }
              if (radioValue == value) {
                  html = html + column.getHtmlData(record.internalId, store.storeId, rowIndex, radioValue, radioDisplay, 'checked');
              } else {
                  html = html + column.getHtmlData(record.internalId, store.storeId, rowIndex, radioValue, radioDisplay);
              }
          }
      }
      return html;
    },

    getHtmlData: function(recordId, storeId, rowIndex, value, display, optional) {
        var me = this, clickHandler, readOnly;
        var name = storeId + '_' + recordId;
        var clickHandler;
        if (me.readOnly) {
            readOnly = 'readonly';
            onClick = '';
        } else {
            readOnly = '';
            onClick = "onclick=\"this.checked=true;Ext.StoreManager.lookup('" + storeId + "').getAt(" + rowIndex + ").set('" + me.dataIndex + "', '" + value + "');\"'";
        }
        return ' ' + display + ' ';
    }
});