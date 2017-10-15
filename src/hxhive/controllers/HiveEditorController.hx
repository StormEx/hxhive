package hxhive.controllers;

import hxhive.data.HiveModel;
import hxfireflies.emitter.IEmitter;
import hxfireflies.forces.ForceCollection;
import hxhive.view.HiveMainView;
import js.Browser;
import hxhive.data.HiveEditorData;
import angular.service.Scope;

class HiveEditorController {
	var _scope:Scope;
	var _data:HiveEditorData = null;
	var _model:HiveModel = null;
	var _fileName:String = "";
	var _psView:HiveMainView = null;

	var _emitter:IEmitter;
	var _rEmitter:IEmitter;
	var _eEmitter:IEmitter;
	var _force:ForceCollection;

	public function new(scope:Scope, view:HiveMainView, model:HiveModel) {
		_psView = view;
		_data = new HiveEditorData(onDataChanged);
		_model = model;

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
		if(_model.node != null) {
			_model.node.changed.remove(onNodeChanged);
		}
		_model.node = _data.selectedNode;
		if(_model.node != null) {
			_model.node.changed.add(onNodeChanged);
		}

		if(_psView != null && _data.selectedNode != null && _psView.emitter != _data.selectedNode.getEmitter()) {
			_psView.emitter = _data.selectedNode.getEmitter();
		}
		_scope.safeApply(function() {
			_scope.set("psData", _data);
		});
	}

	function onNodeChanged(_) {
		trace("node changed");
		_scope.safeApply(function() {
			_scope.set("psData", _data);
		});
	}

	function onFrame(e:Float) {
		if(_psView != null) {
			_psView.render();
		}
		Browser.window.requestAnimationFrame(onFrame);
	}
}
