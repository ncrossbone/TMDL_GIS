/**
 * 
 */
function getWorkSpaceName(){
	return "tmdl";
	//return "woo";
}

function getLayerUrl(){
	//return "http://211.114.21.39:8080/geoserver/tmdl/wms";
	return "http://112.218.1.243:38080/geoserver/tmdl/wms";
	//return "http://112.217.167.123:39516/geoserver/woo/wms";
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
				id : "Khacheon",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "지방하천",
				layers : "13ji",
				id : "jhacheon",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "지방하천상세",
				layers : "13ji2",
				id : "jhacheon2",
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
				id : "daek",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "중권역",
				layers : "3jong",
				id : "jungk",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "소권역",
				layers : "3so",
				id : "sok",
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
				id : "sido",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "시군구",
				layers : "2sigungu",
				id : "sgg",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "읍내동",
				layers : "2um",
				id : "umd",
				option : {                                       
		      		opacity: 1,                                       
		      		singleTile: false,
		      		visibility : false
		      	}
			},
			{
				name : "동리",
				layers : "2ri",
				id : "dr",
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
