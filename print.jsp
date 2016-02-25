<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Print</title>

<style>
	.changeBlue {    /* creates the default color as black */
		color: #000000;
		cursor : default;
	}
	.changeBlue:hover {  /* changes the color of the text to blue on mouseover */
		color: #0000ff;
		cursor : default;
		text-decoration: underline;
	}
	
	body { 
		font : 0.75em/120% "돋음","돋음체",dotum,Verdana,Arial,Sans-serif;
		text-align : left;
		color : #4c4c4c;
	}
</style>

<script type="text/javascript" src="resources/js/lib/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
function load(){
	//var map = opener.getMapUI();
	//$(map).appendTo("#printDiv");
	//window.print();
	//self.close();
}
</script>
</head>
<body onload="load()">
<div id="printDiv">

</div>
</body>
</html>