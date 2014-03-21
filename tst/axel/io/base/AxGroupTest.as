package axel.io.base {
	import asunit.framework.TestCase;
	
	import io.axel.base.AxGroup;

	public class AxGroupTest extends TestCase {
		private var group:AxGroup;
		
		public function testConstruction():void {
			group = new AxGroup;
			assertEquals(0, group.members.length);
			assertEquals(0, group.tempMembers.length);
			assertEquals(-1, group.scrollFactor.x);
			assertEquals(-1, group.scrollFactor.y);
			assertEquals(0, group.x);
			assertEquals(0, group.y);
		}
		
		public function testPositionConstruction():void {
			group = new AxGroup(1, 2);
			assertEquals(1, group.x);
			assertEquals(2, group.y);
		}
	}
}
