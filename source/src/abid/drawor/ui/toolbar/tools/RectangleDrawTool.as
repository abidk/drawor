package abid.drawor.ui.toolbar.tools {
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import abid.drawor.utils.*;
	import flash.events.*;
	import flash.display.*;
	
	public class RectangleDrawTool implements DrawTool {
		
		private var imageUtils:ImageUtils = new ImageUtils();
		private var canvas:Canvas;
		private var drawing:Boolean = false;
		private var line:DragableSprite;
		private var startPointX:int;
		private var startPointY:int;
		private var fillRect:Boolean;
		
		public function RectangleDrawTool(canvas:Canvas) {
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
		
		public function setFillRect(fillRect:Boolean):void {
			this.fillRect = fillRect;
		}
		
		private function startDrawLine(event:MouseEvent):void {
			if (!drawing) {
				drawing = true;
				startPointX = this.canvas.mouseX;
				startPointY = this.canvas.mouseY;
				
				line = new DragableSprite();
				canvas.addImage(line);
			}
		}
		
		private function moveLine(event:MouseEvent):void {
			if (drawing) {
				line.graphics.clear();
				line.graphics.lineStyle(this.canvas.getBrushSize(), this.canvas.getBrushColour());
				
				if (fillRect) {
					line.graphics.beginFill(this.canvas.getBrushColour());
					drawRectangle(line.graphics);
					line.graphics.endFill();
				} else {
					drawRectangle(line.graphics);
					
				}
			}
		}
		
		private function stopDrawLine(event:MouseEvent):void {
			drawing = false;
		}
		
		private function drawRectangle(graphics:Graphics):void {
			var endX:Number = this.canvas.mouseX;
			var endY:Number = this.canvas.mouseY;
			
			graphics.moveTo(startPointX, startPointY);
			graphics.drawRect(startPointX, startPointY, (endX - startPointX), (endY - startPointY));
		}
	}
}