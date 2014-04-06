package axel.io.base.timer {
	import asunit.framework.TestCase;
	
	import io.axel.base.timer.AxTimerSet;

	public class AxTimerSetTest extends TestCase {
		private var timerSet:AxTimerSet;
		
		public function testConstruction():void {
			timerSet = new AxTimerSet;
			assertNull(timerSet.timers);
			assertNull(timerSet.timersTemp);
		}
		
		public function testAdd():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 1, 0);
			assertNotNull(timerSet.timers);
			assertNotNull(timerSet.timersTemp);
			assertEquals(1, timerSet.size);
			assertEquals(1, timerSet.timers[0].delay);
			assertEquals(0, timerSet.timers[0].timer);
			assertEquals(1, timerSet.timers[0].repeat);
			assertNotNull(timerSet.timers[0].callback);
		}
		
		public function testAddDefaults():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {});
			assertEquals(1, timerSet.timers[0].delay);
			assertEquals(1, timerSet.timers[0].timer);
			assertEquals(1, timerSet.timers[0].repeat);
			assertNotNull(timerSet.timers[0].callback);
		}
		
		public function testUpdateTimer():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 2, 2);
			assertEquals(2, timerSet.timers[0].timer);
			timerSet.update(1);
			assertEquals(1, timerSet.timers[0].timer);
			assertEquals(2, timerSet.timers[0].repeat);
			assertTrue(timerSet.timers[0].alive);
			assertTrue(timerSet.timers[0].active);
		}
		
		public function testUpdateTimerToZero():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 2, 2);
			assertEquals(2, timerSet.timers[0].timer);
			timerSet.update(2);
			assertEquals(1, timerSet.timers[0].timer);
			assertEquals(1, timerSet.timers[0].repeat);
			assertTrue(timerSet.timers[0].alive);
			assertTrue(timerSet.timers[0].active);
		}
		
		public function testUpdateTimerPastZero():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 2, 2);
			assertEquals(2, timerSet.timers[0].timer);
			timerSet.update(2.5);
			assertEquals(0.5, timerSet.timers[0].timer);
			assertEquals(1, timerSet.timers[0].repeat);
			assertTrue(timerSet.timers[0].alive);
			assertTrue(timerSet.timers[0].active);
		}
		
		public function testUpdateTimerDoublePastZero():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 2, 2);
			assertEquals(2, timerSet.timers[0].timer);
			timerSet.update(3.5);
			assertEquals(0.5, timerSet.timers[0].timer);
			assertEquals(0, timerSet.timers[0].repeat);
			assertFalse(timerSet.timers[0].alive);
			assertFalse(timerSet.timers[0].active);
		}
		
		public function testUpdateTimerPastRepeatLimit():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 2, 2);
			assertEquals(2, timerSet.timers[0].timer);
			timerSet.update(3.5);
			assertEquals(0.5, timerSet.timers[0].timer);
			assertEquals(0, timerSet.timers[0].repeat);
			assertFalse(timerSet.timers[0].alive);
			assertFalse(timerSet.timers[0].active);
			timerSet.update(3.5);
			assertEquals(0.5, timerSet.timers[0].timer);
			assertEquals(0, timerSet.timers[0].repeat);
			assertFalse(timerSet.timers[0].alive);
			assertFalse(timerSet.timers[0].active);
		}
		
		public function testCallbackCalled():void {
			timerSet = new AxTimerSet;
			var testInt:uint = 0;
			timerSet.add(1, function():void { testInt++; }, 5);
			assertEquals(0, testInt);
			timerSet.update(0.5);
			assertEquals(0, testInt);
			timerSet.update(0.5);
			assertEquals(1, testInt);
			timerSet.update(2.5);
			assertEquals(3, testInt);
			timerSet.update(0.5);
			assertEquals(4, testInt);
			timerSet.update(5);
			assertEquals(5, testInt);
			timerSet.update(5);
			assertEquals(5, testInt);
		}
		
		public function testSize():void {
			timerSet = new AxTimerSet;
			assertNull(timerSet.timers);
			assertEquals(0, timerSet.size);
			timerSet.add(1, function():void {}, 5);
			assertNotNull(timerSet.timers);
			assertEquals(1, timerSet.size);
			timerSet.add(1, function():void {}, 5);
			assertEquals(2, timerSet.size);
		}
		
		public function testClear():void {
			timerSet = new AxTimerSet;
			timerSet.add(1, function():void {}, 5);
			timerSet.add(1, function():void {}, 5);
			assertEquals(2, timerSet.timers.length);
			assertEquals(0, timerSet.timersTemp.length);
			assertEquals(2, timerSet.size);
			timerSet.clear();
			assertEquals(0, timerSet.timers.length);
			assertEquals(0, timerSet.timersTemp.length);
			assertEquals(0, timerSet.size);
		}
		
		//todo: dead tests
	}
}
