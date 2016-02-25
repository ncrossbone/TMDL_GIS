/**
 * 
 */
Map.SATTLITEMAP_ID = "VSAT";
Map.BASEMAP_ID = "VBASE";
Map.HYBRIDMAP_ID = "VHYBRID";
Map.OPENSTREETMAP_ID= "OSM";
Map.GOOGLEMAP_ID = "GOOGLE";

function Map(){
    this.mapBounds = new OpenLayers.Bounds(123 , 32, 134 , 43);
    this.mapMinZoom = 7;
    this.mapMaxZoom = 19;

    this.map = null;
}

Map.prototype.getMap = function(){
  return this.map;  
};

Map.prototype.createSattliteMapLayer = function(){
    var vSAT = new vworld.Layers.Satellite(Map.SATTLITEMAP_ID);
    
    return vSAT;
};

Map.prototype.createBaseMapLayer = function(){
    var vBase = new vworld.Layers.Base(Map.BASEMAP_ID);
    
    return vBase;
};

Map.prototype.createHybridMapLayer = function(){
    var vHybrid = new vworld.Layers.Hybrid(Map.HYBRIDMAP_ID);
    
    return vHybrid;
};

Map.prototype.createGoogleMapLayer = function(){
	var googleMap = new OpenLayers.Layer.Google(Map.GOOGLEMAP_ID,{
			type: google.maps.MapTypeId.SATELLITE, numZoomLevels: 22
		}
	);
	
	return googleMap;
};

Map.prototype.createOpenStreetMapLayer = function(){
	var osm = new OpenLayers.Layer.OSM(Map.OPENSTREETMAP_ID,
  ["http://a.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png",
   "http://b.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png",
   "http://c.tile.opencyclemap.org/cycle/${z}/${x}/${y}.png"]);
   
   return osm;
};

Map.prototype.ceateMap = function(mapContainerID){
    
    var options = {
        controls : [],
        projection : new OpenLayers.Projection("EPSG:900913"),
        displayProjection : new OpenLayers.Projection("EPSG:4326"),
        units : "m",
        controls : [],
        numZoomLevels : 19,
        maxResolution : 156543.0339,
        maxExtent : new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34)
    };
    
    OpenLayers.IMAGE_RELOAD_ATTEMPTS = 3;
    OpenLayers.Util.onImageLoadErrorColor = "transparent";
    this.map = new OpenLayers.Map(mapContainerID, options);
    
};

Map.prototype.initMap = function(){
    this.setMapChagenEvent();
};

Map.prototype.setMapChagenEvent = function(){
	var me = this;
	
	$("#sattliteMapButton").click(function(e){
		me.setMapChage.apply(me, [e]);
	});
	$("#baseMapButton").click(function(e){
		me.setMapChage.apply(me, [e]);
	});
	
	// openstreetmap, googleMap 버튼 이벤트 
	// $("#baseMapButton").click(function(e){
		// me.setMapChage.apply(me, [e]);
	// });
	
	// $("#baseMapButton").click(function(e){
		// me.setMapChage.apply(me, [e]);
	// });
};

Map.prototype.activeControl = function(controlName){
	var control = this.map.getControl(controlName);
	control.activate();
};

Map.prototype.setMapChage = function(e){
	if(e.currentTarget.id == "sattliteMapButton"){
		$("#sattliteMapButton").children("img").attr("src", "resources/images/map_toggleBtn_st.png");
		$("#baseMapButton").children("img").attr("src", "resources/images/map_toggleBtn_noActive.png");
		
		this.map.setBaseLayer(this.map.getLayersByName(Map.SATTLITEMAP_ID)[0]);
	}else if(e.currentTarget.id == "baseMapButton"){
		$("#sattliteMapButton").children("img").attr("src", "resources/images/map_toggleBtn_stActive.png");
		$("#baseMapButton").children("img").attr("src", "resources/images/map_toggleBtn_no.png");
		
		this.map.setBaseLayer(this.map.getLayersByName(Map.BASEMAP_ID)[0]);
	}
	/*
	$(".olControlPanZoomBar").css("left", "");
    $(".olControlPanZoomBar").css("right", ($("#eastPanel").width() + Layout.PANZOOMBAR_RIGHT_PADDING) + "px");*/
};

Map.prototype.makeVectorLayer = function(name, type, style){
	
	var layer = null;
	
	if(type == "Markers"){
		layer = new OpenLayers.Layer.Markers(name);
	}else if(type == "Vector"){
		if(style != null && style != undefined){
			layer = new OpenLayers.Layer.Vector(name, style);
		}else{
			layer = new OpenLayers.Layer.Vector(name);
		}
	}
	
	return layer;
};

Map.prototype.makeLayer = function(isTile, url, name, layers, options){
	var layer = null;
	
	if(isTile == true){
		
	}else{
		layer = new OpenLayers.Layer.WMS(
  		name,                                   
  		url,                                   
	  	{                                       
	  		layers: layers,                                       
	  		transparent: true                                  
	  	},
	  	options);
	}
	
	return layer;
};

Map.prototype.onOffLayer = function(name){
	var layer = this.map.getLayersByName(name)[0];
	layer.setVisibility(!layer.getVisibility());
};

Map.prototype.setDefaultZoom = function(){
	var fromProjection = new OpenLayers.Projection("EPSG:4326");
    var toProjection = new OpenLayers.Projection("EPSG:900913");
    var position12 = new OpenLayers.LonLat(127.6975412, 37.3959629366).transform(fromProjection, toProjection); 
    var zoom12 = 9;
	this.map.setCenter(position12, zoom12);
			
	// this.map.zoomToExtent(new OpenLayers.Bounds(13008405.420258, 3902317.875585, 15356550.928758, 4785318.4261772), true);
};
