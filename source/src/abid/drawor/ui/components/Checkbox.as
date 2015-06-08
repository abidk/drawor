package abid.drawor.ui.components {
	import abid.drawor.ui.*;
	import flash.display.*;
	import flash.text.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	public class Checkbox extends Sprite {
		
		private var selected:Boolean = false;
		private var text:String;
		
		private var textField:TextField;
		private var box:Sprite;
		
		public function Checkbox() {
			init();
		}
		
		public function setText(text:String):void {
			this.text = text;
			refreshComponent();
		}
		
		public function setSelected(selected:Boolean):void {
			this.selected = selected;
		}
		
		public function isSelected():Boolean {
			return selected;
		}
		
		public function init():void {
			box = new Sprite();
			box.addEventListener(MouseEvent.CLICK, boxSelected);
			addChild(box);
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.align = TextFormatAlign.LEFT;
			textFormat.color = 0x000;
			textFormat.bold = false;
			textFormat.size = 11;
			textFormat.font = "_sans";
			
			textField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.mouseEnabled = false;
			textField.text = "n/a";
			textField.x = 14;
			textField.y = 0;
			addChild(textField);
			
			refreshComponent();
		}
		
		private function boxSelected(evt:MouseEvent):void {
			selected = !selected;
			refreshComponent();
		}
		
		private function refreshComponent():void {
			box.graphics.clear();
			box.graphics.lineStyle(1, 0x000000);
			box.graphics.beginFill(0xFFFFFF);
			box.graphics.drawRect(3, 3, 10, 10);
			box.graphics.endFill();
			
			if (selected) {
				box.graphics.beginFill(0x000000);
				box.graphics.drawRect(5, 5, 6, 6);
				box.graphics.endFill();
			}
			
			if (text != null) {
				textField.text = text;
			}
		}
	}

}