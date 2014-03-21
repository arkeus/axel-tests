package axel.io.base {
	import io.axel.base.AxEntity;

	public class AxEntityTest extends AxAwareTestCase {
		private var entity:AxEntity;

		public function testConstruction():void {
			entity = new AxEntity(10, 20);
			assertTrue(entity.visible);
			assertTrue(entity.active);
			assertTrue(entity.solid);
			assertTrue(entity.exists);
			assertNull(entity.parent);
			assertNotNull(entity.parentOffset);
			assertEquals(0, entity.parentOffset.x);
			assertEquals(0, entity.parentOffset.y);
			assertEquals(1, entity.entityAlpha);
			assertEquals(1, entity.parentEntityAlpha);
			assertEquals(10, entity.center.x);
			assertEquals(20, entity.center.y);
			assertEquals(10, entity.previous.x);
			assertEquals(20, entity.previous.y);
			assertTrue(entity.velocity.isZero());
			assertTrue(entity.acceleration.isZero());
			assertEquals(Number.MAX_VALUE, entity.maxVelocity.x);
			assertEquals(Number.MAX_VALUE, entity.maxVelocity.y);
			assertEquals(Number.MAX_VALUE, entity.maxVelocity.a);
			assertEquals(0, entity.angle);
			assertTrue(entity.drag.isZero());
			assertEquals(0, entity.offset.x);
			assertEquals(0, entity.offset.y);
			assertFalse(entity.phased);
			assertFalse(entity.stationary);
			assertNull(entity.worldBounds);
			assertEquals(0, entity.timers.size);
		}
		
		public function testCenterOnUpdate():void {
			entity = new AxEntity(10, 20);
			// valid on create
			assertEquals(10, entity.center.x);
			assertEquals(20, entity.center.y);
			// invalid on change before update
			entity.width = 10;
			entity.height = 10;
			assertEquals(10, entity.center.x);
			assertEquals(20, entity.center.y);
			// valid after update
			entity.update();
			assertEquals(15, entity.center.x);
			assertEquals(25, entity.center.y);
		}
		
		public function testDestroy():void {
			entity = new AxEntity;
			assertTrue(entity.exists);
			assertTrue(entity.active);
			assertTrue(entity.solid);
			assertTrue(entity.visible);
			entity.destroy();
			assertFalse(entity.exists);
			assertTrue(entity.active);
			assertTrue(entity.solid);
			assertTrue(entity.visible);
		}
		
		public function testRevive():void {
			entity = new AxEntity;
			assertTrue(entity.exists);
			entity.destroy();
			assertFalse(entity.exists);
			entity.revive();
			assertTrue(entity.exists);
		}
		
		public function testSetParent():void {
			entity = new AxEntity;
			assertNull(entity.parent);
			var parent:AxEntity = new AxEntity(5, 5);
			entity.setParent(parent);
			assertEquals(parent, entity.parent);
			assertEquals(5, entity.parentOffset.x);
			assertEquals(5, entity.parentOffset.y);
		}
		
		public function testSetParentRecursive():void {
			entity = new AxEntity;
			var parent:AxEntity = new AxEntity(5, 5);
			var parent2:AxEntity = new AxEntity(5, 5);
			parent.setParent(parent2);
			entity.setParent(parent);
			assertEquals(parent, entity.parent);
			assertEquals(10, entity.parentOffset.x);
			assertEquals(10, entity.parentOffset.y);
		}
		
		public function testGlobalCoordinates():void {
			entity = new AxEntity;
			assertNull(entity.parent);
			var parent:AxEntity = new AxEntity(5, 5);
			entity.setParent(parent);
			assertEquals(5, entity.globalX);
			assertEquals(5, entity.globalY);
		}
		
		public function testAlphaGetterSetter():void {
			entity = new AxEntity;
			entity.alpha = 0.1;
			assertEquals(0.1, entity.alpha);
		}
		
		public function testStop():void {
			entity = new AxEntity;
			entity.velocity.x = 5;
			entity.velocity.y = 5;
			entity.velocity.a = 5;
			entity.stop();
			assertTrue(entity.velocity.isZero());
		}
		
		public function testGravity():void {
			entity = new AxEntity;
			entity.gravity = 200;
			assertEquals(200, entity.gravity);
			assertEquals(200, entity.acceleration.y);
		}
		
		public function testToString():void {
			entity = new AxEntity;
			assertEquals("io.axel.base::AxEntity @ (0,0,0,0)", entity.toString());
			entity.x = 1;
			entity.y = 2;
			entity.width = 3;
			entity.height = 4;
			assertEquals("io.axel.base::AxEntity @ (1,2,3,4)", entity.toString());
		}
	}
}
