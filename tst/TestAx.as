package {
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import io.axel.Ax;

	public class TestAx extends Ax {
		public function TestAx(initialState:Class = null, width:uint = 0, height:uint = 0, zoom:uint = 1, framerate:uint = 60, fixedTimestep:Boolean = false) {
			super(initialState, width, height, zoom, framerate, fixedTimestep);
		}
		
		override public function create():void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			Ax.now = getTimer() + 1;
			Ax.then = Ax.now - 1;
		}
	}
}
