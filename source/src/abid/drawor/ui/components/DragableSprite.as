package abid.drawor.ui.components {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class DragableSprite extends Sprite {
		
		private var isDragable:Boolean = false;
		
		public function DragableSprite() {
			this.useHandCursor = true;
			this.buttonMode = true;
			//this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseReleased);
			
			function mouseDown(event:MouseEvent):void {
				if (isDragable) {
					startDrag();
				}
			}
			
			function mouseReleased(event:MouseEvent):void {
				if (isDragable) {
					stopDrag();
				}
			}
		}
		
		public function setDrag(isDragable:Boolean):void {
			this.isDragable = isDragable;
		}
	
	}

}