package io.axel.camera {
	import io.axel.Ax;
	import io.axel.base.AxEntity;
	import io.axel.base.AxRect;

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
			camera.initialize();
			assertNotNull(camera.sprite);
			assertEquals(0, camera.sprite.alpha);
			assertEquals(Ax.viewWidth, camera.sprite.width);
			assertEquals(Ax.viewHeight, camera.sprite.height);
		}
		
		public function testFollowSet():void {
			camera = new AxCamera;
			camera.initialize();
			var target:AxEntity = new AxEntity;
			var padding:AxRect = new AxRect;
			camera.follow(target);
			assertEquals(target, camera.target);
			assertEquals(null, camera.padding);
			camera.follow(target, padding);
			assertEquals(target, camera.target);
			assertEquals(padding, camera.padding);
		}
		
		public function testSetBounds():void {
			camera = new AxCamera;
			camera.initialize();
			assertEquals(Number.NEGATIVE_INFINITY, camera.bounds.x);
			assertEquals(Number.NEGATIVE_INFINITY, camera.bounds.y);
			assertEquals(Number.POSITIVE_INFINITY, camera.bounds.width);
			assertEquals(Number.POSITIVE_INFINITY, camera.bounds.height);
			camera.setBounds(1, 2, 3, 4);
			assertEquals(1, camera.bounds.x);
			assertEquals(2, camera.bounds.y);
			assertEquals(3, camera.bounds.width);
			assertEquals(4, camera.bounds.height);
		}
		
		public function testDraw():void {
			camera = new AxCamera;
			camera.initialize();
			camera.position.x = 5;
			camera.position.y = 10;
			draw(camera);
			assertEquals(0, camera.sprite.x);
			assertEquals(0, camera.sprite.y);
			camera.sprite.alpha = 0.1;
			draw(camera);
			assertEquals(5, camera.sprite.x);
			assertEquals(10, camera.sprite.y);
			camera.sprite.alpha = 1;
			camera.position.x = 1;
			camera.position.y = 1;
			draw(camera);
			assertEquals(1, camera.sprite.x);
			assertEquals(1, camera.sprite.y);
		}
		
		public function testReset():void {
			camera = new AxCamera;
			camera.initialize();
			camera.follow(new AxEntity);
			camera.x = 5;
			camera.y = 5;
			camera.reset();
			assertEquals(0, camera.x);
			assertEquals(0, camera.x);
			assertNull(camera.target);
		}
		
		public function testCalculateZoomMatrix():void {
			camera = new AxCamera;
			camera.initialize();
			Ax.width = 4;
			Ax.height = 6;
			Ax.zoom = 2;
			camera.calculateZoomMatrix();
			assertEquals(2, Ax.viewWidth);
			assertEquals(3, Ax.viewHeight);
		}
	}
}
