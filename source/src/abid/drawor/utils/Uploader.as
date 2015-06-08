package abid.drawor.utils {
	import flash.events.*;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	public class Uploader {
			
		public function Uploader() {

		}
		
		public function doPost(url:String, canvasData:ByteArray):void {
			//canvasData.position = 0;
			//var encoder:Base64Encoder = new Base64Encoder();
			//encoder.encodeBytes(canvasData);
			
			//var variables:URLVariables = new URLVariables();
			//variables.filename = "abid.png";
			//variables.data = ;
			
			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			request.data = canvasData;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.addEventListener(Event.COMPLETE, loaderComplete);
			loader.load(request);
		
			//var file:FileReference = new FileReference();
			//file.save(canvasData, "123.png");
		}
		
		private function loaderComplete(event:Event):void {
			trace("Upload complete!" + event);
			DialogManager.INSTANCE.showDialog("Upload was successful!", "OK");
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			DialogManager.INSTANCE.showDialog("Upload failed!", "OK");
		}
	
	}
}