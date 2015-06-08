package abid.drawor.ui {
	import abid.drawor.*;
	import abid.drawor.ui.toolbar.tools.*;
	import abid.drawor.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.*;
	
	public class Canvas extends Sprite {
		
		public static const DEFAULT_BRUSH_SIZE:Number = 10;
		public static const DEFAULT_BRUSH_COLOUR:uint = 0x000000;
		
		private var newImages:Array = new Array();
		private var oldImages:Array = new Array();
		
		private var application:Application;
		private var drawTool:DrawTool;
		private var canvasWidth:int;
		private var canvasHeight:int;
		private var brushSize:Number = DEFAULT_BRUSH_SIZE;
		private var brushColour:uint = DEFAULT_BRUSH_COLOUR;
		
		public function Canvas(application:Application, width:int, height:int) {
			this.application = application;
			this.canvasWidth = width;
			this.canvasHeight = height;
		
			loadExternalImage();
		}
		
		public function getApplication():Application {
			return application;
		}
		
		public function getCanvasWidth():int {
			return canvasWidth;
		}
		
		public function getCanvasHeight():int {
			return canvasHeight;
		}
		
		private function loadExternalImage():void {
			if (application.getImageUrl() != null) {
				var imageLoader:Loader = new Loader();
				imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderReady);
				imageLoader.load(new URLRequest(application.getImageUrl()));
				function onLoaderReady(e:Event):void {
					addImage(imageLoader);
				}
			}
		}
		
		public function getDrawTool():DrawTool {
			return drawTool;
		}
		
		public function setDrawTool(newDrawTool:DrawTool):void {
			if (drawTool != null) {
				drawTool.unregisterComponent();
			}
			drawTool = newDrawTool;
			drawTool.registerComponent();
		}
		
		public function getBrushSize():Number {
			return brushSize;
		}
		
		public function setBrushSize(thickness:Number):void {
			brushSize = thickness;
			updateCanvas();
		}
		
		public function getBrushColour():uint {
			return brushColour;
		}
		
		public function setBrushColour(colour:uint):void {
			brushColour = colour;
			updateCanvas();
		}
		
		public function resetCanvas():void {
			newImages.splice(0);
			oldImages.splice(0);
			
			// remove any loose objects
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, canvasWidth, canvasHeight);
			graphics.endFill();
			updateCanvas();
		}
		
		private function updateCanvas():void {
			graphics.lineStyle(brushSize, brushColour);
		}
		
		public function addImage(img:DisplayObject):void {
			// remove old images
			oldImages.splice(0);
			
			// add new image
			newImages.push(img);
			this.addChild(img);
		}
		
		public function undo():void {
			var obj:DisplayObject = newImages.pop();
			if (obj != null) {
				oldImages.push(obj);
				this.removeChild(obj);
			}
		}
		
		public function redo():void {
			var obj:DisplayObject = oldImages.pop();
			if (obj != null) {
				newImages.push(obj);
				this.addChild(obj);
			}
		}
		
		public function getCanvasObjects():Array {
			return newImages;
		}
		
		public function getCanvasAsPNG():ByteArray {
			var imgUtils:ImageUtils = new ImageUtils();
			var canvasData:ByteArray = imgUtils.spriteToPngStream(this, canvasWidth, canvasHeight);
			return canvasData;
		}
	
	}
}