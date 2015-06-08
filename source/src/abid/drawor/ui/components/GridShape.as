package abid.drawor.ui.components {
	import flash.display.Shape;
	
	public class GridShape extends Shape {
		
		public static const DEFAULT_GAP:Number = 30;
		public static const DEFAULT_COLOUR:uint = 0xDEDEDE;
		
		public function GridShape(width:Number, height:Number) {
			graphics.clear();
			graphics.lineStyle(1, DEFAULT_COLOUR);
			for (var i:int = 0; i < width; i += DEFAULT_GAP) {
				graphics.moveTo(i, 0);
				graphics.lineTo(i, height);
			}
			for (var k:int = 0; k < height; k += DEFAULT_GAP) {
				graphics.moveTo(0, k);
				graphics.lineTo(width, k);
			}
		}
	
	}

}