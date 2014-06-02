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
		
		public function testUpdateHorizontal():void {
			effect.shake(1, 5, callback, true, AxCamera.HORIZONTAL);
			advance(0.5);
			effect.update(camera);
			assertEquals(0, effect.y);
			assertTrue(effect.x >= -5 && effect.x <= 5);
			assertEquals(1, effect.duration);
			assertEquals(0.5, effect.remaining);
		}
		
		public function testUpdateVertical():void {
			effect.shake(1, 5, callback, true, AxCamera.VERTICAL);
			advance(0.5);
			effect.update(camera);
			assertEquals(0, effect.x);
			assertTrue(effect.y >= -5 && effect.y <= 5);
			assertEquals(1, effect.duration);
			assertEquals(0.5, effect.remaining);
		}
		
		public function testUpdateBoth():void {
			effect.shake(1, 5, callback, true, AxCamera.BOTH_AXES);
			advance(0.5);
			effect.update(camera);
			assertTrue(effect.x >= -5 && effect.x <= 5);
			assertTrue(effect.y >= -5 && effect.y <= 5);
			assertEquals(1, effect.duration);
			assertEquals(0.5, effect.remaining);
		}
		
		public function testDeactivate():void {
			var complete:Boolean = false;
			var callback:Function = function():void { complete = true; }
			effect.shake(1, 5, callback, true, AxCamera.BOTH_AXES);
			advance(0.5);
			effect.update(camera);
			assertTrue(effect.x >= -5 && effect.x <= 5);
			assertTrue(effect.y >= -5 && effect.y <= 5);
			assertTrue(effect.active);
			effect.deactivate();
			assertEquals(0, effect.x);
			assertEquals(0, effect.y);
			assertFalse(effect.active);
			assertTrue(complete);
		}
	}
}
