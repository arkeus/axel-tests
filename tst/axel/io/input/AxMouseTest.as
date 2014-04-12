package axel.io.input {
	import flash.events.MouseEvent;
	
	import asunit.framework.TestCase;
	
	import io.axel.Ax;
	import io.axel.input.AxMouse;
	import io.axel.input.AxMouseButton;

	public class AxMouseTest extends AxAwareTestCase {
		private var mouse:AxMouse;

		public function testConstructor():void {
			mouse = new AxMouse;
			assertEquals(1, mouse.size());
			assertEquals(0, mouse.x);
			assertEquals(0, mouse.y);
			assertEquals(0, mouse.screen.x);
			assertEquals(0, mouse.screen.y);
		}
		
		public function testMouseState():void {
			mouse = new AxMouse;
			assertFalse(mouse.down(AxMouseButton.LEFT));
			assertFalse(mouse.pressed(AxMouseButton.LEFT));
			assertFalse(mouse.released(AxMouseButton.LEFT));
			
			advance(100);
			mouse.onMouseDown(new MouseEvent("test"));
			
			assertTrue(mouse.down(AxMouseButton.LEFT));
			assertTrue(mouse.pressed(AxMouseButton.LEFT));
			assertFalse(mouse.released(AxMouseButton.LEFT));
			
			advance(100);
			mouse.onMouseDown(new MouseEvent("test"));
			
			assertTrue(mouse.down(AxMouseButton.LEFT));
			assertTrue(mouse.pressed(AxMouseButton.LEFT));
			assertFalse(mouse.released(AxMouseButton.LEFT));
			
			advance(100);
			
			assertTrue(mouse.down(AxMouseButton.LEFT));
			assertFalse(mouse.pressed(AxMouseButton.LEFT));
			assertFalse(mouse.released(AxMouseButton.LEFT));
			
			advance(100);
			mouse.onMouseUp(new MouseEvent("test"));
			
			assertFalse(mouse.down(AxMouseButton.LEFT));
			assertFalse(mouse.pressed(AxMouseButton.LEFT));
			assertTrue(mouse.released(AxMouseButton.LEFT));
			
			advance(100);
			
			assertFalse(mouse.down(AxMouseButton.LEFT));
			assertFalse(mouse.pressed(AxMouseButton.LEFT));
			assertFalse(mouse.released(AxMouseButton.LEFT));
		}
	}
}
