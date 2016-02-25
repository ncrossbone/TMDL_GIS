/**
 * 
 */
function Main() {
	this.mapMain = new MainMap();
	this.createMap('gisDiv');
	this.view = new View(this.mapMain);
};

Main.prototype.getMapClass = function() {
	return this.mapMain;
};

Main.prototype.getViewClass = function() {
	return this.view;
};

Main.prototype.createMap = function(mapContainerID) {
	$("#" + mapContainerID).css("position", "absolute");
	this.mapMain.ceateMap(mapContainerID);
	var map = this.mapMain.getMap();

	var sattliteLayer = this.mapMain.createSattliteMapLayer();
	var baseMap = this.mapMain.createBaseMapLayer();
	var osm = this.mapMain.createOpenStreetMapLayer();
	var googleMap = this.mapMain.createGoogleMapLayer();

	// sattliteLayer.isBaseLayer = true;
	sattliteLayer.isBaseLayer = true;
	map.addLayers([ sattliteLayer, baseMap, osm, googleMap ]);
	map.setBaseLayer(sattliteLayer);
	this.mapMain.initMap();
};

var Browser = {
	chk : navigator.userAgent.toLowerCase()
}
Browser = {
	ie : Browser.chk.indexOf('msie') != -1,
	ie6 : Browser.chk.indexOf('msie 6') != -1,
	ie7 : Browser.chk.indexOf('msie 7') != -1,
	ie8 : Browser.chk.indexOf('msie 8') != -1,
	ie9 : Browser.chk.indexOf('msie 9') != -1,
	ie10 : Browser.chk.indexOf('msie 10') != -1,
	opera : !!window.opera,
	safari : Browser.chk.indexOf('safari') != -1,
	safari3 : Browser.chk.indexOf('applewebkir/5') != -1,
	mac : Browser.chk.indexOf('mac') != -1,
	chrome : Browser.chk.indexOf('chrome') != -1,
	firefox : Browser.chk.indexOf('firefox') != -1
}