package abid.drawor.ui.dialog {
	
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	
	public class DialogButton extends Sprite {
		
		public static const DEFAULT_BACKGROUND_COLOUR:uint = 0xFFFFFF;
		public static const DEFAULT_ROLLOVER_COLOUR:uint = 0x999999;
		
		private var btnWidth:Number;
		private var btnHeight:Number;
		
		
		public function DialogButton() {
			buttonMode = true;
			
			addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, buttonRollOutHandler);
		}
		
		public function setText(text:String):void {
			var textLabel:TextField = new TextField();
			textLabel.defaultTextFormat = new TextFormat("_sans", 15);
			textLabel.mouseEnabled = false;
			textLabel.text = text;
			textLabel.autoSize = TextFieldAutoSize.CENTER;
			textLabel.y = 2.5;
			textLabel.x = 2.5;
			
			btnWidth = textLabel.width + 5;
			btnHeight = textLabel.height + 5;
			
			graphics.beginFill(DEFAULT_BACKGROUND_COLOUR);
			graphics.lineStyle(0, 0);
			graphics.drawRect(0, 0, btnWidth, btnHeight);
			addChild(textLabel);
		}
		
		private function buttonRollOverHandler(event:MouseEvent):void {
			graphics.beginFill(DEFAULT_ROLLOVER_COLOUR);
			graphics.lineStyle(0, 0);
			graphics.drawRect(0, 0, btnWidth, btnHeight);
			graphics.endFill();
		}
		
		private function buttonRollOutHandler(event:MouseEvent):void {
			graphics.beginFill(DEFAULT_BACKGROUND_COLOUR);
			graphics.lineStyle(0, 0);
			graphics.drawRect(0, 0, btnWidth, btnHeight);
			graphics.endFill();
		}
	}
}