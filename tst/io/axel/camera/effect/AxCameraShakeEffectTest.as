package io.axel.camera.effect {
	import io.axel.camera.AxCamera;
	

	public class AxCameraShakeEffectTest extends AxAwareTestCase {
		private var effect:AxCameraFadeEffect;
		private var camera:AxCamera;
		private var callback:Function;
		
		override protected function setUp():void {
			effect = new AxCameraFadeEffect;
			camera = new AxCamera;
			camera.initialize();
			callback = function():void {};
		}
	}
}
