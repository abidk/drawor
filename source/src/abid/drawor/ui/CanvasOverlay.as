package abid.drawor.ui {
	import abid.drawor.ui.overlay.OverlayComponent;
	import flash.display.Sprite;
	
	public class CanvasOverlay extends Sprite {
		
		private var canvas:Canvas;
		
		public function CanvasOverlay(canvas:Canvas) {
			this.canvas = canvas;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function getCanvas():Canvas {
			return canvas;
		}
		
		public function registerComponent(component:OverlayComponent):void {
			component.setOverlay(this);
			component.init();
		}
		
		public function unregisterComponent(component:OverlayComponent):void {
			component.destroy();
		}
	}
}