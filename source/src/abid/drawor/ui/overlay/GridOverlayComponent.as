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
	
	public class GridOverlayComponent implements OverlayComponent {
		
		private var overlay:CanvasOverlay;
		private var grid:GridShape;
		
		public function GridOverlayComponent() {
		}
		
		public function setOverlay(overlay:CanvasOverlay):void {
			this.overlay = overlay;
		}
		
		public function init():void {
			grid = new GridShape(overlay.getCanvas().getCanvasWidth(), overlay.getCanvas().getCanvasHeight());
			grid.visible = false;
			overlay.addChild(grid);
		}
		
		public function destroy():void {
			overlay.removeChild(grid);
		}
		
		public function setActive(active:Boolean):void {
			grid.visible = active;
		}
	}
}
