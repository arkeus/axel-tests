package axel.io.base {
	import io.axel.base.AxEntity;
	import io.axel.base.AxGroup;
	import io.axel.base.AxModel;
	import io.axel.base.AxPoint;
	import io.axel.base.AxRect;
	import io.axel.sprite.AxSprite;

	public class AxGroupTest extends AxAwareTestCase {
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

		public function testAdd():void {
			group = new AxGroup;
			var entity:AxEntity = new AxEntity;
			assertEquals(group, group.add(entity));
			assertEquals(1, group.members.length);
			assertEquals(entity, group.members[0]);
			assertEquals(group, entity.parent);
		}

		public function testAddNoLink():void {
			group = new AxGroup;
			var entity:AxEntity = new AxEntity;
			assertEquals(group, group.add(entity, false));
			assertEquals(null, entity.parent);
		}

		public function testAddNull():void {
			assertThrows(ArgumentError, function():void {
				new AxGroup().add(null);
			});
		}

		public function testInheritScrollGroup():void {
			group = new AxGroup;
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			var group2:AxGroup = new AxGroup;
			group2.scroll.x = 0.3;
			group2.scroll.y = 0.4;
			group.add(group2);
			assertEquals(0.1, group2.scroll.x);
			assertEquals(0.2, group2.scroll.y);
		}

		public function testNoInheritScrollGroup():void {
			group = new AxGroup;
			var group2:AxGroup = new AxGroup;
			group2.scroll.x = 0.1;
			group2.scroll.y = 0.2;
			group.add(group2);
			assertEquals(0.1, group2.scroll.x);
			assertEquals(0.2, group2.scroll.y);
		}

		public function testNoInheritParamScrollGroup():void {
			group = new AxGroup;
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			var group2:AxGroup = new AxGroup;
			group.add(group2, true, false);
			assertEquals(-1, group2.scroll.x);
			assertEquals(-1, group2.scroll.y);
		}

		public function testInheritScrollModel():void {
			group = new AxGroup;
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			var model:AxModel = new AxSprite;
			group.add(model);
			assertEquals(0.1, model.scroll.x);
			assertEquals(0.2, model.scroll.y);
		}

		public function testNoInheritScrollModel():void {
			group = new AxGroup;
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			var model:AxModel = new AxSprite;
			model.scroll.x = 0.3;
			group.add(model);
			assertEquals(0.3, model.scroll.x);
			assertEquals(0.2, model.scroll.y);
		}

		public function testNoInheritParamScrollModel():void {
			group = new AxGroup;
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			var model:AxModel = new AxSprite;
			model.scroll.x = 0.3;
			group.add(model, true, false);
			assertEquals(0.3, model.scroll.x);
			assertEquals(1, model.scroll.y);
		}

		public function testRemove():void {
			group = new AxGroup;
			var entity:AxEntity = new AxEntity;
			assertEquals(group, group.add(entity));
			group.remove(entity);
			assertEquals(0, group.members.length);
			assertEquals(null, entity.parent);
		}

		public function testRemoveNoUnlink():void {
			group = new AxGroup;
			var entity:AxEntity = new AxEntity;
			assertEquals(group, group.add(entity));
			group.remove(entity, false);
			assertEquals(0, group.members.length);
			assertEquals(group, entity.parent);
		}

		public function testUpdateChildren():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			e1.velocity.x = 1;
			e2.velocity.y = 2;
			group.add(e1);
			group.add(e2);
			advance(1, group);
			assertEquals(1, e1.x);
			assertEquals(0, e1.y);
			assertEquals(0, e2.x);
			assertEquals(2, e2.y);
		}

		public function testUpdateChildrenRecursive():void {
			group = new AxGroup;
			var g1:AxGroup = new AxGroup;
			var g2:AxGroup = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			g1.velocity.x = -1;
			g2.velocity.y = -2;
			e1.velocity.x = 1;
			e2.velocity.y = 2;
			g1.add(e1);
			g2.add(e2);
			group.add(g1);
			group.add(g2);
			advance(1, group);
			assertEquals(-1, g1.x);
			assertEquals(0, g1.y);
			assertEquals(0, g2.x);
			assertEquals(-2, g2.y);
			assertEquals(1, e1.x);
			assertEquals(0, e1.y);
			assertEquals(0, e2.x);
			assertEquals(2, e2.y);
			assertEquals(0, e1.globalX);
			assertEquals(0, e1.globalY);
			assertEquals(0, e2.globalX);
			assertEquals(0, e2.globalY);
		}

		public function testNoUpdateOnInactive():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			e1.velocity.x = 1;
			e1.active = false;
			group.add(e1);
			advance(1, group);
			assertEquals(0, e1.x);
			assertEquals(0, e1.y);
		}

		public function testNoUpdateOnNonexistent():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			e1.velocity.x = 1;
			e1.exists = false;
			group.add(e1);
			advance(1, group);
			assertEquals(0, e1.x);
			assertEquals(0, e1.y);
		}

		public function testCannotOverlapRect():void {
			group = new AxGroup;
			assertThrows(ArgumentError, function():void {
				group.overlaps(new AxRect);
			});
		}

		public function testOverlaps():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			e1.x = e1.y = 10;
			e1.width = e1.height = 10;
			e2.x = e2.y = -10;
			e2.width = e2.height = 10;
			group.add(e1);
			group.add(e2);

			var r1:AxRect = new AxEntity(5, 5);
			var r2:AxRect = new AxEntity(25, 25);
			r1.width = r2.width = r1.height = r2.height = 10;

			assertTrue(group.overlaps(r1))
			assertFalse(group.overlaps(r2))
		}

		public function testNoOverlapsOnNonexistent():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			e1.x = e1.y = 10;
			e1.width = e1.height = 10;
			e2.x = e2.y = -10;
			e2.width = e2.height = 10;
			group.add(e1);
			group.add(e2);

			var r1:AxRect = new AxEntity(5, 5);
			var r2:AxRect = new AxEntity(25, 25);
			r1.width = r2.width = r1.height = r2.height = 10;

			group.exists = false;
			assertFalse(group.overlaps(r1))
			assertFalse(group.overlaps(r2))
		}

		public function testScrollGetterSetter():void {
			group = new AxGroup;
			assertEquals(-1, group.scroll.x);
			assertEquals(-1, group.scroll.y);
			assertEquals(-1, group.scrollFactor.x);
			assertEquals(-1, group.scrollFactor.y);
			group.scroll.x = 0.1;
			group.scroll.y = 0.2;
			assertEquals(0.1, group.scroll.x);
			assertEquals(0.2, group.scroll.y);
			assertEquals(0.1, group.scrollFactor.x);
			assertEquals(0.2, group.scrollFactor.y);
		}

		public function testNoScroll():void {
			group = new AxGroup;
			group.noScroll();
			assertEquals(0, group.scroll.x);
			assertEquals(0, group.scroll.y);
		}

		public function testRecursiveScrollSet():void {
			group = new AxGroup;
			var g1:AxGroup = new AxGroup;
			var e1:AxSprite = new AxSprite;
			group.add(g1);
			g1.add(e1);

			group.scroll = new AxPoint(0.1, 0.2);

			assertEquals(0.1, group.scroll.x);
			assertEquals(0.2, group.scroll.y);
			assertEquals(0.1, g1.scroll.x);
			assertEquals(0.2, g1.scroll.y);
			assertEquals(0.1, e1.scroll.x);
			assertEquals(0.2, e1.scroll.y);
		}
		
		public function testRecycle():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			group.add(e1);
			group.add(e2);
			
			assertNull(group.recycle());
			e1.destroy();
			e1.active = false;
			e1.visible = false;
			e2.destroy();
			e2.active = false;
			e2.visible = false;
			
			assertEquals(e1, group.recycle());
			assertEquals(true, e1.exists);
			assertEquals(true, e1.active);
			assertEquals(true, e1.visible);
			
			assertEquals(e2, group.recycle());
			assertEquals(true, e2.exists);
			assertEquals(true, e2.active);
			assertEquals(true, e2.visible);
			
			assertNull(group.recycle());
		}
		
		public function testCleanup():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			group.add(e1);
			group.add(e2);
			
			assertEquals(2, group.members.length);
			assertEquals(0, group.tempMembers.length);
			assertEquals(2, group.members.length);
			assertEquals(0, group.tempMembers.length);
			
			group.cleanup();
			
			e1.destroy();
			e2.destroy();
			group.cleanup();
			
			assertEquals(0, group.members.length);
			assertEquals(2, group.tempMembers.length);
			assertNull(group.recycle());
		}
		
		public function testClear():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			group.add(e1);
			group.add(e2);
			
			assertEquals(2, group.members.length);
			assertEquals(0, group.tempMembers.length);
			
			group.clear();
			
			assertEquals(0, group.members.length);
			assertEquals(0, group.tempMembers.length);
			assertNull(group.recycle());
		}
		
		public function testDispose():void {
			group = new AxGroup;
			var e1:AxEntity = new AxEntity;
			var e2:AxEntity = new AxEntity;
			group.add(e1);
			group.add(e2);
			
			assertEquals(2, group.members.length);
			assertEquals(0, group.tempMembers.length);
			
			group.dispose();
			
			assertNull(group.members);
			assertNull(group.tempMembers);
		}
	}
}
