<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>div Test</title>
	<style type="text/css">
	body {
		width: 1000px;
		height: 750px;
		margin: auto;
	}
	</style>
</head>
<body>
	<div id="top" style="width: 100%; height: 200px; border: 1px solid #000;"></div>
	<div id="bottom" style="width: 100%; height: 550px; border: 1px solid #000; display:inline-flex;">
		<div id="bottom-left" style="width: 200px; height: 100%; background: #ff9999; display:inline-flex;">
 			<div id="bottom-left-top" style="width: 200px; height: 400px; background: #fabebe;"></div>
		</div>
		<div id="bottom-right" style="width: 800px; height: 100%; border: 1px solid #000; display:inline-flex;">
			<div id="bottom-right-top" style="width: 100%; height: 350px; border: 1px solid #000; display:inline-flex;">
				<div id="bottom-right-top-left" style="width: 400px; height: 100%; border: 1px solid #000;"></div>
				<div id="bottom-right-top-right" style="width: 400px; height: 100%; border: 1px solid #000; display:inline-flex;">
					<div id="bottom-right-top-right-top" style="width: 100%; height: 200px;  background: #fabebe;"></div>
				</div>
			</div>	
		</div>
	</div>
</body>
</html>