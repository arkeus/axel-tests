package io.axel.input {
	public class AxKeyboardTest extends AxAwareTestCase {
		private var keyboard:AxKeyboard;

		public function testConstructor():void {
			keyboard = new AxKeyboard;
			assertEquals(223, keyboard.size());
		}
	}
}
