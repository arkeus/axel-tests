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
	}
}
