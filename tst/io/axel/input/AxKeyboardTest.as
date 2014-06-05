package io.axel.input {
	public class AxKeyboardTest extends AxAwareTestCase {
		private var keyboard:AxKeyboard;
		
		override protected function setUp():void {
			keyboard = new AxKeyboard;
		}

		public function testConstructor():void {
			assertEquals(223, keyboard.size());
		}
	}
}
 