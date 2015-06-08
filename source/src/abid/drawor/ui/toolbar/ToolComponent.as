package abid.drawor.ui.toolbar {
	import abid.drawor.ui.*;
	import abid.drawor.ui.toolbar.tools.*;
	import flash.display.*;
	import flash.text.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class ToolComponent extends Sprite {
		
		private var canvas:Canvas;
		private var buttons:Array = new Array();
				
		public function ToolComponent(canvas:Canvas) {
			this.canvas = canvas;
			init();
		}
		
		public function init():void {
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xFFFFFF;
			textFormat.size = 11;
			textFormat.font = "_sans";
			
			var pencilTool:ToolbarButton = new ToolbarButton(25, 25);
			pencilTool.setBitmap(pencilClass);
			pencilTool.setTextFormat(textFormat);
			pencilTool.setSelected(true);
			pencilTool.x = 0;
			pencilTool.y = 0;
			pencilTool.addEventListener(MouseEvent.CLICK, pencilDrawHandler);
			buttons.push(pencilTool);
			
			var circleTool:ToolbarButton = new ToolbarButton(25, 25);
			circleTool.setBitmap(circleClass);
			circleTool.setTextFormat(textFormat);
			circleTool.x = 25;
			circleTool.y = 0;
			circleTool.addEventListener(MouseEvent.CLICK, circleDrawHandler);
			buttons.push(circleTool);
			
			var triangleTool:ToolbarButton = new ToolbarButton(25, 25);
			triangleTool.setBitmap(triangleClass);
			triangleTool.setTextFormat(textFormat);
			triangleTool.x = 50;
			triangleTool.y = 0;
			triangleTool.addEventListener(MouseEvent.CLICK, triangleDrawHandler);
			buttons.push(triangleTool);
			
			var rectangleTool:ToolbarButton = new ToolbarButton(25, 25);
			rectangleTool.setBitmap(squareClass);
			rectangleTool.setTextFormat(textFormat);
			rectangleTool.x = 75;
			rectangleTool.y = 0;
			rectangleTool.addEventListener(MouseEvent.CLICK, rectangleDrawHandler);
			buttons.push(rectangleTool);
			
			var lineTool:ToolbarButton = new ToolbarButton(25, 25);
			lineTool.setBitmap(lineClass);
			lineTool.setTextFormat(textFormat);
			lineTool.x = 0;
			lineTool.y = 25;
			lineTool.addEventListener(MouseEvent.CLICK, lineDrawHandler);
			buttons.push(lineTool);
			
			var circleFillTool:ToolbarButton = new ToolbarButton(25, 25);
			circleFillTool.setBitmap(circleFillClass);
			circleFillTool.setTextFormat(textFormat);
			circleFillTool.x = 25;
			circleFillTool.y = 25;
			circleFillTool.addEventListener(MouseEvent.CLICK, circleFillDrawHandler);
			buttons.push(circleFillTool);
			
			var triangleFillTool:ToolbarButton = new ToolbarButton(25, 25);
			triangleFillTool.setBitmap(triangleFillClass);
			triangleFillTool.setTextFormat(textFormat);
			triangleFillTool.x = 50;
			triangleFillTool.y = 25;
			triangleFillTool.addEventListener(MouseEvent.CLICK, triangleFillDrawHandler);
			buttons.push(triangleFillTool);
			
			var rectangleFillTool:ToolbarButton = new ToolbarButton(25, 25);
			rectangleFillTool.setBitmap(squareFillClass);
			rectangleFillTool.setTextFormat(textFormat);
			rectangleFillTool.x = 75;
			rectangleFillTool.y = 25;
			rectangleFillTool.addEventListener(MouseEvent.CLICK, rectangleFillDrawHandler);
			buttons.push(rectangleFillTool);
			
			var dragTool:ToolbarButton = new ToolbarButton(50, 25);
			dragTool.setText("Drag");
			dragTool.setTextFormat(textFormat);
			dragTool.x = 0;
			dragTool.y = 50;
			dragTool.addEventListener(MouseEvent.CLICK, dragHandler);
			buttons.push(dragTool);
			
			var textTool:ToolbarButton = new ToolbarButton(50, 25);
			textTool.setText("Text");
			textTool.setTextFormat(textFormat);
			textTool.x = 50;
			textTool.y = 50;
			textTool.addEventListener(MouseEvent.CLICK, textHandler);
			buttons.push(textTool);
			
			for (var index:String in buttons) {
				this.addChild(buttons[index])
			}
		}
		
		private function pencilDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			canvas.setDrawTool(new PencilDrawTool(canvas));
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function lineDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			canvas.setDrawTool(new LineDrawTool(canvas));
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function circleDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			
			var tool:CircleDrawTool = new CircleDrawTool(canvas);
			tool.setFillCircle(false);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function circleFillDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			
			var tool:CircleDrawTool = new CircleDrawTool(canvas);
			tool.setFillCircle(true);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function triangleDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			
			var tool:TriangleDrawTool = new TriangleDrawTool(canvas);
			tool.setFillTriangle(false);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function triangleFillDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			
			var tool:TriangleDrawTool = new TriangleDrawTool(canvas);
			tool.setFillTriangle(true);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function rectangleDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			var tool:RectangleDrawTool = new RectangleDrawTool(canvas);
			tool.setFillRect(false);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function rectangleFillDrawHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			var tool:RectangleDrawTool = new RectangleDrawTool(canvas);
			tool.setFillRect(true);
			canvas.setDrawTool(tool);
			canvas.getApplication().getMouseOverlay().enableCursor(true);
		}
		
		private function dragHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			canvas.setDrawTool(new DragDrawTool(canvas));
			canvas.getApplication().getMouseOverlay().enableCursor(false);
		}
		
		private function textHandler(event:MouseEvent):void {
			resetButtons();
			event.target.setSelected(true);
			canvas.setDrawTool(new TextDrawTool(canvas));
			canvas.getApplication().getMouseOverlay().enableCursor(false);
		}
		
		private function resetButtons():void {
			for (var index:String in buttons) {
				var btn:ToolbarButton = buttons[index];
				btn.reset();
			}
		}
		
		[Embed(source='pencil.png')]
		private var pencilClass:Class;
		[Embed(source='line.png')]
		private var lineClass:Class;
		[Embed(source='square.png')]
		private var squareClass:Class;
		[Embed(source='square_f.png')]
		private var squareFillClass:Class;
		[Embed(source='triangle.png')]
		private var triangleClass:Class;
		[Embed(source='triangle_f.png')]
		private var triangleFillClass:Class;
		[Embed(source='circle.png')]
		private var circleClass:Class;
		[Embed(source='circle_f.png')]
		private var circleFillClass:Class;
	}
}