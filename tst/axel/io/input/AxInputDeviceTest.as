package axel.io.input {
	import asunit.framework.TestCase;
	
	import io.axel.input.AxInputDevice;

	public class AxInputDeviceTest extends TestCase {
		private var input:AxInputDevice;
		
		public function testConstruction():void {
			input = new AxInputDevice(5);
		}
		
		public function testInitialState():void {
			input = new AxInputDevice(2);
			assertFalse(input.down(0));
			assertFalse(input.down(1));
			assertThrows(RangeError, function():void {
				input.down(2);
			});
			assertFalse(input.held(0));
			assertFalse(input.held(1));
			assertThrows(RangeError, function():void {
				input.held(2);
			});
			assertFalse(input.pressed(0));
			assertFalse(input.pressed(1));
			assertThrows(RangeError, function():void {
				input.pressed(2);
			});
			assertFalse(input.released(0));
			assertFalse(input.released(1));
			assertThrows(RangeError, function():void {
				input.released(2);
			});
		}
	}
}
