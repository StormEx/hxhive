package hxhive.view;

import hxfireflies.emitter.IEmitter;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;

class HiveMainView {
	static public var ctx:CanvasRenderingContext2D = null;

	public var emitter(default, set):IEmitter = null;

	var _canvas:CanvasElement = null;
	var _time:Float = 0;

	public function new() {
		Browser.window.addEventListener("load", onWindowLoaded);
	}

	public function init() {
		if(ctx == null) {
			_canvas = cast Browser.document.getElementById("pscanvas");
			if(_canvas != null) {
				trace("canvas for particles created");
				ctx = _canvas.getContext2d();
			}
			else {
				trace("canvas for particles not found");
			}
		}
		_time = Date.now().getTime();
	}

	public function dispose() {
	}

	function loop(dt) {
		if(emitter != null) {
			emitter.update(dt);
		}
	}

	public function render() {
		if(_canvas == null) {
			return;
		}

		var cur:Float = Date.now().getTime();
		var dt:Int = Std.int(cur - _time);

		if(ctx != null) {
			ctx.clearRect(0, 0, _canvas.width, _canvas.height);
			loop(dt);
		}

		_time = cur;
	}

	function onWindowLoaded() {
//		_psView.emitter = _eEmitter;
		init();

		Browser.window.removeEventListener("load", onWindowLoaded);
	}

	function set_emitter(value:IEmitter):IEmitter {
		if(emitter != value) {
			emitter = value;
		}

		return emitter;
	}
}
