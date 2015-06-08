package abid.drawor.ui.toolbar.tools {
	import abid.drawor.*;
	import abid.drawor.ui.*;
	import abid.drawor.ui.components.DragableSprite;
	import abid.drawor.utils.*;
	import flash.events.*;
	import flash.display.*;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class DragDrawTool implements DrawTool {
		
		private var glowFilter:GlowFilter = new GlowFilter(0x121212, 0.8, 10, 10, 1, 1, false, false);
		private var canvas:Canvas;
		
		public function DragDrawTool(canvas:Canvas) {
			this.canvas = canvas;
		}
		
		public function registerComponent():void {
			enableDrag(true);
		}
		
		public function unregisterComponent():void {
			enableDrag(false);
		}
		
		private function enableDrag(dragEnabled:Boolean):void {
			var objs:Array = canvas.getCanvasObjects();
			for (var index:String in objs) {
				var obj:Object = objs[index];
				if (obj is DragableSprite) {
					var sprite:DragableSprite = DragableSprite(obj);
					sprite.setDrag(dragEnabled);
					
					if (dragEnabled == true) {
						sprite.addEventListener(MouseEvent.MOUSE_OVER, focusObject);
						sprite.addEventListener(MouseEvent.MOUSE_OUT, unfocusObject);
					} else {
						sprite.removeEventListener(MouseEvent.MOUSE_OVER, focusObject);
						sprite.removeEventListener(MouseEvent.MOUSE_OUT, unfocusObject);
					}
				}
			}
		}
		
		private function focusObject(e:MouseEvent):void {
			var obj:Object = e.target;
			if (obj is DragableSprite) {
				var sprite:Sprite = Sprite(obj);
				sprite.filters = [glowFilter];
			}
		}
		
		private function unfocusObject(e:MouseEvent):void {
			var obj:Object = e.target;
			if (obj is DragableSprite) {
				var sprite:Sprite = Sprite(obj);
				sprite.filters = [];
			}
		}
	}
}