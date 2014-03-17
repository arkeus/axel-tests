package {
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import asunit.framework.TestCase;
	
	import io.axel.Ax;

	public class AxAwareTestCase extends TestCase {
		override protected function setUp():void {
			Ax.then = 100;
			Ax.now = 200;
		}
		
		protected function mouseDown(key:uint):void {
			Ax.mouse.onMouseDown(new MouseEvent("test"));
		}
		
		protected function mouseUp(key:uint):void {
			Ax.mouse.onMouseUp(new MouseEvent("test"));
		}
		
		protected function keyDown(key:uint):void {
			Ax.keys.onKeyDown(new KeyboardEvent("test", true, false, key, key));
		}
		
		protected function keyUp(key:uint):void {
			Ax.keys.onKeyUp(new KeyboardEvent("test", true, false, key, key));
		}
	}
}
