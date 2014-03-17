package {
	import asunit.framework.TestSuite;
	
	import axel.io.base.AxPointTest;
	import axel.io.base.AxRectTest;
	import axel.io.base.AxVectorTest;
	
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
//			addTest(new AxEntityTest);
//			addTest(new AxGroupTest);
			
			// io.axel.pool
			addTest(new AxPoolNodeTest);
			addTest(new AxPoolListTest);
			addTest(new AxPoolTest);
		}
	}
}
