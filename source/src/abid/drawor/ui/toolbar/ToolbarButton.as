package abid.drawor.ui.toolbar {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class ToolbarButton extends Sprite {
		
		public static const DEFAULT_BUTTON_WIDTH:Number = 100;
		public static const DEFAULT_BUTTON_HEIGHT:Number = 50;
		public static const DEFAULT_BACKGROUND_COLOUR:uint = 0x10507D;
		public static const DEFAULT_ROLLOVER_COLOUR:uint = 0x999999;
		
		private var btnColour:uint = DEFAULT_BACKGROUND_COLOUR;
		private var btnWidth:Number;
		private var btnHeight:Number;
		private var bitmap:Bitmap;
		private var btnText:String = "";
		private var btnRolloverEnabled:Boolean = true;
		private var rolloverColour:uint = DEFAULT_ROLLOVER_COLOUR;
		private var backgroundColour:uint = DEFAULT_BACKGROUND_COLOUR;
		private var textFormat:TextFormat;
		private var selected:Boolean;
		
		public function ToolbarButton(btnWidth:Number = DEFAULT_BUTTON_WIDTH, btnHeight:Number = DEFAULT_BUTTON_HEIGHT) {
			this.btnWidth = btnWidth;
			this.btnHeight = btnHeight;
			
			this.useHandCursor = true;
			this.buttonMode = true;
			this.mouseChildren = false;
			
			this.textFormat = new TextFormat();
			this.textFormat.color = 0xFFFFFF;
			this.textFormat.bold = true;
			this.textFormat.size = 14;
			this.textFormat.font = "_sans";
			
			this.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			function buttonRollOverHandler(event:MouseEvent):void {
				if (!btnRolloverEnabled) {
					return;
				}
				btnColour = rolloverColour;
				refreshButton();
			}
			
			this.addEventListener(MouseEvent.ROLL_OUT, buttonRollOutHandler);
			function buttonRollOutHandler(event:MouseEvent):void {
				if (!btnRolloverEnabled) {
					return;
				}
				btnColour = backgroundColour;
				refreshButton();
			}
		}
		
		public function setRolloverColour(colour:uint):void {
			this.rolloverColour = colour;
			refreshButton();
		}
		
		public function setBackgroundColour(colour:uint):void {
			this.backgroundColour = colour;
			this.btnColour = colour;
			refreshButton();
		}
		
		public function setTextFormat(textFormat:TextFormat):void {
			this.textFormat = textFormat;
			refreshButton();
		}
		
		public function setSelected(selected:Boolean):void {
			this.selected = selected;
			refreshButton();
		}
		
		public function setBitmap(bitmapClass:Class):void {
			this.bitmap = new bitmapClass();
		}
		
		public function setText(text:String):void {
			btnText = text;
			refreshButton();
		}
		
		public function setRolloverEnabled(enabled:Boolean):void {
			btnRolloverEnabled = enabled;
		}
		
		public function reset():void {
			setSelected(false);
		}
		
		private function refreshButton():void {
			this.graphics.clear();
			
			var startX:int = 0;
			var startY:int = 0;
			var buttonWidth:int = btnWidth;
			var buttonHeight:int = btnHeight;
			
			if (selected) {
				this.graphics.lineStyle(2, 0x000000);
				startX = 1;
				startY = 1;
				buttonWidth = btnWidth - 2;
				buttonHeight = btnHeight - 2;
			}
			this.graphics.beginFill(btnColour);
			this.graphics.drawRect(startX, startY, buttonWidth, buttonHeight);
			this.graphics.endFill();
			
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			
			if (bitmap != null) {
				addChild(bitmap);
			} else {
				var textField:TextField = new TextField();
				textField.defaultTextFormat = textFormat;
				textField.text = btnText;
				textField.width = buttonWidth;
				textField.height = buttonHeight;
				textField.x = startX;
				if (textField.textHeight > 0) {
					textField.y = (buttonHeight / 2) - (textField.textHeight / 1.5);
				}
				
				textField.multiline = false;
				textField.wordWrap = false;
				textField.autoSize = TextFieldAutoSize.CENTER;
				textField.selectable = false;
				addChild(textField);
			}
		}
	}
}