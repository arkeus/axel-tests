package io.axel.camera.effect {
	import io.axel.camera.AxCamera;

	public class AxCameraShakeEffectTest extends AxAwareTestCase {
		private var effect:AxCameraShakeEffect;
		private var camera:AxCamera;
		private var callback:Function;
		
		override protected function setUp():void {
			effect = new AxCameraShakeEffect;
			camera = new AxCamera;
			camera.initialize();
			callback = function():void {};
		}
		
		public function testConstruction():void {
			assertEquals(0, effect.x);
			assertEquals(0, effect.y);
			assertEquals(0, effect.axes);
			assertFalse(effect.ease);
			assertTrue(isNaN(effect.intensity));
		}
		
		public function testShake():void {
			effect.shake(1, 2, callback, true, AxCamera.HORIZONTAL);
			assertEquals(1, effect.duration);
			assertEquals(1, effect.remaining);
			assertEquals(callback, effect.callback);
			assertEquals(2, effect.intensity);
			assertTrue(effect.ease);
			assertEquals(AxCamera.HORIZONTAL, effect.axes);
		}
	}
}
