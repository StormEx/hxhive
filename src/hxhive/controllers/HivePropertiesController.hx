package hxhive.controllers;

import hxhive.data.nodes.HiveForceNode;
import hxhive.data.properties.HiveForceProperties;
import hxhive.data.properties.HiveEmitterProperties;
import hxhive.data.nodes.HiveEmitterNode;
import hxhive.data.nodes.HiveAreaNode;
import hxhive.data.nodes.HiveNode;
import hxhive.data.HiveModel;
import hxhive.data.properties.HiveAreaProperties;
import hxhive.view.HiveMainView;
import angular.service.Scope;

class HivePropertiesController {
	public var area(default, set):HiveAreaNode;
	public var emitter(default, set):HiveEmitterNode;
	public var force(default, set):HiveForceNode;

	var _view:HiveMainView = null;
	var _scope:Scope;
	var _model:HiveModel = null;
	var _area:HiveAreaProperties;
	var _emitter:HiveEmitterProperties;
	var _force:HiveForceProperties;

	public function new(scope:Scope, view:HiveMainView, model:HiveModel) {
		_view = view;
		_scope = scope;
		_model = model;
		_model.nodeChanged.add(onNodeChanged);

		_area = new HiveAreaProperties(_scope);
		_emitter = new HiveEmitterProperties(_scope);
		_force = new HiveForceProperties(_scope);
	}

	function onNodeChanged(node:HiveNode) {
		area = node.getAreaNode();
		emitter = node.getEmitterNode();
		force = node.getForceNode();
	}

	function set_area(value:HiveAreaNode):HiveAreaNode {
		if(_area.area != value) {
			_area.area = value;

			_scope.safeApply(function() {
				_scope.set("area", _area);
			});
		}

		return _area.area;
	}

	function set_emitter(value:HiveEmitterNode):HiveEmitterNode {
		if(_emitter.emitter != value) {
			_emitter.emitter = value;

			_scope.safeApply(function() {
				_scope.set("emitter", _emitter);
			});
		}

		return _emitter.emitter;
	}

	function set_force(value:HiveForceNode):HiveForceNode {
		if(_force.force != value) {
			_force.force = value;

			_scope.safeApply(function() {
				_scope.set("force", _force);
			});
		}

		return _force.force;
	}
}
