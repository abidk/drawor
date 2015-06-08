package abid.drawor.ui.toolbar {
	import abid.drawor.ui.*;
	import flash.display.*;
	import flash.text.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class BrushComponent extends Sprite {
		
		public static const DEFAULT_MIN_BRUSH_SIZE:Number = 1;
		public static const DEFAULT_MAX_BRUSH_SIZE:Number = 99;
		
		private var canvas:Canvas;
		private var brushSize:Number;
		
		private var increaseSizeBtn:ToolbarButton;
		private var decreaseSizeBtn:ToolbarButton;
		private var sizeField:TextField;
		
		public function BrushComponent(canvas:Canvas) {		
			this.canvas = canvas;
			this.brushSize = canvas.getBrushSize();
			init();
		}
		
		public function init():void {
			this.graphics.beginFill(0xDEDEDE);
			this.graphics.drawRect(0, 0, 100, 25);
			this.graphics.endFill();
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.bold = false;
			textFormat.size = 12;
			textFormat.font = "_sans";
			
			decreaseSizeBtn = new ToolbarButton(25, 25);
			decreaseSizeBtn.setTextFormat(textFormat);
			decreaseSizeBtn.setText("◄");
			decreaseSizeBtn.x = 0;
			decreaseSizeBtn.y = 0;
			decreaseSizeBtn.addEventListener(MouseEvent.MOUSE_DOWN, decreaseSizeHandler);
			addChild(decreaseSizeBtn);

			increaseSizeBtn = new ToolbarButton(25, 25);
			increaseSizeBtn.setTextFormat(textFormat);
			increaseSizeBtn.setText("►");
			increaseSizeBtn.x = 75;
			increaseSizeBtn.y = 0;
			increaseSizeBtn.addEventListener(MouseEvent.CLICK, increaseSizeHandler);
			addChild(increaseSizeBtn);
			
			var sizeTextFormat:TextFormat = new TextFormat();
			sizeTextFormat.align = TextFormatAlign.CENTER;
			sizeTextFormat.color = 0x000;
			sizeTextFormat.bold = false;
			sizeTextFormat.size = 12;
			sizeTextFormat.font = "_sans";
			
			sizeField = new TextField();
			sizeField.type = TextFieldType.INPUT;
			sizeField.defaultTextFormat = sizeTextFormat;
			sizeField.text = new String(brushSize);
			sizeField.restrict = "0-9";
			sizeField.x = 25;
			sizeField.y = 3;
			sizeField.width = 50;
			sizeField.height = 25;
			sizeField.addEventListener(KeyboardEvent.KEY_UP, customSizeHandler)
			addChild(sizeField);
			
			refreshComponent();
		}
		
		private function customSizeHandler(event:KeyboardEvent):void {
			var inputSize:int = int(sizeField.text);
			if (inputSize < DEFAULT_MIN_BRUSH_SIZE) {
				inputSize = DEFAULT_MIN_BRUSH_SIZE;
			} else if (inputSize > DEFAULT_MAX_BRUSH_SIZE) {
				inputSize = DEFAULT_MAX_BRUSH_SIZE;
			}
			brushSize = inputSize;
			canvas.setBrushSize(inputSize);
			refreshComponent();
		}
		
		private function decreaseSizeHandler(event:MouseEvent):void {
			if (brushSize > DEFAULT_MIN_BRUSH_SIZE) {
				brushSize--;
			}
			canvas.setBrushSize(brushSize);
			refreshComponent();
		}
		
		private function increaseSizeHandler(event:MouseEvent):void {
			if (brushSize < DEFAULT_MAX_BRUSH_SIZE) {
				brushSize++;
			}
			canvas.setBrushSize(brushSize);
			refreshComponent();
		}
		
		private function refreshComponent():void {
			sizeField.text = new String(brushSize);
		}
	
	}

}