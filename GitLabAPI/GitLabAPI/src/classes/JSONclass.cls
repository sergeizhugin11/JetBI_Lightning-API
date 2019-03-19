public class JSONclass {

	public String xc {get;set;} 
	public String yc {get;set;} 
	public String zc {get;set;} 

	public JSONclass(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'x__c') {
						xc = parser.getText();
					} else if (text == 'y__c') {
						yc = parser.getText();
					} else if (text == 'z__c') {
						zc = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'JSONclass consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static List<JSONclass> parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return arrayOfJSONclass(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	
    private static List<JSONclass> arrayOfJSONclass(System.JSONParser p) {
        List<JSONclass> res = new List<JSONclass>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new JSONclass(p));
        }
        return res;
    }

}