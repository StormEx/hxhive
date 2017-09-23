package hxhive.controllers;

import hxhive.view.HiveParticleView;
import hxfireflies.particle.IParticleView;
import hxhive.particles.HiveEmitter;
import hxfireflies.emitter.IEmitter;
import hxfireflies.emitter.IEmitterData;
import hxfireflies.pool.IPool;
import hxfireflies.particle.Particle;
import hxfireflies.animators.AnimatorOut;
import hxfireflies.animators.AnimatorIn;
import hxfireflies.animators.AnimatorLinear;
import hxfireflies.area.RingArea;
import hxfireflies.emitter.EmitterData;
import hxfireflies.area.ArcArea;
import hxfireflies.area.CircleArea;
import hxfireflies.pool.Pool;
import hxfireflies.forces.ForceGravity;
import hxfireflies.forces.ForceCollection;
import hxhive.view.HiveMainView;
import js.Browser;
import hxhive.data.HiveEditorData;
import angular.service.Scope;

class HiveEditorController {
    var _scope:Scope;
    var _data:HiveEditorData = null;
    var _fileName:String = "";
    var _psView:HiveMainView = null;

    var _emitter:IEmitter;
    var _rEmitter:IEmitter;
    var _eEmitter:IEmitter;
    var _force:ForceCollection;

    public function new(scope:Scope) {
        _data = new HiveEditorData(onDataChanged);

        _scope = scope;

        _scope.set("psData", _data);
        _scope.set("treeOptions", {
            nodeChildren: "children"
        });
        _scope.set("newPsSystem", newPsSystem);
        _scope.set("loadPsSystem", loadPsSystem);
        _scope.set("savePsSystem", savePsSystem);

        newPsSystem();

        Browser.window.requestAnimationFrame(onFrame);

        Browser.window.addEventListener("load", onWindowLoaded);
    }

    function prepare() {
        _force = new ForceCollection();
        _force.add(new ForceGravity(2));
        _force.enabled = true;

        var p:Pool;
        _emitter = new HiveEmitter(createParticleView());
        _emitter.pool = createPool(true);
        _emitter.data = createEmitterData();
        _emitter.data.area = new CircleArea(14);
        _emitter.spawnInterval = 200;
        _eEmitter = new HiveEmitter(createParticleView());
        _eEmitter.pool = createPool();
        _eEmitter.data = createEmitterData();
//		_eEmitter.data.area = new CircleArea(14);
        _eEmitter.data.area = new ArcArea(14, 180, 360);
        var d:EmitterData = cast _eEmitter.data;
        d.velocityFrom = 70;
        d.velocityTo = 140;
        var p:Pool = cast _eEmitter.pool;
//        p.prototype = _emitter.clone();
        _eEmitter.spawnInterval = 15;
        _eEmitter.spawnCount = 10;
        _eEmitter.enable = true;
        _eEmitter.force = _force;
        _rEmitter = new HiveEmitter(createParticleView());
        _rEmitter.pool = createPool();
        _rEmitter.data = createEmitterData();
        _rEmitter.data.area = new RingArea(50, 50);
        _rEmitter.data.area = new ArcArea(150, 0, 0);
    }

    function createEmitterData():IEmitterData {
        var data:EmitterData = new EmitterData();
        data.lifetime = 500;
        data.lifetimeDelta = 1500;
        data.scaleSimple = false;
        data.scaleFrom = 0.5;
        data.scaleFromDelta = 1;
        data.scaleYFrom = 0.5;
        data.scaleYFromDelta = 1;
        data.scaleYTo = 0;
        data.scaleTo = 0;
        data.scaleAnimator = new AnimatorIn();
        data.scaleAnimator = new AnimatorOut();
        data.scaleAnimator = new AnimatorLinear();
        data.scaleYAnimator = new AnimatorLinear();
//		data.scaleAnimator = null;

//		data.spinFrom = -180;
//		data.spinFromDelta = -30;
//		data.spinTo = -1600;
//		data.spinToDelta = -60;
//		data.spinAnimator = new AnimatorLinear();

        data.angleFrom = 0;
        data.angleFromDelta = 0;
        data.angleTo = 1600;
        data.angleToDelta = 600;
        data.angleAnimator = new AnimatorLinear();

        data.alphaFrom = 1;
        data.alphaFromDelta = 0;
        data.alphaTo = 0;
        data.alphaToDelta = 0;
        data.alphaAnimator = new AnimatorLinear();

        data.velocityFrom = 30;
        data.velocityFromDelta = 20;
        data.velocityTo = 70;
        data.velocityToDelta = 40;
        data.velocityAnimator = new AnimatorOut();

        return data;
    }

