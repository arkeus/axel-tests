package io.axel.sound {
	import asunit.framework.TestCase;

	public class AxSoundTest extends TestCase {
		private var sound:AxSound;
		private var manager:AxAudioManager;
		
		override protected function setUp():void {
			sound = new AxSound;
			manager = new AxAudioManager;
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
			sound.create(AxTestSound);
			assertEquals(AxTestSound, sound.soundClass);
			assertNotNull(sound.soundTransform);
			assertNotNull(sound.sound);
			assertTrue(sound.sound is Object);
		}
		
		public function testInitialize():void {
			sound.create(AxTestSound);
			sound.initialize(manager, 0.5, 2, 2, 1);
			assertEquals(manager, sound.manager);
			assertEquals(0.5, sound.requestedVolume);
			assertEquals(2, sound.loops);
			assertEquals(2, sound.start);
			assertEquals(1, sound.requestedPanning);
			assertNotNull(sound.soundTransform);
			assertEquals(0.5, sound.targetVolume);
			assertEquals(1, sound.targetPan);
			assertEquals(0, sound.deltaPan);
			assertEquals(0, sound.deltaVolume);
		}
		
		public function testSetVolumeTooLow():void {
			sound.create(AxTestSound);
			sound.initialize(manager, 0.5, 2, 2, 1);
			assertThrows(ArgumentError, function():void {
				sound.volume = -1;
			});
		}
		
		public function testSetVolumeTooHigh():void {
			sound.create(AxTestSound);
			sound.initialize(manager, 0.5, 2, 2, 1);
			assertThrows(ArgumentError, function():void {
				sound.volume = 2;
			});
		}
	}
}
