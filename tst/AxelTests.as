package {
	import flash.display.Sprite;
	
	import asunit.textui.TestRunner;

	public class AxelTests extends Sprite {
		public function AxelTests() {
			var tests:TestRunner = new TestRunner();
			stage.addChild(tests);
			tests.start(AxelTestSuite, null, TestRunner.SHOW_TRACE);
		}
	}
}
