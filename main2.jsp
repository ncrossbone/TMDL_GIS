<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>수질오염총량관리지도GIS</title>
<link rel="stylesheet" type="text/css" href="resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="resources/css/gis_2014.css" />
<link rel="stylesheet" type="text/css" href="resources/js/lib/jquery/jquery.treeview.css">
<link rel="stylesheet" type="text/css" href="resources/js/lib/jquery/jquery-ui-1.10.0.custom.css">


<script type="text/javascript" src="resources/js/lib/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="resources/js/lib/jquery/jquery-ui-1.11.1.custom/jquery-ui.js"></script>
<script type="text/javascript" src="resources/js/lib/anseki-jquery-plainoverlay/jquery.plainoverlay.js"></script>

<script type="text/javascript" src="resources/js/lib/jquery/jquery.treeview.js"></script>


<script src="http://maps.google.com/maps/api/js?v=3&amp;sensor=false"></script>
<script type="text/javascript" src="resources/js/lib/OpenLayers/OpenLayers.js"></script>
<script type="text/javascript" src="http://map.vworld.kr/js/apis.do?type=Base&apiKey=DBF63E16-97FD-343E-A8C3-43CEAAA2AA76"></script>
<!-- <script type="text/javascript" src="http://map.vworld.kr/js/apis.do?type=Base&apiKey=C0E92FB8-20A3-3C40-825D-2DF71C9219D6"></script> -->

<%
	String userAgent = request.getHeader("User-Agent");
	boolean ie9 = false;
	if ( userAgent.indexOf("Trident/5.0") > -1 ) {
		ie9 = true;
	}
%>
<%
	if( ie9 ) {
%>
<script type="text/javascript" src="resources/js/data/CommonData_EUCKR.js" charset="euc-kr"></script>
<%
	} else {
%>
<script type="text/javascript" src="resources/js/data/CommonData.js" charset="utf-8"></script>
<%	}	%>

<script type="text/javascript" src="resources/js/view/Map.js"></script>
<script type="text/javascript" src="resources/js/view/View.js"></script>
<script type="text/javascript" src="resources/js/view/MainMap.js"></script>
<script type="text/javascript" src="resources/js/Main.js"></script>

<script type="text/javascript" src="resources/js/lib/print/base64.js"></script>
<script type="text/javascript" src="resources/js/lib/print/canvas2image.js"></script>
<script type="text/javascript" src="resources/js/lib/print/html2canvas.js"></script>

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
	
	/**
	 * 
	 */
	function getWorkSpaceName(){
		return "tmdl";
		//return "woo";
	}

	function getLayerUrl(){
		//return "http://211.114.21.39:8080/geoserver/tmdl/wms";
		//return "http://112.217.167.123:39516/geoserver/woo/wms";
		return "http://112.218.1.243:38080/geoserver/tmdl/wms";
	
	}

	function getLayerData(){
		var layerData = [{
			name : "수계",
			child : [
				{
					name : "한강단위유역",
					layers : "9hangang",
					id : "hangangDan",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : true
			      	}
				},
				{
					name : "한강소유역",
					layers : "9hangangso",
					id : "hangangso",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "금강단위유역",
					layers : "10km",
					id : "geumgang",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "금강소유역",
					layers : "10kms",
					id : "geumgangso",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "영산강섬진강단위유역",
					layers : "11yeoung",
					id : "youngsan",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "영산강섬진강소유역",
					layers : "11yeoungjb",
					id : "youngsanso",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "낙동강단위유역",
					layers : "12nak",
					id : "nakdong",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "낙동강소유역",
					layers : "12nakso",
					id : "nakdongso",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "특대유역",
					layers : "tkdaeyuyeok",
					id : "tkdae",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "진위A",
					layers : "jinAdan",
					id : "jinA",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "수질측정지점",
			child : [
				{
					name : "수질측정소_하천수",
					layers : "4suji_ha",
					id : "hacheonsu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수질측정소_호소수",
					layers : "4suji_ho",
					id : "hososu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수질측정소_농업용수",
					layers : "4suji_nong",
					id : "nongupyoungsu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수질측정소_공단배수",
					layers : "4suji_gong",
					id : "gongdanbaesu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수질측정소_도시관류",
					layers : "4suji_do",
					id : "dosigoan",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "보",
					layers : "14bo",
					id : "bo",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "수질자동측정지점",
			child : [
				{
					name : "수질측정소_자동",
					layers : "5suzi_ja",
					id : "sujilauto",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수질TMS",
					layers : "5suzi_tms",
					id : "sujiltms",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "기타측정지점",
			child : [
				{
					name : "수리수문기상_수위",
					layers : "6suri_su",
					id : "sulisuwee",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수리수문기상_유량",
					layers : "6suri_yu",
					id : "suriyulyang",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수리수문기상_우량",
					layers : "6suri_woo",
					id : "suriwoolyang",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수리수문기상_AWS",
					layers : "6suri_aws",
					id : "suriaws",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "수리수문기상_댐",
					layers : "6suri_dam",
					id : "suridam",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "지상기상관측소",
					layers : "6ji",
					id : "jisang",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "환경기초시설",
			child : [
				{
					name : "환경기초_농공단지처리시설",
					layers : "17nong",
					id : "nonggongdanji",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_기타공동처리시설",
					layers : "17etc",
					id : "gitagongdong",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_분뇨처리시설",
					layers : "17boon",
					id : "ddongcheori",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_산업폐수종말처리시설",
					layers : "17san",
					id : "sanupdwater",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_매립장침출수처리시설",
					layers : "17me",
					id : "malip",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_축산폐수공공처리시설",
					layers : "17chok",
					id : "chuksanwater",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_마을하수도",
					layers : "17ma",
					id : "townunderwater",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "환경기초_하수종말처리시설",
					layers : "17ha",
					id : "hasujongmal",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "취수장",
					layers : "15chi",
					id : "chuisu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "하천",
			child : [
				{
					name : "국가하천",
					layers : "13kuk",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "지방하천",
					layers : "13ji",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "지방하천상세",
					layers : "13ji2",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "수질영향권역",
			child : [
				{
					name : "대권역",
					layers : "3dae",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "중권역",
					layers : "3jong",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "소권역",
					layers : "3so",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		},
		{
			name : "행정구역",
			child : [
				{
					name : "시도",
					layers : "2sido",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "시군구",
					layers : "2sigungu",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "읍내동",
					layers : "2um",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				},
				{
					name : "동리",
					layers : "2ri",
					option : {                                       
			      		opacity: 1,                                       
			      		singleTile: false,
			      		visibility : false
			      	}
				}
			]
		}];
		
		return layerData;
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
