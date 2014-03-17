package {
	import flash.utils.describeType;
	
	import asunit.framework.TestSuite;
	
	import axel.io.base.AxPointTest;

	public class AxelTestSuite extends TestSuite {
		public function AxelTestSuite() {
			super();
			addTest(new AxPointTest);
		}
	}
}
