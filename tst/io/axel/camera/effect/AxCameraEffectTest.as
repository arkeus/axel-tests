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
	}
}
