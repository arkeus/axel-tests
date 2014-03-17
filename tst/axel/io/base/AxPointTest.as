package axel.io.base {
	import flash.geom.Point;
	
	import asunit.framework.TestCase;
	
	import io.axel.base.AxPoint;

	public class AxPointTest extends TestCase {
		private var point:AxPoint;

		public function testInitialization():void {
			point = new AxPoint;
			assertEquals(0, point.x);
			assertEquals(0, point.y);

			point = new AxPoint(-3, 5);
			assertEquals(-3, point.x);
			assertEquals(5, point.y);
		}

		public function testFloats():void {
			point = new AxPoint(1.40, 2.5);
			assertEquals(1.4, point.x);
			assertEquals(2.5, point.y);
		}

		public function testToPoint():void {
			point = new AxPoint(1, 2);
			var flashPoint:Point = point.toPoint();
			assertEquals(1, flashPoint.x);
			assertEquals(2, flashPoint.y);

			var premadePoint:Point = new Point(4, 5);
			point.toPoint(premadePoint);
			assertEquals(1, premadePoint.x);
			assertEquals(2, premadePoint.y);
		}
		
		public function testFromPoint():void {
			point = new AxPoint(4, 5);
			var flashPoint:Point = new Point(1, 2);
			point.fromPoint(flashPoint);
			assertEquals(1, point.x);
			assertEquals(2, point.y);
		}
	}
}
