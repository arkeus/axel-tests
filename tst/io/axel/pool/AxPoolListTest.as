package io.axel.pool {
	import asunit.framework.TestCase;

	public class AxPoolListTest extends TestCase {
		private var list:AxPoolList;
		private var node:AxPoolNode;
		
		public function testBasicInitialization():void {
			list = new AxPoolList;
			assertNull(list.head);
			assertEquals(0, list.size);
		}
		
		public function testSingleInitialization():void {			
			list = new AxPoolList(1);
			assertNotNull(list.head);
			assertNull(list.head.next);
			assertNull(list.head.object);
			assertEquals(1, list.size);
		}
		
		public function testMultipleInitialization():void {
			list = new AxPoolList(2);
			assertNotNull(list.head);
			assertNotNull(list.head.next);
			assertNull(list.head.object);
			assertEquals(2, list.size);
		}
		
		public function testNegativeCapacityInitialization():void {
			assertThrows(ArgumentError, function():void {
				list = new AxPoolList(-1);
			});
		}
		
		public function testDynamicCreation():void {
			list = new AxPoolList;
			assertEquals(0, list.size);
			node = list.remove();
			assertEquals(0, list.size);
			assertNotNull(node);
			assertNull(node.object);
			node.object = 5;
			list.add(node);
			assertEquals(1, list.size);
			assertNotNull(list.head);
			node = list.remove();
			assertNull(list.head);
			assertEquals(5, node.object);
		}
		
		public function testNullAddThrows():void {
			list = new AxPoolList;
			assertThrows(ArgumentError, function():void {
				list.add(null);
			});
		}
	}
}
