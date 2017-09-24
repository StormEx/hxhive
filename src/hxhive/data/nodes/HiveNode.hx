package hxhive.data.nodes;

import hxfireflies.emitter.IEmitter;
import hxdispose.IDisposable;

class HiveNode implements IDisposable {
    public var type:HiveNodeType = HiveNodeType.SYSTEM;
    public var id:Float;
    public var title:String = "empty node";
    public var description:String = "empty description";
    public var emitter:IEmitter = null;

    public var parent:HiveNode = null;
    public var children:Array<HiveNode> = [];

    public function new(title:String = "system", description:String = "", type:HiveNodeType = HiveNodeType.SYSTEM) {
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
        addChild(new HiveSystemNode());
    }

    public function addEmitter() {
        addChild(new HiveEmitterNode());
    }

    public function isSystem():Bool {
        return type == HiveNodeType.SYSTEM;
    }

    public function isEmitter():Bool {
        return type == HiveNodeType.EMITTER;
    }
}
