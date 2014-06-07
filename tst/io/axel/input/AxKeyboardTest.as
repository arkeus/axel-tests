package io.axel.input {
	import flash.events.KeyboardEvent;

	public class AxKeyboardTest extends AxAwareTestCase {
		private var keyboard:AxKeyboard;
		
		override protected function setUp():void {
			keyboard = new AxKeyboard;
		}

		public function testConstructor():void {
			assertEquals(223, keyboard.size());
		}
		
		public function testKeyboardState():void {
			assertFalse(keyboard.down(AxKey.A));
			assertFalse(keyboard.down(AxKey.SPACE));
			
			advance(100);
			keyboard.onKeyDown(new KeyboardEvent("test", true, false, 65, 65));
			
			assertTrue(keyboard.pressed(AxKey.A));
			assertTrue(keyboard.down(AxKey.A));
			assertFalse(keyboard.released(AxKey.A));
			assertFalse(keyboard.pressed(AxKey.SPACE));
			assertFalse(keyboard.down(AxKey.SPACE));
			
			advance(100);
			keyboard.onKeyDown(new KeyboardEvent("test", true, false, 32, 32));
			
			assertFalse(keyboard.pressed(AxKey.A));
			assertTrue(keyboard.down(AxKey.A));
			assertFalse(keyboard.released(AxKey.A));
			assertTrue(keyboard.pressed(AxKey.SPACE));
			assertTrue(keyboard.down(AxKey.SPACE));
			
			advance(100);
			keyboard.onKeyUp(new KeyboardEvent("test", true, false, 65, 65));
			
			assertFalse(keyboard.pressed(AxKey.A));
			assertFalse(keyboard.down(AxKey.A));
			assertTrue(keyboard.released(AxKey.A));
			assertFalse(keyboard.pressed(AxKey.SPACE));
			assertTrue(keyboard.down(AxKey.SPACE));
		}
	}
}
 