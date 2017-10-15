package hxhive.data.nodes;

import hxphoton.Signal;
import hxfireflies.emitter.IEmitter;
import hxdispose.IDisposable;

class HiveNode implements IDisposable {
	public var type:HiveNodeType = HiveNodeType.SYSTEM;
	public var id:Float;
	public var title:String = "empty node";
	public var description:String = "empty description";
	public var isDeletable:Bool = true;

	public var parent:HiveNode = null;
	public var children:Array<HiveNode> = [];

	public var changed(default, null):Signal1<HiveNode>;

	var _emitter:IEmitter = null;

	public function new(title:String = "system", description:String = "", type:HiveNodeType = HiveNodeType.SYSTEM) {
		changed = new Signal1();

		id = Math.random();
		this.title = title;
		this.description = description;
		this.type = type;
	}

	public function dispose() {
		removeFromParent();
	}

	public function addChild(node:HiveNode) {
		if(node != null && children != null && children.indexOf(node) == -1) {
			node.removeFromParent();
			children.push(node);
			node.parent = this;
		}
	}

	public function removeFromParent() {
		if(parent != null && parent.children != null) {
			var index:Int = parent.children.indexOf(this);
			if(index != -1) {
				parent.children.splice(index, 1);
				trace('removed from parent');
			}
		}
	}

	public function addSystem() {
		addNode(new HiveSystemNode());
	}

	public function addEmitter() {
		addNode(new HiveEmitterNode());
	}

	public function addNode(node:HiveNode) {
		addChild(node);
	}

	public function getEmitter():IEmitter {
		var em:IEmitter = _emitter;
		while(em == null && parent != null) {
			em = parent.getEmitter();
		}

		return em;
	}

	public function getAreaNode():HiveAreaNode {
		return null;
	}

	public function getEmitterNode():HiveEmitterNode {
		return null;
	}

	public function hasEmittingAreaNode():Bool {
		return getAreaNode() != null;
	}

	public function isSystem():Bool {
		return type == HiveNodeType.SYSTEM;
	}

	public function isEmitter():Bool {
		return type == HiveNodeType.EMITTER;
	}

	function onNodeChanged() {
		changed.emit(this);
	}
}
