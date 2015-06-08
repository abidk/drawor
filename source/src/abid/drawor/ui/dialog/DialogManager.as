package abid.drawor.ui.dialog {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DialogManager extends Sprite {

		public static var INSTANCE:DialogManager = new DialogManager();

		private var activeDialog:Dialog = null;
		
		public function DialogManager() {
			if (INSTANCE) {
				throw new Error("Cannot create a new instance.");
			}
			visible = false;
		}
				
		public function showDialog(textprompt:String, okText:String, onOK:Function = null, cancelText:String = null, onCancel:Function = null):void {
			// disable background components
			graphics.clear();
			graphics.beginFill(0, .5);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			// set active dialog
			activeDialog = new Dialog(this, textprompt, okText, onOK, cancelText, onCancel);
			activeDialog.x = stage.stageWidth / 2 - activeDialog.width / 2;
			activeDialog.y = stage.stageHeight / 2 - activeDialog.height / 2;
			addChild(activeDialog);
			visible = true;
		}
		
		public function destroyDialog():void {
			removeChild(activeDialog);
			visible = false;
			activeDialog = null;
		}
	}
}