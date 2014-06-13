package io.axel.sound {
	import asunit.framework.TestCase;

	public class AxSoundTest extends TestCase {
		private var sound:AxSound;
		
		override protected function setUp():void {
			sound = new AxSound;
		}
		
		public function testConstructor():void {
			assertNull(sound.soundClass);
			assertNull(sound.sound);
			assertNull(sound.soundChannel);
			assertNull(sound.soundTransform);
			assertNull(sound.manager);
			assertTrue(isNaN(sound.requestedVolume));
			assertEquals(0, sound.loops);
			assertTrue(isNaN(sound.start));
			assertTrue(isNaN(sound.deltaVolume));
			assertTrue(isNaN(sound.targetVolume));
			assertTrue(isNaN(sound.requestedPanning));
			assertTrue(isNaN(sound.deltaPan));
			assertTrue(isNaN(sound.targetPan));
			assertFalse(sound.destroyOnComplete);
		}
		
		public function testCreate():void {
			sound.create(Object);
			assertEquals(Object, sound.soundClass);
			assertNotNull(sound.soundTransform);
			assertNotNull(sound.sound);
			assertTrue(sound.sound is Object);
		}
	}
}
