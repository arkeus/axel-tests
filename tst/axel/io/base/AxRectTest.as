package axel.io.base {
	import io.axel.Ax;
	import io.axel.base.AxRect;
	import io.axel.input.AxMouseButton;

	public class AxRectTest extends AxAwareTestCase {
		private var rect:AxRect;
		
		public function testInitialization():void {
			rect = new AxRect;
			assertEquals(0, rect.x);
			assertEquals(0, rect.y);
			assertEquals(0, rect.width);
			assertEquals(0, rect.height);
			
			rect = new AxRect(1, 2, 3, 4);
			assertEquals(1, rect.x);
			assertEquals(2, rect.y);
			assertEquals(3, rect.width);
			assertEquals(4, rect.height);
		}
		
		public function testContainsZeroSize():void {
			rect = new AxRect;
			assertTrue(rect.contains(0, 0));
			assertFalse(rect.contains(-1, 0));
			assertFalse(rect.contains(1, 0));
			assertFalse(rect.contains(0, -1));
			assertFalse(rect.contains(0, 1));
		}
		
		public function testContains():void {
			rect = new AxRect(-1, -1, 2, 2);
			assertTrue(rect.contains(0, 0));
			assertTrue(rect.contains(1, 0));
			assertTrue(rect.contains(-0.5, -0.2));
			assertFalse(rect.contains(-2, 0));
			assertFalse(rect.contains(2, 0));
			assertFalse(rect.contains(0, -2));
			assertFalse(rect.contains(0, 2));
		}
		
		public function testOverlaps():void {
			rect = new AxRect(-1, -1, 2, 2);
			assertTrue(rect.overlaps(new AxRect(0, 0, 1, 1)));
			assertTrue(rect.overlaps(new AxRect(0, 0, 4, 4)));
			assertFalse(rect.overlaps(new AxRect(1, 0, 1, 1)));
			assertTrue(rect.overlaps(new AxRect(-5, -5, 50, 50)));
		}
		
		public function testHover():void {
			rect = new AxRect(-1, -1, 2, 2);
			Ax.mouse.x = 0; Ax.mouse.y = 0;
			assertTrue(rect.hover());
			Ax.mouse.x = 1; Ax.mouse.y = 0;
			assertTrue(rect.hover());
			Ax.mouse.x = -0.5; Ax.mouse.y = -0.2;
			assertTrue(rect.hover());
			Ax.mouse.x = -2; Ax.mouse.y = 0;
			assertFalse(rect.hover());
			Ax.mouse.x = 2; Ax.mouse.y = 0;
			assertFalse(rect.hover());
			Ax.mouse.x = 0; Ax.mouse.y = -2;
			assertFalse(rect.hover());
			Ax.mouse.x = 0; Ax.mouse.y = 2;
			assertFalse(rect.hover());
		}
		
		public function testClicked():void {
			Ax.mouse.releaseAll();
			rect = new AxRect(-1, -1, 2, 2);
			Ax.mouse.x = 0; Ax.mouse.y = 0;
			assertFalse(rect.clicked());
			mouseDown(AxMouseButton.LEFT);
			assertTrue(rect.clicked());
			Ax.then = Ax.now + 1;
			Ax.now = Ax.then + 1;
			assertFalse(rect.clicked());
			
			Ax.mouse.x = 5; Ax.mouse.y = 5;
			assertFalse(rect.clicked());
			mouseDown(AxMouseButton.LEFT);
			assertFalse(rect.clicked());
		}
		
		public function testHeld():void {
			Ax.mouse.releaseAll();
			rect = new AxRect(-1, -1, 2, 2);
			Ax.mouse.x = 0; Ax.mouse.y = 0;
			assertFalse(rect.held());
			mouseDown(AxMouseButton.LEFT);
			assertTrue(rect.held());
			Ax.then = Ax.now + 1;
			Ax.now = Ax.then + 1;
			assertTrue(rect.held());
		}
		
		public function testReleased():void {
			Ax.mouse.releaseAll();
			rect = new AxRect(-1, -1, 2, 2);
			Ax.mouse.x = 0; Ax.mouse.y = 0;
			assertFalse(rect.released());
			mouseDown(AxMouseButton.LEFT);
			assertFalse(rect.released());
			Ax.then = Ax.now + 1;
			Ax.now = Ax.then + 1;
			assertFalse(rect.released());
			mouseUp(AxMouseButton.LEFT);
			assertTrue(rect.released());
		}
		
		public function testSides():void {
			rect = new AxRect(1, 2, 3, 4);
			assertEquals(1, rect.left);
			assertEquals(2, rect.top);
			assertEquals(4, rect.right);
			assertEquals(6, rect.bottom);
		}
		
		public function testToString():void {
			assertEquals("(1,2,3,4)", new AxRect(1, 2, 3, 4).toString());
		}
	}
}
