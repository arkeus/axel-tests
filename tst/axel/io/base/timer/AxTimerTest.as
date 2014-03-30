package axel.io.base.timer {
	import asunit.framework.TestCase;
	
	import io.axel.base.timer.AxTimer;

	public class AxTimerTest extends TestCase {
		private var timer:AxTimer;
		
		public function testConstruction():void {
			timer = new AxTimer(1.2, null, 2, 0.9);
			assertEquals(1.2, timer.delay);
			assertNull(timer.callback);
			assertEquals(2, timer.repeat);
			assertEquals(0.9, timer.timer);
			assertTrue(timer.active);
			assertTrue(timer.alive);
		}
		
		public function testConstructionDefaults():void {
			timer = new AxTimer(1.2, null);
			assertEquals(1.2, timer.delay);
			assertNull(timer.callback);
			assertEquals(1, timer.repeat);
			assertEquals(1.2, timer.timer);
		}
		
		public function testConstructionStartDelay():void {
			timer = new AxTimer(1.2, null, 2, -1);
			assertEquals(1.2, timer.timer);
		}
		
		public function testPause():void {
			timer = new AxTimer(1.2, null);
			timer.pause();
			assertFalse(timer.active);
		}
		
		public function testPauseDead():void {
			timer = new AxTimer(1.2, null);
			timer.alive = false;
			timer.pause();
			assertTrue(timer.active);
		}
		
		public function testStart():void {
			timer = new AxTimer(1.2, null);
			timer.pause();
			assertFalse(timer.active);
			timer.start();
			assertTrue(timer.active);
		}
	}
}
