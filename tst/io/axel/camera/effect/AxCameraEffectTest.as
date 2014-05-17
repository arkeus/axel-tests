package io.axel.camera.effect {
	public class AxCameraEffectTest extends AxAwareTestCase {
		private var effect:AxCameraEffect;
		
		public function testConstruction():void {
			effect = new AxCameraEffect;
			assertEquals(false, effect.active);
			assertEquals(0, effect.duration);
			assertEquals(0, effect.remaining);
			assertEquals(null, effect.callback);
		}
		
		public function testInitialize():void {
			effect = new AxCameraEffect;
			var callback:Function = function():void {};
			effect.initialize(5, callback);
			assertEquals(5, effect.duration);
			assertEquals(5, effect.remaining);
			assertEquals(callback, effect.callback);
			assertTrue(effect.active);
		}
		
		public function testUpdate():void {
			effect = new AxCameraEffect;
			var callback:Function = function():void {};
			effect.initialize(5, callback);
			advance(3);
			effect.update(null);
			assertEquals(5, effect.duration);
			assertEquals(2, effect.remaining);
			assertTrue(effect.active);
			advance(3);
			effect.update(null);
			assertEquals(5, effect.duration);
			assertEquals(-1, effect.remaining);
			assertFalse(effect.active);
		}
		
		public function testDeactivate():void {
			effect = new AxCameraEffect;
			var completed:Boolean = false;
			var callback:Function = function():void { completed = true; };
			effect.initialize(5, callback);
			effect.deactivate();
			assertEquals(false, effect.active);
			assertTrue(completed);
		}
	}
}
