package abid.drawor {
	
	import flash.text.Font;
	
	public class ApplicationFonts {
		
		/**
		 * If you wanted to embed fonts into the application then add an instance field to initialise the embeded fonts
		 * i.e. private var fonts:ApplicationFonts = new ApplicationFonts();
		 */
		
		[Embed(systemFont="Arial",fontName="arial",mimeType="application/x-font",fontWeight="bold",fontStyle="bold",advancedAntiAliasing="true",embedAsCFF="false")]
		public static const fontClass:Class;
		
		public function ApplicationFonts() {
			Font.registerFont(fontClass);
		}
		
		public function listFonts():void {
			var fonts:Array = Font.enumerateFonts(false);
			var font:Font;
			for (var f:int = fonts.length; --f >= 0; ) {
				font = fonts[f];
				trace(font.fontName + " " + font.fontStyle + " " + font.fontType);
			}
		}
	}

}