package abid.drawor {
	import abid.drawor.ui.*;
	import abid.drawor.ui.dialog.*;
	import abid.drawor.ui.overlay.*;
	import abid.drawor.ui.components.*;
	import abid.drawor.ui.toolbar.tools.*;
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.net.*;
	import flash.ui.*;
	
	public class Application extends MovieClip {
		
		private var baseUrl:String = "http://www.drawor.com/";
		private var saveUrl:String;
		private var viewUrl:String;
		private var imageUrl:String;
		
		private var toolbar:Toolbar;
		private var canvas:Canvas;
		private var canvasOverlay:CanvasOverlay;
		
		private var dialogManager:DialogManager;
		
		private var gridOverlay:GridOverlayComponent;
		private var mouseOverlay:MouseOverlayComponent;
		
		public function Application() {
			trace("Aplication width: " + stage.stageWidth);
			trace("Aplication height: " + stage.stageHeight);
			
			if (new LocalConnection().domain != null) {
				baseUrl = "http://" + new LocalConnection().domain + "/";
			}
			
			//if (ExternalInterface.available) {
			//	var browserUrl:String = String(ExternalInterface.call("window.location.href.toString"));
			//	if (browserUrl != null && browserUrl.indexOf("localhost") != -1) {
			//		baseUrl = "http://localhost/";
			//	}
			//}
			
			
			var imageId:String = this.loaderInfo.parameters.id
			//LoaderInfo(this.root.loaderInfo).parameters.id;
			if (imageId != null) {
				imageUrl = baseUrl + "drawor/" + imageId.toString();
			}
			
			saveUrl = baseUrl + "draw";
			viewUrl = baseUrl + "view";
			
			trace("Base Url: " + baseUrl);
			trace("Upload Url: " + saveUrl);
			trace("View Url: " + viewUrl);
			trace("Image Url: " + imageUrl);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			canvas = new Canvas(this, 700, 500);
			canvas.resetCanvas();
			canvas.setDrawTool(new PencilDrawTool(canvas));
			canvas.x = 0;
			canvas.y = 0;
			addChild(canvas);
			
			gridOverlay = new GridOverlayComponent();
			mouseOverlay = new MouseOverlayComponent();
			
			canvasOverlay = new CanvasOverlay(canvas);
			canvasOverlay.x = 0;
			canvasOverlay.y = 0;
			canvasOverlay.registerComponent(gridOverlay);
			canvasOverlay.registerComponent(mouseOverlay);
			addChild(canvasOverlay);
			
			toolbar = new Toolbar(this, 100, 500);
			toolbar.x = 700;
			toolbar.y = 0;
			addChild(toolbar);
			
			dialogManager = DialogManager.INSTANCE;
			addChild(dialogManager);
		}
		
		public function getBaseUrl():String {
			return baseUrl;
		}
		
		public function getSaveUrl():String {
			return saveUrl;
		}
		
		public function getImageUrl():String {
			return imageUrl;
		}
		
		public function getViewUrl():String {
			return viewUrl;
		}
		
		public function getCanvas():Canvas {
			return canvas;
		}
		
		public function getToolbar():Toolbar {
			return toolbar;
		}
		
		public function getDialogManager():DialogManager {
			return dialogManager;
		}
		
		public function getGridOverlay():GridOverlayComponent {
			return gridOverlay;
		}
		
		public function getMouseOverlay():MouseOverlayComponent {
			return mouseOverlay;
		}
	}
}