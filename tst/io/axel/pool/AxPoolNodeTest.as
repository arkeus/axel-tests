package io.axel.pool {
	import asunit.framework.TestCase;

	public class AxPoolNodeTest extends TestCase {
		private var node:AxPoolNode;
		
		public function testInitialization():void {
			node = new AxPoolNode;
			assertNull(node.object);
			assertNull(node.next);
		}
	}
}
