package {
	import asunit.framework.TestSuite;
	
	import io.axel.base.AxEntityTest;
	import io.axel.base.AxGroupTest;
	import io.axel.base.AxPointTest;
	import io.axel.base.AxRectTest;
	import io.axel.base.AxVectorTest;
	import io.axel.timer.AxTimerSetTest;
	import io.axel.timer.AxTimerTest;
	import io.axel.input.AxInputDeviceTest;
	import io.axel.input.AxMouseTest;
	
	import io.axel.pool.AxPoolListTest;
	import io.axel.pool.AxPoolNodeTest;
	import io.axel.pool.AxPoolTest;

	public class AxelTestSuite extends TestSuite {
		public function AxelTestSuite() {
			super();
			
			// io.axel.base
			addTest(new AxPointTest);
			addTest(new AxRectTest);
			addTest(new AxVectorTest);
			addTest(new AxEntityTest);
			addTest(new AxGroupTest);
			// io.axel.base.timer
			addTest(new AxTimerTest);
			addTest(new AxTimerSetTest);
			// io.axel.input
			addTest(new AxInputDeviceTest);
			addTest(new AxMouseTest);
			// io.axel.pool
			addTest(new AxPoolNodeTest);
			addTest(new AxPoolListTest);
			addTest(new AxPoolTest);
		}
	}
}
