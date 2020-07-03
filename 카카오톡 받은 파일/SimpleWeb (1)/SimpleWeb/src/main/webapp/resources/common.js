$(function() {
	// init alert
	$('#alertMsg').jqxWindow({theme : window_theme, title : 'Message', width : '300px', height : '150px', isModal : true, draggable : false, resizable : false, autoOpen: false, animationType:'none'
		, okButton: $('#alertOk')
		, initContent: function () {
            $('#alertOk').jqxButton({ template: 'primary', width: '65px' });
            $('#alertOk').focus();
        }	
	});
	
	// init confirm 
	$('#confirmMsg').jqxWindow({theme : window_theme, title : 'Confirm', width : '300px', height : '150px', isModal : true, draggable : false, resizable : false, autoOpen: false, animationType:'none'
		, okButton:$('#confirmOk')
		, cancelButton:$('#confirmCancel')
		, initContent: function () {
            $('#confirmOk').jqxButton({ template: 'primary', width: '65px' });
            $('#confirmCancel').jqxButton({ width: '65px' });
            $('#confirmCancel').focus();
        }	
	});
	
	// loader
	$("#jqxLoader").jqxLoader({ theme: theme, width: 100, height: 60, imagePosition: 'top', isModal: true });
	$("#jqxLoader").css('z-index', 99999);
	$("#jqxLoaderModal").css('z-index', 99998);
});

function getPagingDataAdapter(searchParams, url, dataKey) {
	var source 		= {};
	source.data 	= searchParams;
	source.datatype = 'json';
	source.url 		= url;
	source.root 	= dataKey;
	source.cache 	= false;
	source.beforeprocessing = function(data) {		
		source.totalrecords = data.totalCount;
	}
	return new $.jqx.dataAdapter(source);
}

function downloadExcel(searchParams, url) {
	$('#jqxLoader').jqxLoader('open');
	$.fileDownload(url + '/excel', {
		httpMethod: 'GET'
		, data: searchParams
		, successCallback: function() {
			$('#jqxLoader').jqxLoader('close');
		}
		, failCallback: function() {
			$('#jqxLoader').jqxLoader('close');
		}
	});
}

function getPopupXY() {
	var popupX = ($(window).width() / 2) - (300 / 2); // - width
	var popupY= ($(window).height() / 2) - (150 / 2); // - height
	
	return { x : popupX, y : popupY }
}

function alertMsg(title, message) {
	$('#alertTitle').removeClass('error');
	$('#alertBody').text(message);
	$('#alertMsg').jqxWindow('setTitle', title);
	$('#alertMsg').jqxWindow({position: getPopupXY()});
	$('#alertMsg').jqxWindow('open');
}

function errorMsg(title, message) {
	$('#alertTitle').addClass('error');
	$('#alertBody').text(message);
	$('#alertMsg').jqxWindow('setTitle', title);
	$('#alertMsg').jqxWindow({position: getPopupXY()});
	$('#alertMsg').jqxWindow('open');
}

function confirmMsg(title, message, callback) {
	$('#confirmBody').text(message);
	$('#confirmMsg').jqxWindow('setTitle', title);
	$('#confirmMsg').jqxWindow({position: getPopupXY()});
	$('#confirmMsg').jqxWindow('open');
	$('#confirmMsg').unbind('close').on('close', function (event) {
		callback(event.args.dialogResult.OK);
    });
}

function showMenuPopup(title, url, width, height) {
	$('#menuPopup').jqxWindow({theme : window_theme, title : '<strong>' + title + '</strong>', width : width, height : height, isModal : true, draggable : true, resizable : false, autoOpen: false, position: 'center'});
	$('#menuPopupBody').html('');
	goAjaxLoad('#menuPopupBody', url, null, function(result) {
		if ( result.status == 403 ) {
			errorMsg('메뉴 접근 권한 오류', '메뉴 접근 권한이 없습니다.');
			return;
		}
		$('#menuPopup').jqxWindow('open');
	});	
}

function showMenuPopupFromDashboard(title, url, width, height, param) {
	$('#menuPopup').jqxWindow({theme : window_theme, title : '<strong>' + title + '</strong>', width : width, height : height, isModal : true, draggable : true, resizable : false, autoOpen: false, position: 'center'});
	$('#menuPopupBody').html('');
	goAjaxLoad('#menuPopupBody', url, null, function(result) {
		$('#menuPopup').jqxWindow('open');
		if ( result.status == 403 ) {
			errorMsg('메뉴 접근 권한 오류', '메뉴 접근 권한이 없습니다.');
			return;
		}
		
		$('#inputText').val(param.id);
		$('#fromDate').val(param.startDate);
		$('#toDate').val(param.endDate);
		$('#searchButton').trigger('click');
	});	
}

