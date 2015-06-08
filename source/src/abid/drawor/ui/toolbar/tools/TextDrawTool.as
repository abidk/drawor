package abid.drawor.ui.toolbar.tools {
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import abid.drawor.ui.components.InputText;
	import abid.drawor.utils.*;
	import flash.events.*;
	import flash.display.*;
	import flash.text.TextField;
	
	public class TextDrawTool implements DrawTool {
		
		private var imageUtils:ImageUtils = new ImageUtils();
		private var canvas:Canvas;
		
		private var drawing:Boolean = false;
		private var textInput:InputText;
		private var startPointX:int;
		private var startPointY:int;
		
		public function TextDrawTool(canvas:Canvas) {
			this.canvas = canvas;
		}
		
		public function registerComponent():void {
			this.canvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawLine);
			this.canvas.addEventListener(MouseEvent.MOUSE_MOVE, moveLine);
			this.canvas.addEventListener(MouseEvent.MOUSE_UP, stopDrawLine);
		}
		
		public function unregisterComponent():void {
			this.canvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawLine);
			this.canvas.removeEventListener(MouseEvent.MOUSE_MOVE, moveLine);
			this.canvas.removeEventListener(MouseEvent.MOUSE_UP, stopDrawLine);
		}
		
		private function startDrawLine(event:MouseEvent):void {
			if (!drawing && !(event.target is TextField)) {
				drawing = true;
				startPointX = this.canvas.mouseX;
				startPointY = this.canvas.mouseY;
				
				textInput = new InputText();
				textInput.x = startPointX;
				textInput.y = startPointY;
				textInput.setTextColor(canvas.getBrushColour());
				canvas.addImage(textInput);
			}
		}
		
		private function moveLine(event:MouseEvent):void {
			if (drawing) {
				var endX:Number = this.canvas.mouseX;
				var endY:Number = this.canvas.mouseY;
				textInput.width = (endX - startPointX);
				textInput.height = (endY - startPointY);
			}
		}
		
		private function stopDrawLine(event:MouseEvent):void {
			drawing = false;
		}
	}
}