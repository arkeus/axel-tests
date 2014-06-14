package {
	import asunit.framework.TestSuite;
	
	import io.axel.base.AxEntityTest;
	import io.axel.base.AxGroupTest;
	import io.axel.base.AxPointTest;
	import io.axel.base.AxRectTest;
	import io.axel.base.AxVectorTest;
	import io.axel.camera.AxCameraTest;
	import io.axel.camera.effect.AxCameraEffectTest;
	import io.axel.camera.effect.AxCameraFadeEffectTest;
	import io.axel.camera.effect.AxCameraShakeEffectTest;
	import io.axel.input.AxInputDeviceTest;
	import io.axel.input.AxKeyboardTest;
	import io.axel.input.AxMouseTest;
	import io.axel.pool.AxPoolListTest;
	import io.axel.pool.AxPoolNodeTest;
	import io.axel.pool.AxPoolTest;
	import io.axel.sound.AxSoundTest;
	import io.axel.timer.AxTimerSetTest;
	import io.axel.timer.AxTimerTest;

	public class AxelTestSuite extends TestSuite {
		public function AxelTestSuite() {
			super();
			
			// io.axel.base
			addTest(new AxPointTest);
			addTest(new AxRectTest);
			addTest(new AxVectorTest);
			addTest(new AxEntityTest);
			addTest(new AxGroupTest);
			// io.axel.camera
			addTest(new AxCameraTest);
			// io.axel.camera.effect
			addTest(new AxCameraEffectTest);
			addTest(new AxCameraFadeEffectTest);
			addTest(new AxCameraShakeEffectTest);
			// io.axel.base.timer
			addTest(new AxTimerTest);
			addTest(new AxTimerSetTest);
			// io.axel.input
			addTest(new AxInputDeviceTest);
			addTest(new AxMouseTest);
			addTest(new AxKeyboardTest);
			// io.axel.pool
			addTest(new AxPoolNodeTest);
			addTest(new AxPoolListTest);
			addTest(new AxPoolTest);
			// io.axel.sound
			addTest(new AxSoundTest);
		}
	}
}
