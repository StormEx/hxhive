package hxhive.data;

import hxhive.data.nodes.HiveNode;
import hxdispose.Dispose;

class HiveEditorData {
	public var treeData:Array<HiveNode> = [];
	public var selectedNode:HiveNode = null;

	var _changedCallback:Void -> Void = null;

	var _isLoaded:Bool = true;

	public function new(changed:Void -> Void) {
		_changedCallback = changed;
	}

	public function reset() {
		treeData = [];
		var root:HiveNode = new HiveNode();
		root.title = "particles";
		root.description = "root";
		treeData.push(root);
		root = new HiveNode();
		root.title = "forces";
		root.description = "root";
		treeData.push(root);
		root = new HiveNode();
		root.title = "images";
		root.description = "root";
		treeData.push(root);
		selectNode(treeData[0], true);
	}

	public function selectNode(node:HiveNode, selected:Bool) {
		if(selectedNode != node) {
			selectedNode = node;
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
