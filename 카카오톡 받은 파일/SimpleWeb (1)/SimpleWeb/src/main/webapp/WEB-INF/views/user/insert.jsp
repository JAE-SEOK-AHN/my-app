<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>유저 등록</title>
	<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.base.css"type="text/css" />
	<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.energyblue.css"type="text/css" />
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
	$(function() {
		initComponent();
	});
	
	function initComponent() {
		var template = [
            {
                bind: 'userId',
                type: 'text',
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
/*             {
                type: 'label',
                label: '성별',
                required: true,
                labelWidth: '80px',
            },
            {
                bind: 'radiobuttonValue',
                type: 'option',
                label: '성별',
                labelPosition: 'right',
                columnWidth: '170px',
                optionslayout: 'horizontal',
                oprionsposition: 'left';
                options: [
                	{ label: '남자', value: 'M' },
                    { label: '여자', value: 'W' }
                ]
            }, */
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
		
        $('#insertForm').jqxForm({
            template: template,
            padding: { left: 10, top: 10, right: 10, bottom: 10 }
        });
	}
	
 	$(document).ready(function () {
        var insertBtn = $('#insertForm').jqxForm('getComponentByName', 'submitButton');
        insertBtn.on('click', function () {
            $('#insertForm').jqxForm('submit', "/user/insertUser");
        });
        var cancelBtn = $('#insertForm').jqxForm('getComponentByName', 'cancelButton');
        cancelBtn.on('click', function () {
            location.href='index';
        });
    });
	</script>
</head>
<body>
	<div id='insertForm' style="width: 400px; height: 100%; margin: 20px; display: inline-block;"></div>
</body>
</html>