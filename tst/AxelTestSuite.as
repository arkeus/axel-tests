package {
	import asunit.framework.TestSuite;
	
	import axel.io.base.AxPointTest;
	
	import io.axel.pool.AxPoolListTest;
	import io.axel.pool.AxPoolNodeTest;
	import io.axel.pool.AxPoolTest;

	public class AxelTestSuite extends TestSuite {
		public function AxelTestSuite() {
			super();
			
			// io.axel.base
			addTest(new AxPointTest);
			
			// io.axel.pool
			addTest(new AxPoolNodeTest);
			addTest(new AxPoolListTest);
			addTest(new AxPoolTest);
		}
	}
}
