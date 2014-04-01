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
	}
}
