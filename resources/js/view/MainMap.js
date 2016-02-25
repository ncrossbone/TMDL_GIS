/**
 * 
 */

function MainMap(){
	
};

MainMap.prototype = new Map();
/*
MainMap.prototype = Object.create(Map.prototype, {
	constructor : {
		value : MainMap
	}
});
*/
/*
if(typeof Object.create !=='function'){
	Object.create = function(o){
		if(arguments.length>1){
			throw new Error('Object.create implementation only accepts the first parameter.');
		}
		function F(){}
		F.prototype =o;
		return new F();
	};
}
*/
MainMap.prototype.initMap =
	
	function(){
	Map.prototype.initMap.call(this);
	
	this.setDefaultZoom();
    
    // this.map.addControl(new OpenLayers.Control.PanZoomBar());
    this.map.addControl(new OpenLayers.Control.MousePosition());
    this.map.addControl(new OpenLayers.Control.Navigation());
    this.map.addControl(new OpenLayers.Control.Attribution({separator:" "}));
    this.map.addControl(new OpenLayers.Control.NavigationHistory({id : "historyControl"}));
    
    var template = {
    	strokeOpacity : 1.0,
		fillOpacity : 0.0,
		strokeWidth : 0.5,
		strokeDashstyle : "solid",
		strokeColor : "#F2FF00"
	};

	var style = new OpenLayers.Style(template);
	var styleMap = new OpenLayers.StyleMap({
		'default' : style
	});
  
	this.map.addLayer(this.makeVectorLayer("vectorLayer", "Vector", {
		styleMap : styleMap
	}));
	
	var template1 = {
    	strokeOpacity : 1.0,
		fillOpacity : 0.7,
		strokeWidth : 0.5,
		strokeDashstyle : "solid",
		strokeColor : "#F2FF00",
		fillColor : "${fillColor}"
	};

	var context = {
		fillColor : function(feature,a,b,c,d){
			var color = "";			
			var sampleCount = feature.attributes.SAMPLE_COUNT;		
			//#279D47
			if(sampleCount >= 1 && sampleCount < 2){
				color = "#279D47";
			}else if(sampleCount >= 2 && sampleCount < 5){
				color = "#FFFF00";
			}else if(sampleCount >= 5 && sampleCount < 10){
				color = "#FF6600";
			}else if(sampleCount >= 10 && sampleCount < 100){
				color = "#4B007D";
			}			
			return color;			
		}
	};

	var style1 = new OpenLayers.Style(template1, {
		context : context
	});
	var styleMap1 = new OpenLayers.StyleMap({
		'default' : style1
	});
/*
	var layerListeners = {
			featureclick: function(e) {
				  alert('Sample Count :' + e.feature.attributes.SAMPLE_COUNT);
	    	    return false;
			},
	};
*/	
	this.map.addLayer(this.makeVectorLayer("vectorLayerSelect", "Vector", {
		styleMap : styleMap1,
		//eventListeners: layerListeners
	}));
	
	this.createGridLayer();
	
	var vectorLayer = this.map.getLayersByName("vectorLayerSelect");
	 //Add a selector control to the vectorLayer with popup functions
    var controls = {
      selector: new OpenLayers.Control.SelectFeature(vectorLayer, { onSelect: createPopup, onUnselect: destroyPopup })
    };

    function createPopup(feature) {
      feature.popup = new OpenLayers.Popup.FramedCloud("pop",
          feature.geometry.getBounds().getCenterLonLat(),
          null,
          '<div class="markerContent"> Sample Count : '+feature.attributes.SAMPLE_COUNT+'</div>',
          null,
          true,
          function() { controls['selector'].unselectAll(); }
      );
      //feature.popup.closeOnMove = true;
      this.map.addPopup(feature.popup);
    }

    function destroyPopup(feature) {
      feature.popup.destroy();
      feature.popup = null;
    }
    
    this.map.addControl(controls['selector']);
    controls['selector'].activate();
};

MainMap.prototype.searchGrid = function(speciesName){
	var appearDateCheckbox = $("#appearDateCheckbox");
	var appearMonth = "";
	var surfaceTemp = "";
	var bottomTemp = "";
	if($(appearDateCheckbox).is(":checked") == true){
		appearMonth = $("#appearMonthSelect").val();
	}else{
		if($("#surfaceInputRadio").attr("checked")){
			surfaceTemp = $("#tempSelect").val();
		}else{
			bottomTemp = $("#tempSelect").val();
		}
	}
	
	var me = this;
	
	$.ajax({
		url : "searchGrid.geojson",
		dataType : "json",
		data : {
			speciesName : speciesName,
			appearMonth : appearMonth,
			surfaceTemp : surfaceTemp,
			bottomTemp : bottomTemp
		}
	}).done(function(data){
		var result = data.d;
		
		if(result != ""){
			var featureString = result.featureString;
			var colInfo = result.gridColumnInfo;
		
			var json = new OpenLayers.Format.GeoJSON();
			var jsonFeatures = json.read(featureString);
			
			var map = me.getMap();
			
			var jsonLayer = map.getLayersByName("vectorLayerSelect");
			jsonLayer[0].removeAllFeatures();
			jsonLayer[0].addFeatures(jsonFeatures);
		}else{
			var map = me.getMap();
			
			var jsonLayer = map.getLayersByName("vectorLayerSelect");
			jsonLayer[0].removeAllFeatures();
		}
	});
};

MainMap.prototype.createGridLayer = function(){
	var me = this;
	
	$.ajax({
		url : "getGridFeature.geojson",
		dataType : "json"
	}).done(function(data){
		var result = data.d;
		var json = new OpenLayers.Format.GeoJSON();
		var jsonFeatures = json.read(result);
		
		var map = me.getMap();
		
		var jsonLayer = map.getLayersByName("vectorLayer");
		jsonLayer[0].removeAllFeatures();
		jsonLayer[0].addFeatures(jsonFeatures);
	});
};
