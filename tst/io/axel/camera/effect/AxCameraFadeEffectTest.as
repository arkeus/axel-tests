package io.axel.camera.effect {
	import asunit.framework.TestCase;

	public class AxCameraFadeEffectTest extends TestCase {
		private var effect:AxCameraFadeEffect;
		
		public function testConstruction():void {
			effect = new AxCameraFadeEffect;
			assertEquals(0, effect.redDelta);
			assertEquals(0, effect.greenDelta);
			assertEquals(0, effect.blueDelta);
			assertEquals(0, effect.alphaDelta);
			assertNull(effect.source);
			assertNull(effect.target);
			assertNull(effect.camera);
		}
	}
}
