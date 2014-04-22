package io.axel.base {
	import asunit.framework.TestCase;
	

	public class AxVectorTest extends TestCase {
		private var vector:AxVector;
		
		public function testInitialization():void {
			vector = new AxVector;
			assertEquals(0, vector.x);
			assertEquals(0, vector.y);
			assertEquals(0, vector.a);
			
			vector = new AxVector(1, 2, 3);
			assertEquals(1, vector.x);
			assertEquals(2, vector.y);
			assertEquals(3, vector.a);
		}
		
		public function testZero():void {
			vector = new AxVector(1, 2, 3);
			vector.zero();
			assertEquals(0, vector.x);
			assertEquals(0, vector.y);
			assertEquals(0, vector.a);
		}
		
		public function testIsZero():void {
			assertFalse(new AxVector(1, 2, 3).isZero());
			assertFalse(new AxVector(0, 2, 3).isZero());
			assertFalse(new AxVector(1, 0, 3).isZero());
			assertFalse(new AxVector(1, 2, 0).isZero());
			assertTrue(new AxVector(0, 0, 0).isZero());
		}
		
		public function testToString():void {
			assertEquals("(1,2,3)", new AxVector(1, 2, 3).toString());
		}
	}
}
