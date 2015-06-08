package abid.drawor.ui.toolbar {
	import abid.drawor.ui.*;
	import flash.display.*;
	import flash.text.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class ColourComponent extends Sprite {
		
		private var buttons:Array = new Array();
		private var canvas:Canvas;
		
		public function ColourComponent(canvas:Canvas) {
			this.canvas = canvas;
			init();
		}
		
		public function init():void {
			buttons.push(buildButton(0, 0, 0xFFFFFF)); // white
			buttons.push(buildButton(25, 0, 0xFFFF00)); // yellow
			buttons.push(buildButton(50, 0, 0x99CC00)); // light green
			buttons.push(buildButton(75, 0, 0x339900)); // dark green
			
			buttons.push(buildButton(0, 25, 0xFF9900)); // orange
			buttons.push(buildButton(25, 25, 0xFF0000)); //red
			buttons.push(buildButton(50, 25, 0x3399FF)); // light blue
			buttons.push(buildButton(75, 25, 0x000FFF)); // dark blue
			
			buttons.push(buildButton(0, 50, 0xFF66CC)); // pink
			buttons.push(buildButton(25, 50, 0x660066)); // purple
			buttons.push(buildButton(50, 50, 0x993300)); // brown
			buttons.push(buildButton(75, 50, 0x000000, true)); // black
			
			for (var index:String in buttons) {
				this.addChild(buttons[index])
			}
		}
		
		private function buildButton(positionX:Number, positionY:Number, colour:uint, selected:Boolean = false):ToolbarButton {
			var colourBtn:ToolbarButton = new ToolbarButton(25, 25);
			colourBtn.x = positionX;
			colourBtn.y = positionY;
			colourBtn.setBackgroundColour(colour);
			colourBtn.setSelected(selected);
			colourBtn.setRolloverEnabled(false);
			colourBtn.addEventListener(MouseEvent.CLICK, selectColour);
			
			function selectColour(event:MouseEvent):void {
				resetButtons();
				canvas.setBrushColour(colour);
				colourBtn.setSelected(true);
			}
			return colourBtn;
		}
		
		private function resetButtons():void {
			for (var index:String in buttons) {
				var btn:ToolbarButton = buttons[index];
				btn.reset();
			}
		}
	}

}