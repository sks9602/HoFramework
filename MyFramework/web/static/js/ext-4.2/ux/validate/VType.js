
/* 알파벳 만 입력 */
Ext.form.VTypes['alphanewVal']  = /^[A-Za-z]*$/;
Ext.form.VTypes['alphanewMask'] = /[A-Za-z]/;
Ext.form.VTypes['alphanewText'] = 'Invalid Entry: Only alphabets are allowed.';
Ext.form.VTypes['alphanew'] = function(val) {
     return Ext.form.VTypes['alphanewVal'].test(val);
};

/* 숫자만 입력 */
Ext.form.VTypes['numericposVal'] =   /^[\d]+$/;
Ext.form.VTypes['numericposMask'] = /[\d]/;
Ext.form.VTypes['numericposText'] = 'Invalid Entry: Must be in the format Ex. 1';
Ext.form.VTypes['numericpos'] = function(val){
    return Ext.form.VTypes['numericposVal'].test(val);
};

/* 알파벳 + 숫자 입력 */
Ext.form.VTypes['alphanumericVal'] =   /^[a-z0-9]+$/i;
Ext.form.VTypes['alphanumericMask'] = /^[a-z0-9]+$/i;
Ext.form.VTypes['alphanumericText'] = 'Invalid Entry: 영문과 숫자만 입력가능';
Ext.form.VTypes['alphanumeric'] = function(val){
    return Ext.form.VTypes['alphanumericVal'].test(val);
};

/* password를 위한 8자리 이상 16자리 이하 영문, 숫자, 특수문자 조합 */
Ext.form.VTypes['passwordVal'] = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
Ext.form.VTypes['passwordMask'] = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
Ext.form.VTypes['passwordText'] = 'Invalid Entry: 8자리 이상 16자리 이하의 영문, 숫자 및 특수문자 조합';
Ext.form.VTypes['password'] = function(val){
    return Ext.form.VTypes['passwordVal'].test(val);
};

/* 이미지 file 컴포넌트 확장자 */
Ext.form.VTypes['imageFileUploadVal'] = /^.*\.(gif|png|bmp|jpg|jpeg)$/i;
Ext.form.VTypes['imageFileUploadMask'] = /^.*\.(gif|png|bmp|jpg|jpeg)$/i;
Ext.form.VTypes['imageFileUploadText'] = 'Image must be in .gif,.png,.bmp,.jpg,.jpeg format';
Ext.form.VTypes['imageFileUpload'] = function(val){
    return Ext.form.VTypes['imageFileUploadVal'].test(val);
};

/* 오디오 file 컴포넌트 확장자 */
Ext.form.VTypes['audioFileUploadVal'] = /^.*\.(mp3)$/i;
Ext.form.VTypes['audioFileUploadMask'] = /^.*\.(mp3)$/i;
Ext.form.VTypes['audioFileUploadText'] = 'Audio must be in .mp3 format';
Ext.form.VTypes['audioFileUpload'] = function(val){
    return Ext.form.VTypes['audioFileUploadVal'].test(val);
};

/* 비디오 file 컴포넌트 확장자 */
Ext.form.VTypes['videoFileUploadVal'] = /^.*\.(avi|mp4)$/i;
Ext.form.VTypes['videoFileUploadMask'] = /^.*\.(avi|mp4)$/i;
Ext.form.VTypes['videoFileUploadText'] = 'Audio must be in .avi,.mp4 format';
Ext.form.VTypes['videoFileUpload'] = function(val){
    return Ext.form.VTypes['videoFileUploadVal'].test(val);
};


    
/* 이미지 file 컴포넌트 확장자 */
Ext.form.VTypes['fileUploadVal'] = /^.*\.(exe|php|cgi|jsp|asp|htm|bat|msi|vbs|cmd|jar).*$/i;
Ext.form.VTypes['fileUploadMask'] = /^.*\.(exe|php|cgi|jsp|asp|htm|bat|msi|vbs|cmd|jar).*$/i;
Ext.form.VTypes['fileUploadText'] = '실행가능한 파일은 안됩니다. ex) .exe, .php, .cgi, .jsp, .asp 등';
Ext.form.VTypes['fileUpload'] = function(val){
    return !Ext.form.VTypes['fileUploadVal'].test(val);
};
