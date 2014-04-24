package io.axel.camera {
	import io.axel.Ax;

	public class AxCameraTest extends AxAwareTestCase {
		private var camera:AxCamera;
		
		public function testConstruction():void {
			camera = new AxCamera;
			assertEquals(Number.NEGATIVE_INFINITY, camera.bounds.x);
			assertEquals(Number.NEGATIVE_INFINITY, camera.bounds.y);
			assertEquals(Number.POSITIVE_INFINITY, camera.bounds.width);
			assertEquals(Number.POSITIVE_INFINITY, camera.bounds.height);
			assertNotNull(camera.position);
			assertNotNull(camera.projection);
			assertNotNull(camera.view);
			assertNotNull(camera.baseProjection);
			assertNotNull(camera.effectOffset);
		}
		
		public function testInitialize():void {
			camera = new AxCamera;
			assertNotNull(camera.sprite);
			assertEquals(0, camera.sprite.alpha);
			assertEquals(Ax.viewWidth, camera.sprite.width);
			assertEquals(Ax.viewHeight, camera.sprite.height);
		}
	}
}
