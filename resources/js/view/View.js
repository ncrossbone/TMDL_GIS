/**
 * 
 */

function View(mapClass){
	this.mapClass = mapClass;
	
	this.setToolbarEvent(mapClass);
	this.createTree();
	this.createSearchPopup();
}

View.prototype.setToolbarEvent = function(mapClass){
	var map = mapClass.getMap();
	var me = mapClass;
	$(".Util_01").bind("click", function() {
		me.setDefaultZoom.apply(me, []);
	});
	
	$(".Util_02").bind("click", function() {
		me.map.zoomIn();
	});
	
	$(".Util_03").bind("click", function() {
		me.map.zoomOut();
	});
	
	$(".Util_04").bind("click", function() {
		var histroyControl = map.getControl('historyControl');
		histroyControl.previousTrigger();
	});
	
	$(".Util_05").bind("click", function() {
		var histroyControl = map.getControl('historyControl');
		histroyControl.nextTrigger(); 
	});
	
	$(".Util_06").bind("click", function() {
		$("#top13").dialog("open");
	});
	
	$(".Util_07").bind("click", function() {
		html2canvas(document.getElementById("gisDiv"), {
			allowTaint : false,
			proxy : "proxy.do",
			logging : false,
			useCORS : false,
			taintTest : false,
			onrendered: function(canvas) {
				document.body.appendChild(canvas);
				var strMime = "image/jpeg";
				var strDownloadMime = "image/octet-stream";
				var strData = canvas.toDataURL(strMime);
				$(canvas).remove();
				
				var popUrl = "print.do";
	
				var popOption = "width=635,height=500,resizable=yes,scrollbars=no,status=no";
				pWin = window.open(popUrl,"",popOption); 
				
				pWin.document.write("<img src='"+strData.replace(strMime, strDownloadMime)+"' alt='from canvas'/><script type='text/javascript'>setTimeout('window.print()', 1000);</script>");
			}
		});
	});
	
	$(".Util_08").bind("click", function() {
		//$("#modalPopup").html("<div style='width:100%;height:100%;'><p>이미지를 다운로드 중입니다.</p></div>");
		$('body').plainOverlay('show');
		// $("#modalPopup").dialog({
			// autoOpen : true,
			// draggable : false,
			// modal: true,
			// resizable: false,
			// title : "알림",
			// closeOnEscape: false
		// });

		html2canvas(document.getElementById("gisDiv"), {
			allowTaint : false,
			proxy : "proxy.do",
			logging : false,
			useCORS : false,
			taintTest : false,
			onrendered: function(canvas) {
				document.body.appendChild(canvas);
				var imageData = Canvas2Image.saveAsJPEG(canvas, false);
				$(canvas).remove();
				//$("#modalPopup").dialog("close");
				$('body').plainOverlay('hide');
			}
		});
	});
	
	$(".Util_11").bind("click", function() {
		$("#cont").dialog('open');
	});
};

View.prototype.createTree = function(){
	var title = "<div class='title_bar_4'>"
			+ "<div class='x'><img src='resources/images/gis/x.png' width='20' height='20' border='0' onclick='javascript:main.getViewClass().closeDialog(\"top13\");' style='cursor:pointer'></div>"
			+ "</div>";
			
	var html = "<div id='accordion'>"
	         + "";
	         
	var layerInfo = getLayerData();
	var map = this.mapClass.getMap();
	
	for(var a = 0; a < layerInfo.length; a++){
		html += "<div>";
		if(layerInfo[a].child != undefined){
			html += "<li class='closed'>" + layerInfo[a].name + "<ul>";
			var child = layerInfo[a].child;
			
			for(var aa = 0; aa < child.length; aa++){
				if(child[aa].option.visibility == true){
					html += "<li><input type='checkbox' onclick='main.getMapClass().onOffLayer(\"" + child[aa].id + "\")' checked='checked' id='" + child[aa].id + "'/>" + child[aa].name + "</li>";
				}else{
					html += "<li><input type='checkbox' onclick='main.getMapClass().onOffLayer(\"" + child[aa].id + "\")' id='" + child[aa].id + "'/>" + child[aa].name + "</li>";
				}
				
				map.addLayer(this.mapClass.makeLayer(false, getLayerUrl(), child[aa].id, getWorkSpaceName() + ":" + child[aa].layers, child[aa].option));
			}
			html += "</ul></li>";
			html += "</div>";
		}
	}
	
	html+ "</div>";
	
	$("#top13").empty();
	$("#top13").append(html);
	$("#accordion").treeview({
		//collapsed: true,
		//unique: true,
		//persist: "location"
	});
	$("#top13").dialog({
		id: top13,
		width: 250,
		height: 250,
		close: true,
		position: [940, 110]
	});
	
	$("#top13").parent("div").find(".ui-dialog-titlebar").html(title);
	$('#top13').dialog("close");
};

View.prototype.closeDialog = function(id){
	$('#' + id).dialog("close");
};

View.prototype.createSearchPopup = function(){
	var html = '<div class="title_bar_1">' +
					'<div class="x"><img src="resources/images/gis/x.png" width="20" height="20" border="0" onclick="javascript:main.getViewClass().closeDialog(\'cont\');"style="cursor:pointer"></div>' +
				'</div>';
	$("#cont").dialog({
		id: top13,
		width: 279,
		height: 270,
		close: true,
		position: [940, 110]
	});
	
	$("#cont").parent("div").find(".ui-dialog-titlebar").html(html);
	$('#cont').dialog("close");
};
