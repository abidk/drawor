package abid.drawor.ui.overlay {
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import abid.drawor.ui.components.GridShape;
	import abid.drawor.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.net.*;
	import flash.ui.*;
	
	public class MouseOverlayComponent implements OverlayComponent {
		
		private var overlay:CanvasOverlay;
		private var cursor:Shape;
		private var guideline:Shape;
		private var enabledCursor:Boolean = true;
		private var enabledGuideline:Boolean = false;
		
		public function MouseOverlayComponent() {
		}
		
		public function setOverlay(overlay:CanvasOverlay):void {
			this.overlay = overlay;
		}
		
		public function init():void {
			guideline = new Shape();
			overlay.addChild(guideline);
			
			cursor = new Shape();
			overlay.addChild(cursor);
			overlay.getCanvas().addEventListener(MouseEvent.ROLL_OVER, showCursor);
			overlay.getCanvas().addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			overlay.getCanvas().addEventListener(MouseEvent.ROLL_OUT, hideCursor);
		}
		
		public function destroy():void {
			overlay.removeChild(cursor);
			overlay.getCanvas().removeEventListener(MouseEvent.ROLL_OVER, showCursor);
			overlay.getCanvas().removeEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			overlay.getCanvas().removeEventListener(MouseEvent.ROLL_OUT, hideCursor);
		}
		
		public function enableGuideline(active:Boolean):void {
			this.enabledGuideline = active;
		}
		
		public function enableCursor(active:Boolean):void {
			this.enabledCursor = active;
		}
		
		private function showCursor(evt:MouseEvent):void {
			var brushColour:uint = overlay.getCanvas().getBrushColour();
			var brushSize:int = overlay.getCanvas().getBrushSize();
			
			if (brushColour == 0xFFFFFF) {
				// if cursor is white then set it black instead				
				brushColour = 0x000000;
			}
			
			if (enabledCursor == true) {
				cursor.graphics.clear();
				cursor.graphics.lineStyle(2, 0xFFFFFF);
				cursor.graphics.drawCircle(0, 0, brushSize / 2);
				cursor.graphics.lineStyle(1, brushColour);
				cursor.graphics.drawCircle(0, 0, brushSize / 2);
				cursor.visible = true;
				Mouse.hide();
			}
		}
		
		private function hideCursor(evt:MouseEvent):void {
			guideline.visible = false;
			cursor.visible = false;
			
			if (enabledCursor == true) {
				Mouse.show();
			}
		}
		
		private function moveCursor(evt:MouseEvent):void {
			if (enabledCursor == true) {
				cursor.x = evt.stageX;
				cursor.y = evt.stageY;
			}
			
			if (enabledGuideline == true) {
				var canvasWidth:int = overlay.getCanvas().getCanvasWidth();
				var canvasHeight:int = overlay.getCanvas().getCanvasHeight();
				
				guideline.graphics.clear();
				guideline.graphics.lineStyle(1, 0xDEDEDE);
				guideline.graphics.moveTo(0, evt.stageY);
				guideline.graphics.lineTo(canvasWidth, evt.stageY);
				guideline.graphics.moveTo(evt.stageX, 0);
				guideline.graphics.lineTo(evt.stageX, canvasHeight);
				guideline.visible = true;
			}
			
			evt.updateAfterEvent();
		}
	}
}
