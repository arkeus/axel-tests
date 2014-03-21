package io.axel.pool {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import asunit.framework.TestCase;

	public class AxPoolTest extends TestCase {
		private var pool:AxPool;
		private var point:Point;
		
		public function testInitializationFailures():void {
			assertThrows(ArgumentError, function():void {
				new AxPool(null);
			});
			
			assertThrows(ArgumentError, function():void {
				new AxPool(Point, -1);
			});
		}
		
		public function testEmptyInitialization():void {
			pool = new AxPool(Point, 0);
			assertEquals(Point, pool.objectClass);
			assertEquals(0, pool.allocated.size);
			assertEquals(0, pool.idle.size);
			assertEquals(0, pool.size);
		}
		
		public function testInitialization():void {
			pool = new AxPool(Point, 2);
			assertEquals(Point, pool.objectClass);
			assertEquals(2, pool.allocated.size);
			assertEquals(0, pool.idle.size);
			assertEquals(2, pool.size);
		}
		
		public function testAddAndRemove():void {
			pool = new AxPool(Point);
			point = pool.remove();
			assertEquals(0, pool.allocated.size);
			assertEquals(1, pool.idle.size);
			assertEquals(0, pool.size);
			
			assertNotNull(point);
			assertEquals(0, point.x);
			assertEquals(0, point.y);
			
			point.x = 1;
			point.y = 2;
			pool.add(point);
			assertEquals(1, pool.allocated.size);
			assertEquals(0, pool.idle.size);
			assertEquals(1, pool.size);
			
			point = pool.remove();
			assertEquals(0, pool.allocated.size);
			assertEquals(1, pool.idle.size);
			assertEquals(1, point.x);
			assertEquals(2, point.y);
			assertEquals(0, pool.size);
		}
		
		public function testRemoveFromPreallocation():void {
			pool = new AxPool(Point, 4);
			assertEquals(Point, pool.objectClass);
			assertEquals(4, pool.allocated.size);
			assertEquals(0, pool.idle.size);
			assertEquals(4, pool.size);
			
			pool.remove();
			pool.remove();
			assertEquals(2, pool.allocated.size);
			assertEquals(2, pool.idle.size);
			assertEquals(2, pool.size);
		}
		
		public function testInvalidCast():void {
			pool = new AxPool(Rectangle);
			assertThrows(TypeError, function():void {
				point = pool.remove();
			});
		}
	}
}
