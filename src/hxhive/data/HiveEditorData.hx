package hxhive.data;

import hxhive.data.nodes.HiveNode;
import hxdispose.Dispose;

class HiveEditorData {
	public var treeData:Array<HiveNode> = [];

	var _changedCallback:Void->Void = null;

	var _selectedNode:HiveNode = null;
	var _isLoaded:Bool = true;

	public function new(changed:Void->Void) {
		_changedCallback = changed;
	}

	public function reset() {
		treeData = [];
		var root:HiveNode = new HiveNode();
		root.title = "particle system";
		root.description = "root";
		treeData.push(root);
		selectNode(treeData[0], true);
	}

	public function selectNode(node:HiveNode, selected:Bool) {
		if(_selectedNode != node) {
			_selectedNode = node;
			changed();
		}
	}

	public function deleteNode(node:HiveNode) {
		Dispose.dispose(node);

		changed();
	}

	public function isLoaded():Bool {
		return _isLoaded;
	}

	function changed() {
		if(_changedCallback != null) {
			trace("data changed");
			_changedCallback();
		}
	}
}
