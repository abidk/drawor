package abid.drawor.ui.toolbar.tools {
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.*;
	import flash.events.*;
	import flash.display.*;
	
	public class PencilDrawTool implements DrawTool {
		
		private var canvas:Canvas;
		private var line:DragableSprite;
		private var drawing:Boolean = false;
		
		public function PencilDrawTool(canvas:Canvas) {
			this.canvas = canvas;
		}
		
		public function registerComponent():void {
			this.canvas.addEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
			this.canvas.addEventListener(MouseEvent.MOUSE_MOVE, draw);
			this.canvas.addEventListener(MouseEvent.MOUSE_UP, stopDrawing);
			this.canvas.addEventListener(MouseEvent.ROLL_OUT, blankDraw);
		}
		
		public function unregisterComponent():void {
			this.canvas.removeEventListener(MouseEvent.MOUSE_DOWN, startDrawing);
			this.canvas.removeEventListener(MouseEvent.MOUSE_MOVE, draw);
			this.canvas.removeEventListener(MouseEvent.MOUSE_UP, stopDrawing);
			this.canvas.removeEventListener(MouseEvent.ROLL_OUT, blankDraw);
		}
		
		private function startDrawing(event:MouseEvent):void {
			drawing = true;
			
			line = new DragableSprite();
			line.graphics.lineStyle(this.canvas.getBrushSize(), this.canvas.getBrushColour());
			line.graphics.moveTo(this.canvas.mouseX, this.canvas.mouseY);
			line.graphics.lineTo(this.canvas.mouseX + 1, this.canvas.mouseY);
			canvas.addImage(line);
		}
		
		private function draw(event:MouseEvent):void {
			if (drawing) {
				line.graphics.lineTo(this.canvas.mouseX, this.canvas.mouseY);
			}
		}
		
		private function blankDraw(event:MouseEvent):void {
		}
		
		private function stopDrawing(event:MouseEvent):void {
			drawing = false;
		}
	}

}