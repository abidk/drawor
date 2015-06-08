package abid.drawor.ui.toolbar.tools {
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import abid.drawor.utils.*;
	import flash.events.*;
	import flash.display.*;
	
	public class CircleDrawTool implements DrawTool {
		
		private var imageUtils:ImageUtils = new ImageUtils();
		private var canvas:Canvas;
		private var drawing:Boolean = false;
		private var circleShape:DragableSprite;
		private var fillCircle:Boolean;
		private var startPointX:int;
		private var startPointY:int;
		
		public function CircleDrawTool(canvas:Canvas) {
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
				
				circleShape = new DragableSprite();
				canvas.addImage(circleShape);
			}
		}
		
		private function moveLine(event:MouseEvent):void {
			if (drawing) {
				circleShape.graphics.clear();
				circleShape.graphics.lineStyle(this.canvas.getBrushSize(), this.canvas.getBrushColour());
				
				if (fillCircle) {
					circleShape.graphics.beginFill(this.canvas.getBrushColour());
					drawCircle(circleShape.graphics);
					circleShape.graphics.endFill();
				} else {
					drawCircle(circleShape.graphics);
				}
			}
		}
		
		public function setFillCircle(fillCircle:Boolean):void {
			this.fillCircle = fillCircle;
		}
		
		private function stopDrawLine(event:MouseEvent):void {
			drawing = false;
		}
				
		private function drawCircle(graphics:Graphics):void {
			var endX:Number = this.canvas.mouseX;
			var endY:Number = this.canvas.mouseY;
			var radius:Number = imageUtils.distanceBetweenTwoPoints(startPointX, startPointY, endX, endY);
			
			//graphics.moveTo(startPointX, startPointY);
			graphics.drawCircle(startPointX, startPointY, radius);
		}
	}
}