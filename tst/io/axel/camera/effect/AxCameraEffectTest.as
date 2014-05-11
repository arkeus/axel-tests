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
	}
}
