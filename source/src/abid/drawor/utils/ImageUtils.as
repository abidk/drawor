package abid.drawor.utils {
	
	import com.adobe.images.*;
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class ImageUtils {
		
		public function ImageUtils() {
		}
		
		public function spriteToPngStream(image:Sprite, width:Number = -1, height:Number = -1):ByteArray {
			if (width == -1) {
				width = image.width;
			}
			
			if (height == -1) {
				height = image.height;
			}
			var source:BitmapData = new BitmapData(width, height);
			source.draw(image, new Matrix(), null, null, null, false);
			
			//for(var i:Number = 0; i < image.numChildren - 1; i++) {     
			//	var childImage = image.getChildAt(i);     
			//	source.draw(childImage, new Matrix(), null, null, null, false);
			//}
			
			var imgStream:ByteArray = PNGEncoder.encode(source);
			return imgStream;
		}
		
		public function spriteToJpgStream(image:Sprite):ByteArray {
			var source:BitmapData = new BitmapData(image.width, image.height);
			source.draw(image);
			
			var encoder:JPGEncoder = new JPGEncoder();
			var imgStream:ByteArray = encoder.encode(source);
			return imgStream;
		}
		
		public function saveImageStream(imgStream:ByteArray, imageName:String):void {
			try {
				var file:FileReference = new FileReference();
				file.save(imgStream, imageName);
			} catch (error:Error) {
				trace("Error trying to save image : " + imageName + " . Error : " + error);
			}
		}
		
		public function bitmapToSprite(bitmap:Bitmap, smoothing:Boolean = false):Sprite {
			var sprite:Sprite = new Sprite();
			sprite.addChild(new Bitmap(bitmap.bitmapData.clone(), "auto", smoothing));
			return sprite;
		}
		
		public function spriteToBitmap(sprite:Sprite, smoothing:Boolean = false):Bitmap {
			var bitmapData:BitmapData = new BitmapData(sprite.width, sprite.height, true, 0x00FFFFFF);
			bitmapData.draw(sprite);
			return new Bitmap(bitmapData, "auto", smoothing);
		}
		
		public function distanceBetweenTwoPoints(x1:Number, y1:Number, x2:Number, y2:Number):Number {
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
	}
}