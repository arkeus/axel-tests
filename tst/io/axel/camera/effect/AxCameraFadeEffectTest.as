package io.axel.camera.effect {
	import asunit.framework.TestCase;
	
	import io.axel.camera.AxCamera;
	import io.axel.render.AxColor;

	public class AxCameraFadeEffectTest extends TestCase {
		private var effect:AxCameraFadeEffect;
		private var camera:AxCamera;
		private var callback:Function;
		
		override protected function setUp():void {
			effect = new AxCameraFadeEffect;
			camera = new AxCamera;
			camera.initialize();
			callback = function():void {};
		}
		
		public function testConstruction():void {
			assertEquals(0, effect.redDelta);
			assertEquals(0, effect.greenDelta);
			assertEquals(0, effect.blueDelta);
			assertEquals(0, effect.alphaDelta);
			assertNull(effect.source);
			assertNull(effect.target);
			assertNull(effect.camera);
		}
		
		public function testFadeSetup():void {
			effect.fade(1, 0xffffffff, camera, callback);
			assertEquals(1, effect.duration);
			assertEquals(1, effect.remaining);
			assertEquals(callback, effect.callback);
			assertTrue(effect.active);
			assertEquals(0x00ffffff, effect.source.hex);
			assertEquals(0xffffffff, effect.target.hex);
			assertEquals(camera, effect.camera);
		}
		
		public function testFadeToZeroAlpha():void {
			camera.sprite.color = AxColor.fromHex(0xffffffff);
			effect.fade(1, 0x00ffffff, camera, callback);
			assertEquals(0, effect.redDelta);
			assertEquals(0, effect.greenDelta);
			assertEquals(0, effect.blueDelta);
			assertEquals(-1, effect.alphaDelta);
		}
	}
}
