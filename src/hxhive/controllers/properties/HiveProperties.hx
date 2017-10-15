package hxhive.controllers.properties;

import angular.service.Scope;

class HiveProperties {
	var _isActive:Bool = true;
	var _scope:Scope = null;

	public function new(scope:Scope) {
		_scope = scope;
	}

	public function update() {
	}

	public function isActive():Bool {
		return _scope != null && _isActive;
	}
}
