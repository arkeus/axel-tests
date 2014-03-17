package {
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import asunit.textui.TestRunner;

	public class AxelTests extends Sprite {
		public static var stage:Stage;
		
		public function AxelTests() {
			stage.addChild(new TestAx(TestState));
			
			var tests:TestRunner = new TestRunner();
			stage.addChild(tests);
			tests.start(AxelTestSuite, null, TestRunner.SHOW_TRACE);
		}
	}
}