function goAjaxLoad(target, url, param, callback) {
	var fullUrl = url;
	if ( param != null && param.replace(/\s/g, '').length != 0 ) {
		fullUrl = fullUrl + '?' + param;
	}
	
	if ( callback != null ) {
		$(target).load(fullUrl, function(response, status, xhr) {
			if ( xhr != null && xhr.responseText != null && xhr.responseText.indexOf('loginForm') > 0 ) {
				window.location.href = '/logout';
			}
			callback(xhr);	
		});
	}
	else {
		$(target).load(fullUrl, function(response, status, xhr) {
			if ( xhr != null && xhr.responseText != null && xhr.responseText.indexOf('loginForm') > 0 ) {
				window.location.href = '/logout';
			}
			if ( result.status == 403 ) {
				errorMsg('메뉴 접근 권한 오류', '메뉴 접근 권한이 없습니다.');
				return;
			}
		});	
	}
}


function goAjaxGetWithoutLoader(url, param, callback) {
	var data = goAjaxMethod('GET', url, param, callback != null, callback, false); //비동기 사용
	return data;
}

function goAjaxPostWithoutLoader(url, param, callback) {
	var data = goAjaxMethod('POST', url, param, callback != null, callback, false); //비동기 사용
	return data;
}

function goAjaxGet(url, param, callback) {
	var data = goAjaxMethod('GET', url, param, callback != null, callback, true); //비동기 사용
	return data;
}

function goAjaxPost(url, param, callback) {
	var data = goAjaxMethod('POST', url, param, callback != null, callback, true); //비동기 사용
	return data;
}

function goAjaxMethod(method, url, param, async, callback, useLoader) {
	var response 		= null;
	var ajaxOption 		= {};
	ajaxOption.url 		= ctx + url;
	ajaxOption.type 	= method;
	ajaxOption.dataType = 'json';
	ajaxOption.async 	= async;
	ajaxOption.beforeSend = function() {
		// start progress 
		if ( useLoader == true ) {
			$('#jqxLoader').jqxLoader('open');
		}
	} 
	ajaxOption.complete = function() {
		// end progress 
		if ( useLoader == true ) {
			$('#jqxLoader').jqxLoader('close');
		}
	}
	
	if ( method == 'GET' ) {
		if ( param != null ) {
			if ( param instanceof Object ) {
				param = objectToQueryString(param);
			}
			ajaxOption.data = param;	
		}
	}
	else {
		ajaxOption.contentType 	= 'application/json; charset=UTF-8';
		if ( param != null ) {
			ajaxOption.data = JSON.stringify(param);	
		}	
	}
	
	if (callback != null) {
		$.ajax(ajaxOption).done(callback).fail(function(data) {
			if ( data.responseText != null && data.responseText.indexOf('loginForm') > 0 ) {
				window.location.href = '/logout';
			}
		});
	}
	else {
		$.ajax(ajaxOption).done(function(data) {
			response = data;
		}).fail(function(data) {
			if ( data != null && xhr.data.indexOf('loginForm') > 0 ) {
				window.location.href = '/logout';
			}
		});	

		return response;
	}
}

function objectToQueryString(json) {
    return Object.keys(json).map(function(key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(json[key]);
    }).join('&');
}

function getCode(groupCd, useAll) {
	var codeVo = {
		'groupCd': groupCd
	}
	
	var result = goAjaxGet('/common/code', codeVo);
	
	if ( useAll == null || useAll == true ) {
		result.unshift({codeId: '', codeValue: '전체'});
	}
	return result;
}

function getWindowOption(width, height, zIndex) {
	var windowOption = {
		theme: window_theme
		, width: width
		, height: height
		, zIndex: zIndex
		, isModal: true
		, autoOpen: false
		, draggable: false
		, resizable: false
		, animationType: 'none'
	}
	
	return windowOption;
}

function dateValidate(fromDate, toDate) {
	if ( moment(toDate).diff(moment(fromDate)) >= 0  ) {
		return true;
	}
	else {
		return false;
	}
}

var MENU_SIZE = {};
var columnrenderer = function(value) {
    return '<div style="text-align: center; margin-top: 9px;">' + value + '</div>';
}

var columnleftrenderer = function(value) {
    return '<div style="text-align: left; margin-top: 9px;">' + value + '</div>';
}

var columnrightrenderer = function(value) {
    return '<div style="text-align: right; margin-top: 9px;">' + value + '</div>';
}

var defaultCellsRenderer = function(row, column, value) {
	if ( value == null || value == '' ) {
		return '<div style="text-align: center; margin-top: 9px;">-</div>';
	}
	else {
		return '<div style="text-align: center; margin-top: 9px;">' + value + '</div>';
	}
}

var rightAlignCellsRenderer = function(row, column, value) {
	if ( value == null || value == '' ) {
		return '<div style="text-align: center; margin-top: 9px;">-</div>';
	}
	else {
		return '<div style="margin-top: 9px;">' + value + '</div>';
	}
}

