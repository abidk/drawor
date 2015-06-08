package abid.drawor.utils {
	import flash.external.*;
	import flash.utils.Dictionary;
	
	public class QueryParser {
		private var url:String;
		private var queryString:String;
		private var parameters:Dictionary = new Dictionary();
		
		public function QueryParser(url:String) {
			this.url = url;
			parseUrl(url);
		}
		
		public function getUrl():String {
			return url;
		}
		
		public function getQueryString():String {
			return queryString;
		}
		
		public function getParameters():Dictionary {
			return parameters;
		}
		
		private function parseUrl(url:String):void {
			queryString = url.split("?")[1];
			if (queryString) {
				var params:Array = queryString.split('&');
				for (var i:int = 0; i < params.length; i++) {
					var keyValuePair:String = params[i];
					var index:int = -1;
					if ((index = keyValuePair.indexOf("=")) > 0) {
						var paramKey:String = keyValuePair.substring(0, index);
						var paramValue:String = keyValuePair.substring(index + 1);
						parameters[paramKey] = paramValue;
					}
				}
			}
		}
	}
}