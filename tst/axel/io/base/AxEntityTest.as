package axel.io.base {
	import io.axel.base.AxEntity;
	import io.axel.base.AxRect;

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
		
		public function testAdvanceZeroVelocity():void {
			entity = new AxEntity;
			advance(1, entity);
			assertTrue(entity.velocity.isZero());
			assertEquals(0, entity.x);
			assertEquals(0, entity.y);
		}
		
		public function testAdvanceNonZeroVelocity():void {
			entity = new AxEntity;
			entity.velocity.x = 5;
			entity.velocity.y = 10;
			entity.velocity.a = 15;
			advance(1, entity);
			assertFalse(entity.velocity.isZero());
			assertEquals(5, entity.x);
			assertEquals(10, entity.y);
			assertEquals(15, entity.angle);
		}
		
		public function testAdvanceFloatNonZeroVelocity():void {
			entity = new AxEntity;
			entity.velocity.x = 5;
			entity.velocity.y = 10;
			entity.velocity.a = 15;
			advance(0.1, entity);
			assertFalse(entity.velocity.isZero());
			assertEquals(0.5, entity.x);
			assertEquals(1, entity.y);
			assertEquals(1.5, entity.angle);
		}
		
		public function testPvelocity():void {
			entity = new AxEntity;
			entity.velocity.x = 1;
			entity.velocity.y = 2;
			entity.velocity.a = 3;
			assertEquals(0, entity.pvelocity.x);
			assertEquals(0, entity.pvelocity.y);
			assertEquals(0, entity.pvelocity.a);
			advance(1, entity);
			assertEquals(1, entity.pvelocity.x);
			assertEquals(2, entity.pvelocity.y);
			assertEquals(3, entity.pvelocity.a);
		}
		
		public function testTouchingOnAdvance():void {
			entity = new AxEntity;
			assertEquals(AxEntity.NONE, entity.touching);
			entity.touching = AxEntity.LEFT | AxEntity.RIGHT;
			assertFalse(AxEntity.NONE == entity.touching);
			advance(1, entity);
			assertEquals(AxEntity.NONE, entity.touching);
		}
		
		public function testTouchedOnAdvance():void {
			entity = new AxEntity;
			assertEquals(AxEntity.NONE, entity.touched);
			entity.touching = AxEntity.LEFT | AxEntity.RIGHT;
			assertEquals(AxEntity.NONE, entity.touched);
			advance(1, entity);
			assertEquals(AxEntity.LEFT | AxEntity.RIGHT, entity.touched);
		}
		
		public function testParentMoveOnAdvance():void {
			entity = new AxEntity;
			var parent:AxEntity = new AxEntity(5, 5);
			entity.setParent(parent);
			parent.x = 10;
			parent.y = 10;
			assertEquals(5, entity.parentOffset.x);
			assertEquals(5, entity.parentOffset.y);
			advance(1, entity);
			assertEquals(10, entity.parentOffset.x);
			assertEquals(10, entity.parentOffset.y);
		}
		
		public function testStationary():void {
			entity = new AxEntity;
			entity.velocity.x = 5;
			entity.velocity.y = 10;
			entity.stationary = true;
			advance(1, entity);
			assertFalse(entity.velocity.isZero());
			assertEquals(0, entity.x);
			assertEquals(0, entity.y);
		}
		
		public function testAcceleration():void {
			entity = new AxEntity;
			entity.acceleration.x = 1;
			entity.acceleration.y = 2;
			entity.acceleration.a = 3;
			advance(1, entity);
			assertEquals(1, entity.velocity.x);
			assertEquals(2, entity.velocity.y);
			assertEquals(3, entity.velocity.a);
		}
		
		public function testIntegralBasedPosition():void {
			entity = new AxEntity;
			entity.acceleration.x = 2;
			entity.acceleration.y = 4;
			assertEquals(0, entity.x);
			assertEquals(0, entity.y);
			assertEquals(0, entity.velocity.x);
			assertEquals(0, entity.velocity.y);
			advance(1, entity);
			assertEquals(1, entity.x);
			assertEquals(2, entity.y);
			assertEquals(2, entity.velocity.x);
			assertEquals(4, entity.velocity.y);
			advance(1, entity);
			assertEquals(4, entity.x);
			assertEquals(8, entity.y);
			assertEquals(4, entity.velocity.x);
			assertEquals(8, entity.velocity.y);
		}
		
		public function testWorldBounds():void {
			entity = new AxEntity;
			entity.width = 2;
			entity.height = 2;
			entity.worldBounds = new AxRect(0, 0, 10, 10);
			entity.x = -5;
			entity.y = -5;
			assertEquals(-5, entity.x);
			assertEquals(-5, entity.y);
			advance(1, entity);
			assertEquals(0, entity.x);
			assertEquals(0, entity.y);
			entity.x = 20;
			entity.y = 20;
			assertEquals(20, entity.x);
			assertEquals(20, entity.y);
			advance(1, entity);
			assertEquals(8, entity.x);
			assertEquals(8, entity.y);
		}
	}
}
