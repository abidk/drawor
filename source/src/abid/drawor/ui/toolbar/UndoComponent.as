package abid.drawor.ui.toolbar {
	import abid.drawor.ui.*;
	import abid.drawor.ui.toolbar.tools.*;
	import flash.display.*;
	import flash.text.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class UndoComponent extends Sprite {
		
		private var canvas:Canvas;
		private var buttons:Array = new Array();
		
		public function UndoComponent(canvas:Canvas) {
			this.canvas = canvas;
			init();
		}
		
		public function init():void {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.size = 11;
			textFormat.font = "_sans";
			
			var undoTool:ToolbarButton = new ToolbarButton(50, 25);
			undoTool.setText("Undo");
			undoTool.setTextFormat(textFormat);
			undoTool.x = 0;
			undoTool.y = 0;
			undoTool.addEventListener(MouseEvent.CLICK, undoDrawHandler);
			buttons.push(undoTool);
			
			var redoTool:ToolbarButton = new ToolbarButton(50, 25);
			redoTool.setText("Redo");
			redoTool.setTextFormat(textFormat);
			redoTool.x = 50;
			redoTool.y = 0;
			redoTool.addEventListener(MouseEvent.CLICK, redoDrawHandler);
			buttons.push(redoTool);

			for (var index:String in buttons) {
				this.addChild(buttons[index])
			}
		}
		
		private function undoDrawHandler(event:MouseEvent):void {
			canvas.undo();
		}
		
		private function redoDrawHandler(event:MouseEvent):void {
			canvas.redo();
		}
	}
}