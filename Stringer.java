package test;



public class Stringer {

	private static String strDef = "Here is the default";

	public static void main(String[] args) {
		Stringer guy = new Stringer();
		System.out.println(guy.stringerCheck());
		System.out.println(stringerCheck("This is what I want from it"));
	}

	/*
	 * Takes in a string and returns every character which does not have a
	 * duplicate. Ignores case.
	 */
	public static String stringerCheck(String str) {
		char[] strChar = str.toLowerCase().toCharArray();
		String result = "";
		for (int i = 0; i < strChar.length; i++) {
			boolean check = true;
			for (int j = 0; j < strChar.length; j++) {
				if (strChar[i] == strChar[j] && i != j) {
					check = false;
				}
			}
			if (check == true) {
				result += String.valueOf(strChar[i]);
			}
		}
		return result;
	}

	/*
	 * Default Test
	 */
	public String stringerCheck() {
		char[] strChar = strDef.toLowerCase().toCharArray();
		String result = "";
		for (int i = 0; i < strChar.length; i++) {
			boolean check = true;
			for (int j = 0; j < strChar.length; j++) {
				if (strChar[i] == strChar[j] && i != j) {
					check = false;
				}
			}
			if (check == true) {
				result += String.valueOf(strChar[i]);
			}
		}
		return result;
	}
}
