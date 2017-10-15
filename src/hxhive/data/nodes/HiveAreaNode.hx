package hxhive.data.nodes;

import hxfireflies.area.PointArea;
import hxfireflies.area.RectangleArea;
import hxfireflies.area.CircleArea;
import hxfireflies.area.RingArea;
import hxfireflies.area.ArcArea;
import hxfireflies.area.IArea;

class HiveAreaNode extends HiveNode {
	public var areaType(default, set):HiveAreaType = HiveAreaType.POINT;
	public var area(default, set):IArea = null;

	static public function createArea(type:HiveAreaType):IArea {
		return createRandomArea(type);
	}

	public static function createRandom(?type:HiveAreaType):HiveAreaNode {
		type = type == null ? HiveAreaType.random() : type;

		return new HiveAreaNode(type);
	}

	public static function createRandomArea(type:HiveAreaType) {
		var valf:Float = Math.random() * 60 + 40;

		return switch(type) {
			case HiveAreaType.ARC:
				var aa:ArcArea = new ArcArea();
				aa.radius = valf;
				valf = Math.random() * 360;
				aa.angleFrom = valf;
				aa.angleTo = Math.random() * (360 - valf) + valf;
				aa;
			case HiveAreaType.CIRCLE:
				var ca:CircleArea = new CircleArea();
				ca.radius = valf;
				ca;
			case HiveAreaType.RECTANGLE:
				var ra:RectangleArea = new RectangleArea();
				ra.width = valf;
				ra.height = valf;
				ra;
			case HiveAreaType.RING:
				var ra:RingArea = new RingArea();
				ra.minRadius = valf;
				ra.minRadius = Math.random() * (100 - valf) + valf;
				ra;
			default:
				new PointArea();
		}
	}

	public function new(type:HiveAreaType) {
		super("area", "emiiting area", HiveNodeType.AREA);

		area = createArea(type);
		title = getTitle(type);

		isDeletable = false;
	}

	public function changeArea(type:HiveAreaType) {
		var a:IArea = HiveAreaNode.createArea(type);
		a.x = area.x;
		a.y = area.y;
		areaType = type;
		area = a;
	}

	function getTitle(type:HiveAreaType) {
		return switch(type) {
			case HiveAreaType.RECTANGLE:
				"rectangle";
			case HiveAreaType.CIRCLE:
				"circle";
			case HiveAreaType.RING:
				"ring";
			case HiveAreaType.ARC:
				"arc";
			default:
				"point";
		}
	}

	function set_areaType(value:HiveAreaType):HiveAreaType {
		if(areaType != value) {
			areaType = value;
			area = createArea(areaType);
		}

		return areaType;
	}

	function set_area(value:IArea):IArea {
		if(value != null && area != value) {
			area = value;
			onNodeChanged();
		}

		return area;
	}

	override public function getAreaNode():HiveAreaNode {
		return this;
	}
}
