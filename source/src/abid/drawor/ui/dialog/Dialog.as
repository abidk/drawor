package abid.drawor.ui.dialog {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Dialog extends Sprite {
		
		public static const DIALOG_WIDTH:int = 320;
		public static const DIALOG_HEIGHT:int = 100;
		public static const MARGIN:int = 10;
		
		protected var manager:DialogManager;
		protected var dialogText:String;
		protected var okText:String;
		protected var onOK:Function;
		protected var onCancel:Function;
		protected var cancelText:String;
		
		public function Dialog(manager:DialogManager, dialogText:String, okText:String, onOK:Function = null, cancelText:String = null, onCancel:Function = null) {
			this.manager = manager;
			this.dialogText = dialogText;
			this.onCancel = onCancel;
			this.onOK = onOK;
			this.okText = okText;
			this.cancelText = cancelText;
			draw();
		}
		
		private function draw():void {
			graphics.beginFill(0xFFFFFF);
			graphics.lineStyle(2, 0);
			graphics.drawRect(0, 0, DIALOG_WIDTH, DIALOG_HEIGHT);
			
			var textField:TextField = new TextField();
			textField.defaultTextFormat = new TextFormat("_sans", 15);
			textField.mouseEnabled = false;
			textField.text = dialogText;
			textField.x = MARGIN;
			textField.y = MARGIN;
			textField.width = DIALOG_WIDTH - MARGIN;
			textField.height = DIALOG_HEIGHT - MARGIN - 40;
			addChild(textField);
			
			var okButton:DialogButton = new DialogButton();
			okButton.setText(okText);
			okButton.addEventListener(MouseEvent.CLICK, onOkClick, false, 0, true);
			okButton.y = DIALOG_HEIGHT - okButton.height - MARGIN;
			// center the button if there is no cancel
			if (cancelText == null) {
				okButton.x = (DIALOG_WIDTH - okButton.width) / 2;
			} else {
				okButton.x = MARGIN;
			}
			addChild(okButton);
			
			if (cancelText != null) {
				var cancelButton:DialogButton = new DialogButton();
				cancelButton.setText(cancelText);
				cancelButton.addEventListener(MouseEvent.CLICK, onCancelClick, false, 0, true);
				cancelButton.x = DIALOG_WIDTH - cancelButton.width - MARGIN;
				cancelButton.y = DIALOG_HEIGHT - okButton.height - MARGIN;
				addChild(cancelButton);
			}
		}
		
		private function onOkClick(e:Event):void {
			if (onOK != null) {
				onOK();
			}
			manager.destroyDialog();
		}
		
		private function onCancelClick(e:Event):void {
			if (onCancel != null) {
				onCancel();
			}
			manager.destroyDialog();
		}
	}

}
