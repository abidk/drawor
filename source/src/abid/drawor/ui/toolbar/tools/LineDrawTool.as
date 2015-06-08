package abid.drawor.ui.toolbar.tools {
	
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import flash.events.*;
	import flash.display.*;
	
	public class LineDrawTool implements DrawTool {
		
		private var canvas:Canvas;
		private var drawing:Boolean = false;
		private var line:DragableSprite;
		private var startPointX:int;
		private var startPointY:int;
		
		public function LineDrawTool(canvas:Canvas) {
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
				drawLine(line.graphics);
			}
		}
		
		private function stopDrawLine(event:MouseEvent):void {
			drawing = false;
		}
		
		private function drawLine(graphics:Graphics):void {
			var endX:Number = this.canvas.mouseX;
			var endY:Number = this.canvas.mouseY;
			graphics.moveTo(startPointX, startPointY);
			graphics.lineTo(endX, endY);
		}
	}
}