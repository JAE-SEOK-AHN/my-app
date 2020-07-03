<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>user information</title>
	<meta name="keywords" content="jQuery, Button, Toggle Button, Repeat Button, Link Button, Help Documentation" />
	<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.base.css"type="text/css" />
	<script type="text/javascript" src="/resources/lib/jquery/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="/resources/lib/jqWidgets/jqx-all.js"></script>
	<style>
	body {
		width: 100%;
		height: 800px;
		background: #000;
		margin: 0;
	}
	</style>
	<script type="text/javascript">
	/* Table */
	$(function() {
		initComponent();
		initData();
	});
	
	function initComponent() {
		 $("#jqxgrid").jqxGrid({
            columns: [
              { text: '아이디', datafield: 'userId', width: '20%', align: 'center' },
              { text: '이름', datafield: 'name', width: '15%', align: 'center'  },
              { text: '성별', datafield: 'gender', width: '15%', align: 'center' , cellsalign: 'center' },
              { text: '생일', datafield: 'birth', width: '20%', cellsformat: 'MM월 dd일', align: 'center'  },
              { text: '갱신날짜', datafield: 'createDate', width: '30%', cellsformat: 'yy-MM-dd HH:mm:ss', align: 'center' }
            ]
		    , width : '100%'
		    , height: 500
        });
	}
	
	function initData() {
		$.get('/user/list', null, function(data) {
			for ( var i = 0; i < data.length; i++ ) {
				var birth = new Date(data[i].birth);
				var createDate = new Date(data[i].createDate);
				
				if(data[i].gender == "M") {
					data[i].gender = "남";
				}
				else {
					data[i].gender = "여";					
				}
				
				data[i].birth = birth;
				data[i].createDate = createDate;
			}
	       	var source = { localdata: data, datatype: "array" };
	       	
	       	var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function (data) { },
	    		loadError: function (xhr, status, error) { }      
	        });
	       	
	       	$("#jqxgrid").jqxGrid({source : dataAdapter});
       	});
	}

	/* Button */
	$(document).ready(function () {
        // Create Link Button.
        $("#jqxInsertButton").jqxButton({ width: '100', height: '25' });
        $("#jqxUpdateButton").jqxButton({ width: '100', height: '25' });
        $("#jqxDeleteButton").jqxButton({ width: '100', height: '25' });
    });

	function updateUser() {
		var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
		var data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
		location.href='/user/update?userId=' + data.userId;
	}
	function deleteUser() {
		var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
		var data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
		
		location.href='/user/deleteUser?userId=' + data.userId;
		alert("삭제됨");
	}
	</script>
</head>

<body>
	<div id="top" style="width:100%; height: 200px; background: #ff9999;">
		<h1 style="color: #fff; text-align: center;">User Information</h1>
	</div>
	<div id="bottom" style="width:100%;height: 600px; background: #fff; display:inline-flex;">
		<div id="left" style="width: 300px; height:100%; background: #ede6e6">
			<p>side bar</p>
		</div>
		<div id="right" style="width: calc(100% - 300px); height: calc(100% - 20px); margin: 10px; background: #fff">
			<div id="insertbutton" style="height: 30px; background: #fff; float: right; margin: 5px;">
				<input style="background: #d1e8c5;" type="button" onclick="location.href='insert'" value="등록" id="jqxInsertButton" />
			</div>
			<div id="jqxgrid"></div>
			<div id="button" style="width: 100%; background: #fff; margin: 5px;">
				<input type="button" onclick="updateUser();" value="수정" id="jqxUpdateButton" />
				<input style="background: #cf0000;" type="button" onclick="deleteUser();" value="삭제" id="jqxDeleteButton" />
			</div>
		</div>
	</div>
</body>
</html>