<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>test</title>
	<link rel="stylesheet" href="/resources/lib/jqWidgets/styles/jqx.base.css" type="text/css" />
	<script type="text/javascript" src="/resources/lib/jquery/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="/resources/lib/jqWidgets/jqx-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sendButton').jqxButton({ width: 60, height: 30 });
            $('#sendButton').on('click', function () {
            	test();
            });
            $('.text-input').jqxInput({ width:250, height:30 });
        })
        
        function test() {
            $('#testForm').jqxValidator('validate');
            // initialize validator.
            $('#testForm').jqxValidator({
                rules: [
                       { input: '#userInput', message: 'Username is required!', action: 'keyup, blur', rule: 'required' }
						]
            });
        }
    </script>
</head>
<body class='default'>
            <form id="testForm" action="./">
                <table class="register-table">
				<tr>
				
					<td><input placeholder="User name" type="text" id="userInput" class="text-input" /></td>
                </tr>
				<tr>
				
					<td><input placeholder="User pass" type="text" id="userInput" class="text-input" /></td>
                </tr>
                    <tr>
                        <td colspan="2" style="text-align: center;"><input type="button" value="Send" id="sendButton" /></td>
                    </tr>
                </table>
            </form>
</body>
</html>