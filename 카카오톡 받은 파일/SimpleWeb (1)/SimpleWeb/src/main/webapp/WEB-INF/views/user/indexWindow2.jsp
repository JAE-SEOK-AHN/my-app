<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>user information</title>
<link rel="stylesheet"
	href="/resources/lib/jqWidgets/styles/jqx.base.css" type="text/css" />
<script type="text/javascript"
	src="/resources/lib/jquery/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="/resources/lib/jqWidgets/jqx-all.js"></script>
<style>
body {
	width: 100%;
	height: 800px;
	background: #000;
	margin: auto;
}
</style>
<script type="text/javascript">
	var data;
	
	$(function() {
		initComponent();
		initData();
		basicDemo.init();
		
/* 		$("#jqxgrid").on('rowselect', function (event) {
			var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
	    }); */
	});
	
	var basicDemo = (function () {
		function _addEventListeners() {
			$("#showInsertWindowButton").click(function () {
				$('#insertWindow').jqxWindow('open');
			});
			/* $("#showUpdateWindowButton").click(function () {
				var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
				data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
				$('#updateWindow').jqxWindow('open');
			}); */
		};
        function _createElements() {
	        $("#showInsertWindowButton").jqxButton({ width: '100', height: '25' });
	        $("#showUpdateWindowButton").jqxButton({ width: '100', height: '25' });
	        $("#jqxDeleteButton").jqxButton({ width: '100', height: '25' });
        }
        return {
            config: {
                dragArea: null
            },
            init: function () {
                _createElements();
                _addEventListeners();
                _createInsertWindow();
                _createUpdateWindow();
            }
        };
	} ());
	
	/* Window 생성  */
	function _createInsertWindow() {
        var jqxWidget = $('#jqxWidget');
        var offset = jqxWidget.offset();
        $('#insertWindow').jqxWindow({
        	cancelButton: $('#cancelButton'),
            position: { x: offset.left + 50, y: offset.top + 50} ,
            showCollapseButton: true, maxHeight: 400, maxWidth: 450, minHeight: 200, minWidth: 200, height: 300, width: 500,
            initContent: function () {
                $('#tab').jqxTabs({ height: '100%', width:  '100%' });
                $('#insertButton').jqxButton({ width: '80px'});
                $('#cancelButton').jqxButton({ width: '80px', disabled: false });
            }
        });
    };
    
    function _createUpdateWindow() {
        var jqxWidget = $('#jqxWidget');
        var offset = jqxWidget.offset();
        $('#updateWindow').jqxWindow({
        	cancelButton: $('#cancelUpdateButton'),
            position: { x: offset.left + 50, y: offset.top + 50} ,
            showCollapseButton: true, maxHeight: 400, maxWidth: 450, minHeight: 200, minWidth: 200, height: 300, width: 500,
            initContent: function () {
                $('#tab').jqxTabs({ height: '100%', width:  '100%' });
                $('#updateButton').jqxButton({ width: '80px'});
                $('#cancelUpdateButton').jqxButton({ width: '80px', disabled: false });
            }
        });
    };
	
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
	        ];
	    	
	     	$('#insertForm').jqxForm({
	            template: template,
	            padding: { left: 10, top: 10, right: 10, bottom: 10 }
	        });
	    	$('#insertButton').on('click', function () {
	    		/* $('#insertForm').jqxValidator('validate'); */
	            $('#insertForm').jqxForm('submit', "/user/insertUser");
	        });
	    	
			$('#updateForm').jqxForm({
		    	template: template,
		   		padding: { left: 10, top: 10, right: 10, bottom: 10 }
	    	});
			
			$('#updateButton').on('click', function () {
	            $('#updateForm').jqxForm('submit', "/user/updateUser");
			});
	
	}
	
	function initData() {
		$.get('/user/list', null, function(data) {
			for ( var i = 0; i < data.length; i++ ) {
				var birth = new Date(data[i].birth);
				var createDate = new Date(data[i].createDate);
				
				if( data[i].gender == "M" ) {
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
	       	
	       	$("#jqxgrid").jqxGrid({ source : dataAdapter });
       	});
	}


	function showUpdateWindow() {
		var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
		data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
		
		if( data.gender == "남" ) {
			data.gender = "M";
		}
		else {
			data.gender = "W";
		}
		$('#updateWindow').jqxWindow('open');
		$('#updateForm').jqxForm('val', data);
	}
	
	function deleteUser() {
		var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
		data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
		
		if ( data == null ) {
			alert("삭제할 유저를 선택해주세요");
		}
		
		location.href='/user/deleteUser?userId=' + data.userId;
		alert("삭제됨");
	}
/*     var name = $('#insertForm').jqxForm('getComponentByName', 'name');

	$('#insertForm').jqxValidator({
		rules: [
			{ input: $('#insertForm').jqxForm('getComponentByName', 'name'), message: '유저 이름을 작성하세요', action: 'keyup, blur', rule: 'required' }
		]
	}); */
	</script>
</head>

<body>
	<div id="top" style="width: 100%; height: 200px; background: #ff9999;">
		<h1 style="color: #fff; text-align: center;">User Information</h1>
	</div>
	<div id="bottom"
		style="width: 100%; height: 600px; background: #fff; display: inline-flex;">
		<div id="left" style="width: 300px; height: 100%; background: #ede6e6"></div>
		<div id="right" style="width: calc(100% - 300px); height: calc(100% - 20px); margin: 10px; background: #fff">
			<div style="height: 30px; background: #fff; float: right; margin: 5px;">
				<input style="background: #d1e8c5;" type="button" value="등록" id="showInsertWindowButton" />
			</div>
			<!-- window -->
			<div id="jqxWidget">
				<div style="width: 100%; height: 10px;" id="mainDemoContainer">
					<div id="insertWindow" style="display: none">
						<div id="windowHeader">유저 등록</div>
						<div style="overflow: hidden;" id="windowContent">
							<div id="tab">
								<div id='insertForm' style="width: 400px; height: 100%; margin: 20px; display: inline-block;"></div>
								<div style="width: 100%; text-align: center">
									<input type="button" value="등록" id="insertButton" style="width: 80px; height: 24px; padding: 1px 6px;" /> 
									<input type="button" value="취소" id="cancelButton" style="width: 80px;" />
								</div>
							</div>
						</div>
					</div>
					<div id="updateWindow" style="display: none">
						<div id="windowHeader">유저 수정</div>
						<div style="overflow: hidden;" id="windowContent">
							<div id="tab">
								<div id='updateForm' style="width: 400px; height: 100%; margin: 20px; display: inline-block;"></div>
								<div style="width: 100%; text-align: center">
									<input type="button" value="수정" id="updateButton" style="width: 80px; height: 24px; padding: 1px 6px;" /> 
									<input type="button" value="취소" id="cancelUpdateButton" style="width: 80px;" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="jqxgrid"></div>
				<div id="button" style="width: 100%; background: #fff; margin: 5px;">
					<input type="button" onclick="showUpdateWindow();" value="수정" id="showUpdateWindowButton" /> 
					<input style="background: #cf0000;" type="button" onclick="deleteUser();" value="삭제" id="jqxDeleteButton" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>