    function createPool(alt:Bool = false):IPool {
        var p:Pool = new Pool();
        p.prototype = new Particle(alt ? createAltParticleView(12) : createParticleView(12));
        p.maxLength = 5000;

        return p;
    }

    function createParticleView(size:Float = 20):IParticleView {
        return new HiveParticleView(size);
    }

    function createAltParticleView(size:Float = 20):IParticleView {
        return new HiveParticleView(size, true);
    }

    function newPsSystem() {
        trace("new system");
        _data.reset();
    }

    function loadPsSystem() {
        trace("load system");
//        var dialog:InputElement = Browser.document.createInputElement();
//        dialog.type = 'file';
//        dialog.multiple = false;
//        dialog.accept = ".tson";
//
//        var q = new JQuery(dialog);
//        q.change(function(event:JqEvent) {
//            var sjl:JsFileLoader = new JsFileLoader(dialog.files[0]);
//            sjl.finished.addOnce(onTsonLoaded);
//            sjl.load();
//
//            _data.loading = true;
//            _scope.safeApply(function() {
//                _scope.set("managerData", _data);
//            });
//        });
//        q.click();
    }

    function savePsSystem() {
        trace("save system");
//#if nodejs
//		var dialog:InputElement = Browser.document.createInputElement();
//		dialog.type = 'file';
//		dialog.multiple = false;
//		dialog.accept = ".tson";
//		untyped __js__('dialog.nwsaveas = "filename.tson"');
//
//		var q = new JQuery(dialog);
//		q.change(function(event:JqEvent) {
//			_fileName = dialog.value;
//			try {
//				var d:TsonData = _data.getChanges();
//				var b:Bytes = Tson.convertData(d);
//				var bbb:js.node.Buffer = new js.node.Buffer(b.length);
//				var arr:Uint8Array = new Uint8Array(b.getData());
//				for(i in 0...arr.length) {
//					bbb[i] = arr[i];
//				}
//				js.node.Fs.writeFile(_fileName, bbb, "binary", onFileWriteFinished);
//			}
//			catch(e:Dynamic) {
//				Debug.trace("save error: " + Std.string(e));
//				return;
//			}
//		});
//		q.click();
//#else
//        var elem:AnchorElement = Browser.document.createAnchorElement();
//        elem.href = js.html.URL.createObjectURL(new Blob([Tson.convertData(_data.getChanges()).getData()]));
//        elem.download = "temp.tson";
//        elem.click();
//#end
    }

    function applyTreeData() {
            _scope.safeApply(function() {
                _scope.set("psData", _data);
            });
    }

    function onFileWriteFinished(e:Dynamic) {
//        Debug.trace("file saved successfully...");
    }

    function onTsonLoaded(/*loader:ILoader*/) {
//        if(loader.isSuccess()) {
//            _tson = loader.content;
//            _data.tson = TsonDataReader.read(new BytesInput(_tson));
//            Debug.trace("tson file loaded successfully");
//        }
//        else {
//            newPsSystem();
//            Debug.trace("tson file loading failed");
//        }
//
//        _data.loading = false;
//        _scope.safeApply(function() {
//            _scope.set("managerData", _data);
//        });
    }

    function onDataChanged() {
        _scope.safeApply(function() {
            _scope.set("psData", _data);
        });
    }

    function onFrame(e:Float) {
        if(_psView != null) {
//            var val:Float = Math.sin(((2 * Math.PI) / 5000) * dt);
////            var v:Float = (cur % 5000) / 5000;
//            val = Math.sin(v * 2 * Math.PI);
//            _emitter.y = 240 + val * 200;
//            val = Math.cos(v * 2 * Math.PI);
//            _emitter.x = 400 + val * 200;
//		heart(v, _emitter);

//            v = (cur % 3000) / 3000;
            _rEmitter.y = 300;
            _rEmitter.x = 300;
//            var r:RingArea = Std.instance(_rEmitter.data.area, RingArea);
//            if(r != null) {
//                r.minRadius = r.maxRadius = 50 + v * 80;
//            }
//            var a:ArcArea = Std.instance(_rEmitter.data.area, ArcArea);
//            if(a != null) {
//                a.angleFrom = a.angleTo = v * 360;
//            }
//		_rEmitter.update(dt, _force);
//		_force.enable = a.angleFrom >= 0 && a.angleFrom <= 180;

            _eEmitter.y = 300;
            _eEmitter.x = 300;
            _psView.render();
        }
        Browser.window.requestAnimationFrame(onFrame);
    }

    function onWindowLoaded() {
        _psView = new HiveMainView();
        prepare();
        _psView.emitter = _eEmitter;

        Browser.window.removeEventListener("load", onWindowLoaded);
    }
}
