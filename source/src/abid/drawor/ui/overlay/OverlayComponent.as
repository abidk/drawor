package abid.drawor.ui.overlay {
	import abid.drawor.ui.CanvasOverlay;
	
	public interface OverlayComponent {
		
		function setOverlay(overlay:CanvasOverlay):void;
		function init():void;
		function destroy():void;
	}
}