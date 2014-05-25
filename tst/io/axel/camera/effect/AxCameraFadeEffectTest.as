package io.axel.camera.effect {
	import io.axel.camera.AxCamera;
	import io.axel.render.AxColor;

	public class AxCameraFadeEffectTest extends AxAwareTestCase {
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
		
		public function testFadeFromZeroAlpha():void {
			camera.sprite.color = AxColor.fromHex(0x00ff00ff);
			effect.fade(1, 0xffffff00, camera, callback);
			assertEquals(0, effect.redDelta);
			assertEquals(0, effect.greenDelta);
			assertEquals(0, effect.blueDelta);
			assertEquals(1, effect.alphaDelta);
			assertEquals(1, camera.sprite.color.red);
			assertEquals(1, camera.sprite.color.green);
			assertEquals(0, camera.sprite.color.blue);
		}
		
		public function testFadeNonZeroDeltas():void {
			camera.sprite.color = AxColor.fromHex(0x77777777);
			effect.fade(1, 0xffffffff, camera, callback);
			assertEquals((0xff - 0x77) / 0xff, effect.redDelta);
			assertEquals((0xff - 0x77) / 0xff, effect.greenDelta);
			assertEquals((0xff - 0x77) / 0xff, effect.blueDelta);
			assertEquals((0xff - 0x77) / 0xff, effect.alphaDelta);
			assertEquals(0x77 / 0xff, camera.sprite.color.red);
			assertEquals(0x77 / 0xff, camera.sprite.color.green);
			assertEquals(0x77 / 0xff, camera.sprite.color.blue);
		}
		
		public function testFadeUpdate():void {
			camera.sprite.color = new AxColor(0.5, 0.5, 0.5, 0.5);
			var complete:Boolean = false;
			callback = function():void { complete = true; };
			effect.fade(1, 0xffffffff, camera, callback);
			advance(0.5);
			effect.update(camera);
			assertEquals(0.75, camera.sprite.color.red);
			assertEquals(0.75, camera.sprite.color.green);
			assertEquals(0.75, camera.sprite.color.blue);
			assertEquals(0.75, camera.sprite.color.alpha);
			assertFalse(complete);
			effect.update(camera);
			assertEquals(1, camera.sprite.color.red);
			assertEquals(1, camera.sprite.color.green);
			assertEquals(1, camera.sprite.color.blue);
			assertEquals(1, camera.sprite.color.alpha);
			assertTrue(complete);
		}
		
		public function testDeactivate():void {
			camera.sprite.color = new AxColor(0.5, 0.5, 0.5, 0.5);
			var complete:Boolean = false;
			callback = function():void { complete = true; };
			effect.fade(1, 0xffffffff, camera, callback);
			effect.deactivate();
			assertEquals(1, camera.sprite.color.red);
			assertEquals(1, camera.sprite.color.green);
			assertEquals(1, camera.sprite.color.blue);
			assertEquals(1, camera.sprite.color.alpha);
			assertTrue(complete);
		}
	}
}
