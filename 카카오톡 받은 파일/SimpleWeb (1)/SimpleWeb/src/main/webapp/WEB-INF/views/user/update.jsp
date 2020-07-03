<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>User Update</title>
	<meta name="keywords" content="jQuery, Button, Toggle Button, Repeat Button, Link Button, Help Documentation" />
	<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.base.css"type="text/css" />
	<script type="text/javascript" src="/resources/lib/jquery/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="/resources/lib/jqWidgets/jqx-all.js"></script>
	<style>
	body {
		width: 100%;
		height: 800px;
		text-align: center;
	}
	</style>
	<script type="text/javascript">
	var userId = '${userId}';
	
	$(function() {
		initComponent();

	});
	
	function initComponent() {
		var template = [
            {
                bind: 'userId',
                type: 'text',
                readOnly: true,
                label: '아이디',
                required: true,
                labelWidth: '80px',
                width: '250px'
            },
            {
                bind: 'name',
                type: 'text',
                label: '이름',
                required: true,
                labelWidth: '80px',
                width: '250px'
            },
            {
                bind: 'gender',
                type: 'option',
                label: '성별',
                labelPosition: 'left',
                labelWidth: '80px',
                align: 'left',
                width: '250px',
                required: true,
                component: 'jqxDropDownList',
                options: [
                    { label: '남자', value: 'M' },
                    { label: '여자', value: 'W' }
                ]
            },
            {
                bind: 'birth',
                type: 'date',
                label: '생일',
                labelPosition: 'left',
                labelWidth: '80px',
                align: 'left',
                width: '250px',
                required: true
            },
            {
                type: 'blank',
                rowHeight: '10px'
            },
            {
                columns: [
                    {
                    	name: 'submitButton',
                        type: 'button',
                        text: '등록',
                        width: '90px',
                        height: '30px',
                        rowHeight: '40px',
                        columnWidth: '50%',
                        align: 'right'
                    },
                    {
                    	name: 'cancelButton',
                        type: 'button',
                        text: '취소',
                        width: '90px',
                        height: '30px',
                        rowHeight: '40px',
                        columnWidth: '50%'
                    }                
                ]
            }
        ];
		
		$.get('/user/userOne', {userId: userId}, function(data) {
			var userInfo = data;
	        $('#updateForm').jqxForm({
	            template: template,
	            value: userInfo,
	            padding: { left: 10, top: 10, right: 10, bottom: 10 }
	        });
	        
			var updateBtn = $('#updateForm').jqxForm('getComponentByName', 'submitButton');
		    updateBtn.on('click', function () {
		    	$('#updateForm').jqxForm('submit', "/user/updateUser");
		    });
		    var cancelBtn = $('#updateForm').jqxForm('getComponentByName', 'cancelButton');
		    cancelBtn.on('click', function () {
		    	location.href='index';
		    });
		});

	}
	</script>
</head>
<body>
	<div id='updateForm' style="width: 400px; height: 100%; margin: 20px; display: inline-block;"></div>
</body>
</html>