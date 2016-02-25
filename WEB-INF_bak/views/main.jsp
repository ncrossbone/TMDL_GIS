<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<title>수질오염총량관리지도GIS</title>
<link rel="stylesheet" type="text/css" href="tmdl_gis/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="tmdl_gis/resources/css/gis_2014.css" />
<link rel="stylesheet" type="text/css" href="tmdl_gis/resources/js/lib/jquery/jquery.treeview.css">
<link rel="stylesheet" type="text/css" href="tmdl_gis/resources/js/lib/jquery/jquery-ui-1.10.0.custom.css">


<script type="text/javascript" src="tmdl_gis/resources/js/lib/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/lib/jquery/jquery-ui-1.11.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/lib/anseki-jquery-plainoverlay/jquery.plainoverlay.js"></script>

<script type="text/javascript" src="tmdl_gis/resources/js/lib/jquery/jquery.treeview.js"></script>


<script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
<script type="text/javascript" src="resources/js/lib/OpenLayers/OpenLayers.js"></script>
<script type="text/javascript" src="http://map.vworld.kr/js/apis.do?type=Base&apiKey=DBF63E16-97FD-343E-A8C3-43CEAAA2AA76"></script>

<script type="text/javascript" src="tmdl_gis/resources/js/data/CommonData.js"></script>

<script type="text/javascript" src="tmdl_gis/resources/js/view/Map.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/view/View.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/view/MainMap.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/Main.js"></script>

<script type="text/javascript" src="tmdl_gis/resources/js/lib/print/base64.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/lib/print/canvas2image.js"></script>
<script type="text/javascript" src="tmdl_gis/resources/js/lib/print/html2canvas.js"></script>

<script type="text/javascript">
	var main = null;
	$(document).ready(function(){
		main = new Main();	
	});

	function getMapUI(){
		var clone = document.getElementById("gisDiv").outerHTML;
		return clone;
	}











	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
	}

	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}

	function MM_findObj(n, d) { //v4.01
	  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	  if(!x && d.getElementById) x=d.getElementById(n); return x;
	}

	function MM_swapImage() { //v3.0
	  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
	}
</script>
</head>

<body>
<div id="GISTopWarp" style="z-index:9999">
	<h1></h1>
    <ul class="Bt_ctrl">
    	<li class="Util_01"><a href="#"><span>전체</span></a></li>
        <li class="Util_02"><a href="#"><span>확대</span></a></li>
        <li class="Util_03"><a href="#"><span>축소</span></a></li>
        <li class="Util_04"><a href="#"><span>이전</span></a></li>
        <li class="Util_05"><a href="#"><span>다음</span></a></li>
        <li class="Util_06"><a href="#"><span>주제도</span></a></li>
        <li class="Util_07"><a href="#"><span>인쇄</span></a></li>
        <li class="Util_08"><a href="#"><span>저장</span></a></li>
        <li class="Util_09"><a href="#"><span>도움말</span></a></li>
        <li class="Util_10"><a href="#"><span>이동</span></a></li>
        <li class="Util_11"><a href="#"><span>검색</span></a></li>
        <li class="Util_12"><a href="#"><span>선택</span></a></li>
        <li class="Util_13"><select name=""></select></li>
    </ul>
    <h2></h2>
</div>

<div id="gisDiv" style="position:absolute; width:100%; top:0px; bottom:0px; left:0px; right:0px"></div>
<div id="top13" style="display:none"></div>
<div id="modalPopup"></div>

	<div id="cont">
		<div id="cont_search">
		<div id="tap">
	  		<div class="tap_1_depth"><img src="resources/images/gis/tap_1_over.png"></div>
			<div class="tap_1_depth"><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image3','','resources/images/gis/tap_2_over.png',1)"><img src="resources/images/gis/tap_2_off.png" name="Image3"></a></div>
	  	</div><!--tap-->
			<div class="abc">
				<div class="sel_naming">시도선택</div>
				<select name="select" class="sel_box">
				  <option>서울특별시</option>
				  <option>인천광역시</option>
				  <option>경기도</option>
				  <option>광주광역시</option>
				  <option>대구광역시</option>
				  <option>부산광역시</option>
				  <option>울산광역시</option>
			 	 <option>제주도</option>
				</select>
			</div><!--abc-->
			<div class="abc">
				<div class="sel_naming">시군선택</div>
				<select name="select" class="sel_box">
				  <option>시군선택</option>
				  <option>시군선택</option>
				  <option>시군선택</option>
				</select>
			</div><!--abc-->
			<div class="abc">
				<div class="sel_naming">읍면선택</div>
				<select name="select" class="sel_box">
				  <option>읍면선택</option>
				  <option>읍면선택</option>
				  <option>읍면선택</option>
				</select>
			</div><!--abc-->
			<div id="bt_ok"><a href="#"><img src="resources/images/gis/bt_ok.gif" width="50" height="20" border="0"></a></div>	
		</div><!--in_cont-->
	</div>
	
	<div id="mapToggle" style="z-index:40">
		<ul>
		<li><a id="baseMapButton" href="#"><img src="resources/images/map_toggleBtn_noActive.png"></a></li>
		<li><a id="sattliteMapButton" href="#"><img src="resources/images/map_toggleBtn_st.png"></a></li>
	    </ul>
	</div>
</div>
</body>
</html>
