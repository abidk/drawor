package abid.drawor.ui {
	import abid.drawor.*;
	import abid.drawor.ui.dialog.*;
	import abid.drawor.ui.toolbar.*;
	import abid.drawor.ui.components.*;
	import com.adobe.images.*;
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.text.*;
	
	public class Toolbar extends Sprite {
		
		public static const DEFAULT_BACKGROUND_COLOUR:uint = 0xC4C3E8;
		
		// an estimate value to make sure the canvas is not blank
		public static const DECENT_DRAWING_LENGTH:int = 2000;
		
		private var application:Application;
		private var toolbarWidth:Number;
		private var toolbarHeight:Number;
		private var fullscreenBtn:ToolbarButton;
		private var guidelineCheckbox:Checkbox;
		private var gridCheckbox:Checkbox;
		
		public function Toolbar(application:Application, width:Number, height:Number) {
			this.application = application;
			this.toolbarWidth = width;
			this.toolbarHeight = height;
			
			init();
		}
		
		public function init():void {
			this.graphics.beginFill(DEFAULT_BACKGROUND_COLOUR);
			this.graphics.drawRect(0, 0, toolbarWidth, toolbarHeight);
			this.graphics.endFill();
			
			fullscreenBtn = new ToolbarButton();
			fullscreenBtn.setText("Fullscreen");
			fullscreenBtn.x = 0;
			fullscreenBtn.y = 0;
			fullscreenBtn.addEventListener(MouseEvent.CLICK, fullscreenHandler);
			addChild(fullscreenBtn);
			
			var brushComponent:BrushComponent = new BrushComponent(application.getCanvas());
			brushComponent.x = 0;
			brushComponent.y = 75;
			addChild(brushComponent);
			
			var toolComponent:ToolComponent = new ToolComponent(application.getCanvas());
			toolComponent.x = 0;
			toolComponent.y = 100;
			addChild(toolComponent);
			
			var colourComponent:ColourComponent = new ColourComponent(application.getCanvas());
			colourComponent.x = 0;
			colourComponent.y = 175;
			addChild(colourComponent);
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.size = 11;
			textFormat.font = "_sans";
			
			var clearBtn:ToolbarButton = new ToolbarButton(100, 25);
			clearBtn.setText("Clear Canvas");
			clearBtn.setTextFormat(textFormat);
			clearBtn.x = 0;
			clearBtn.y = 250;
			clearBtn.addEventListener(MouseEvent.CLICK, clearCanvasHandler);
			addChild(clearBtn);
			
			var undoComponent:UndoComponent = new UndoComponent(application.getCanvas());
			undoComponent.x = 0;
			undoComponent.y = 275;
			addChild(undoComponent);
			
			guidelineCheckbox = new Checkbox();
			guidelineCheckbox.setText("Show Guideline");
			guidelineCheckbox.x = 0;
			guidelineCheckbox.y = 325;
			guidelineCheckbox.addEventListener(MouseEvent.CLICK, guidelineHandler);
			addChild(guidelineCheckbox);
			
			gridCheckbox = new Checkbox();
			gridCheckbox.setText("Show Grid");
			gridCheckbox.x = 0;
			gridCheckbox.y = 350;
			gridCheckbox.addEventListener(MouseEvent.CLICK, gridHandler);
			addChild(gridCheckbox);
			
			var saveBtn:ToolbarButton = new ToolbarButton();
			saveBtn.setText("Save");
			saveBtn.x = 0;
			saveBtn.y = 450;
			saveBtn.addEventListener(MouseEvent.CLICK, uploadHandler);
			addChild(saveBtn);
		}
		
		private function clearCanvasHandler(event:MouseEvent):void {
			application.getDialogManager().showDialog("Are you sure you want to clear the canvas?", "Clear", onOK, "Cancel");
			function onOK():void {
				application.getCanvas().resetCanvas();
			}
		}
		
		private function guidelineHandler(event:MouseEvent):void {
			application.getMouseOverlay().enableGuideline(guidelineCheckbox.isSelected());
		}
		
		private function gridHandler(event:MouseEvent):void {
			application.getGridOverlay().setActive(gridCheckbox.isSelected());
		}
		
		private function uploadHandler(event:MouseEvent):void {
			var canvasData:ByteArray = this.application.getCanvas().getCanvasAsPNG();
			
			if (canvasData.length <= DECENT_DRAWING_LENGTH) {
				application.getDialogManager().showDialog("Please draw something appropriate!", "Okay");
				return;
			}
			
			application.getDialogManager().showDialog("Are you sure you want to save it?", "Save", onOK, "Cancel");
			function onOK():void {
				doPost(application.getSaveUrl(), canvasData);
			}
		}
		
		private function doPost(url:String, canvasData:ByteArray):void {
			trace("Uploading");
			
			var request:URLRequest = new URLRequest(url);
			request.contentType = "application/octet-stream"
			request.method = URLRequestMethod.POST;
			request.data = canvasData;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(Event.COMPLETE, loaderComplete);
			loader.load(request);
			
			function loaderComplete(event:Event):void {
				trace("Upload complete!");
				
				var value:String = event.target.data;
				trace("Image Id=" + value);
				
				application.getCanvas().resetCanvas();
				DialogManager.INSTANCE.showDialog("Drawing saved!", "View Image", onOK, "Continue");
				function onOK():void {
					navigateToURL(new URLRequest(application.getViewUrl() + "/" + value), "_self");
				}
			}
			
			function ioErrorHandler(event:IOErrorEvent):void {
				trace("ioErrorHandler: " + event);
				DialogManager.INSTANCE.showDialog("Upload failed!", "Okay");
			}
		}
		
		private function fullscreenHandler(event:MouseEvent):void {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				fullscreenBtn.setText("Fullscreen");
				stage.displayState = StageDisplayState.NORMAL;
			} else {
				fullscreenBtn.setText("Normal");
				stage.fullScreenSourceRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}
	}

}