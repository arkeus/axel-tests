package axel.io.input {
	import asunit.framework.TestCase;
	
	import io.axel.input.AxInput;

	public class AxInputTest extends TestCase {
		private var input:AxInput;
		
		public function testConstruction():void {
			input = new AxInput(5);
		}
	}
}
