<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>user information</title>
<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.base.css" type="text/css" />
<script type="text/javascript" src="/resources/lib/jquery/jquery-3.4.1.min.js"></script>
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
	$(function() {
		initComponent();
		initData();
	});
	
	function initComponent() {
		//grid
		$("#jqxgrid").jqxGrid({
            columns: [
              { text: '아이디', datafield: 'userId', width: '20%', align: 'center' },
              { text: '이름', datafield: 'name', width: '15%', align: 'center'  },
              { text: '성별', datafield: 'gender', width: '15%', align: 'center' , cellsalign: 'center' },
              { text: '생일', datafield: 'birth', width: '20%', align: 'center'  },
              { text: '갱신날짜', datafield: 'createDate', width: '30%', align: 'center' }
            ]
		    , width : '100%'
		    , height: 500
        });
		
		//button
		$("#insertBtn").jqxButton({ width: '100', height: '25', value:'등록', template:'success'});
		$("#insertBtn").on('click', function() {
			openDetailPopup('INSERT');
		});
		$("#updateBtn").jqxButton({ width: '100', height: '25', value:'수정', template:'warning'});
		$("#updateBtn").on('click', function() {
			openDetailPopup('UPDATE');
		});
		$("#deleteBtn").jqxButton({ width: '100', height: '25', value:'삭제', template:'danger'});
		$("#deleteBtn").on('click', function() {
			deleteUser();
		});
		$("#saveBtn").jqxButton({ width: '100', height: '25', value:'저장'});
		$("#jqxwindow").on('click', '#saveBtn', function() {
			$('#popupForm').jqxValidator('validate');
			saveUser();
		});
		$("#cancelBtn").jqxButton({ width: '100', height: '25', value:'취소'});
		$("#jqxwindow").on('click', '#cancelBtn', function() {
			$('#jqxwindow').jqxWindow('close');
		});
	}
	
	function initData() {
		$.get('/user/list', null, function(data) {
	       	var source = { localdata: data, datatype: "array" };
	       	
	       	var dataAdapter = new $.jqx.dataAdapter(source, {
	            loadComplete: function (data) { },
	    		loadError: function (xhr, status, error) { }      
	        });
	       	
	       	$("#jqxgrid").jqxGrid({ source : dataAdapter });
       	});
	}
	
	function openDetailPopup(type) {
		$('#jqxwindow').jqxWindow({
			autoOpen: false
			, width: 400, height: 300
           // , cancelButton: $('#cancel')
        });
		
		var template = [
			{bind:'userId', name:'userId', type:'text', label:'아이디', required:true, labelWidth:'80px', width:'250px'}
			, {bind:'name', name: 'name', type:'text', label:'이름', required:true, labelWidth:'80px', width:'250px'}
			, {type:'label', label: '성별', required:true, rowHeight: '40px'}
			, {bind:'gender', name:'gender', type:'option', width:'250px', optionslayout: 'horizontal', options:[{label:'남자', value:'M'}, {label:'여자', value:'W'}]}
			, {bind:'birth', name:'birth', type:'date', label:'생일', formatString: "yyyy-MM-dd", labelPosition:'left', labelWidth:'80px', align:'left', width:'250px', required:true}
		];
		
		$('#popupForm').jqxForm({
            template: template,
            padding: { left: 10, top: 10, right: 10, bottom: 10 }
        });
		
		
		$('#jqxwindow').data('type', type);
		
		if ( 'INSERT' == type ) {
			$('#popupForm').jqxForm('val', {userId: '', name: '', birth: '', gender: "M"});
			$('#popupForm').jqxForm('getComponentByName','userId')[0].disabled = false;
			$('#jqxwindow').jqxWindow('open');
		}
		else if ( 'UPDATE' == type) {
			// getUser
			var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			
			if ( selectedrowindex == -1 ) {
				alert("수정할 유저를 선택하세요");
			}
			else {
				var data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
				getUser(data.userId);
		
				$('#popupForm').jqxForm('getComponentByName','userId')[0].disabled = true;
				$('#jqxwindow').jqxWindow('open');
			}
		}
		else { console.log('openDetailPopup - type :'+type); }
	}
	
	function deleteUser() {
		var param = {mode : 'DELETE'};
		var selectedrowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
		
		if ( selectedrowindex == -1 ) {
			alert("삭제할 유저를 선택하세요");
		}
		else {
			var data = $('#jqxgrid').jqxGrid('getrowdata', selectedrowindex);
			param.userId = data.userId;
			
			$.post('/user/save', param, function(result) {
				console.log(result);
				if ( result.result == 'OK' ) {
					alert(result.userId + ' >> 삭제되었습니다.');
					initData();
				}
				else {
					alert('삭제에 실패 하였습니다.');
				}
			});
		}
	}
	
	function saveUser() {
		var type = $('#jqxwindow').data('type');
		var param = {mode : type};
		// 윤정 - extend랑 같은 기능...? 차이점?
		var inputData = $('#popupForm').jqxForm().val();
		param.userId = inputData.userId; 
		param.name = inputData.name;
		param.gender = inputData.gender;
		param.birth = inputData.birth;
/* 		param.userId = $('#popupForm').jqxForm('getComponentByName','userId').val(); 
		param.name = $('#popupForm').jqxForm('getComponentByName','name').val();
		param.gender = $('#popupForm').jqxForm('getComponentByName','gender').val();
		param.birth = $('#popupForm').jqxForm('getComponentByName','birth').val(); */
		
		$('#popupForm').jqxValidator('validate');
		$.post('/user/save', param, function(result) {
			if ( result.result = 'OK' ) {
				$('#jqxwindow').jqxWindow('close');
				initData();
			}
			else {
				alert('등록에 실패 하였습니다.');
			}
		});
	}
	
	function getUser(userId) {
		var param = {userId : userId};
		$.get('/user/one', param, function(result) {
			$('#popupForm').jqxForm('val', result );
			console.log(result);
		});
	}
	</script>
</head>

<body>
	<div id="top" style="width: 100%; height: 200px; background: #ff9999;">
		<h1 style="color: #fff; text-align: center;">User Information</h1>
	</div>
	<div id="bottom" style="width: 100%; height: 600px; background: #fff; display: inline-flex;">
		<div id="left" style="width: 300px; height: 100%; background: #ede6e6"></div>
		<div id="right" style="width: calc(100% - 300px); height: calc(100% - 20px); margin: 10px; background: #fff">
			<div style="height: 30px; background: #fff; float: right; margin: 5px;">
				<input id="insertBtn" type="button"/>
			</div>

			<div id="jqxgrid"></div>

			<div id="button" style="width: 100%; background: #fff; display: inline-flex;">
				<input id="updateBtn" type="button" style="margin-top: 10px; margin-right: 10px;"/> 
				<input id="deleteBtn" type="button" style="margin-top: 10px;"/>
			</div>
		</div>
	</div>
	<div hidden="hidden">
		<div id="jqxwindow">
			<div>상세정보</div>
			<div>
				<div id="popupForm"></div>
				<!-- 윤정 - 해결을 하긴 했는데.......음...... div 하나 만들어서 해결.. -->
				<div style="width: 100%; text-align: center;">
					<div style="display: inline-flex; text-align: center; margin-top:10px;">
						<input type="button" id="saveBtn" style="margin-right: 10px" />
			            <input type="button" id="cancelBtn"/>
		            </div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>