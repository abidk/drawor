package abid.drawor.ui.components {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class InputText extends DragableSprite {
		
		private var initialText:String = "Click here to write!";
		private var textInput:TextField = new TextField();
		
		public function InputText() {
			var fmt:TextFormat = new TextFormat();
			fmt.color = 0x000000;
			fmt.font = "Arial";
			fmt.size = 24;
			
			textInput.type = TextFieldType.INPUT;
			textInput.defaultTextFormat = fmt;
			textInput.text = initialText;
			textInput.multiline = true;
			textInput.wordWrap = true;
			textInput.border = true;
			textInput.mouseEnabled = true;
			textInput.addEventListener(FocusEvent.FOCUS_IN, focusInput);
			textInput.addEventListener(FocusEvent.FOCUS_OUT, unfocusInput);
			addChild(textInput);
		}
		
		public function setTextColor(colour:uint):void {
			textInput.textColor = colour;
		}
		
		public function setReadOnly(readOnly:Boolean):void {
			if (readOnly) {
				textInput.border = false;
				textInput.mouseEnabled = false;
				textInput.type = TextFieldType.DYNAMIC;
			} else {
				textInput.border = true;
				textInput.mouseEnabled = true;
				textInput.type = TextFieldType.INPUT;
			}
		}
				
		public function focusInput(event:Event):void {
			if (textInput.text == initialText) {
				textInput.text = "";
			}
		}
		
		public function unfocusInput(event:Event):void {
			setReadOnly(true);
		}
	}

}