package hxhive.data.properties;

import hxhive.data.areas.HiveAreaNames;
import hxhive.data.areas.HiveAreaType;
import hxfireflies.area.ArcArea;
import hxfireflies.area.RingArea;
import hxfireflies.area.CircleArea;
import hxfireflies.area.RectangleArea;
import hxhive.data.nodes.HiveAreaNode;
import angular.service.Scope;

class HiveAreaProperties extends HiveProperties {
	public var areaTypeName:String;
	public var areaTypes:Array<String> = [
		"point",
		"rectangle",
		"circle",
		"ring",
		"arc"
	];
	public var one:Float = 0;
	public var two:Float = 0;
	public var three:Float = 0;

	public var area(default, set):HiveAreaNode;

	public function new(scope:Scope) {
		super(scope);

		area = null;
	}

	override public function update() {
		switch(area.areaType) {
			case HiveAreaType.POINT:
			case HiveAreaType.RECTANGLE:
				var ra:RectangleArea = cast area.area;
				ra.width = one;
				ra.height = two;
			case HiveAreaType.CIRCLE:
				var ca:CircleArea = cast area.area;
				ca.radius = one;
			case HiveAreaType.RING:
				var ra:RingArea = cast area.area;
				ra.minRadius = one;
				ra.maxRadius = two;
			case HiveAreaType.ARC:
				var ra:ArcArea = cast area.area;
				ra.radius = one;
				ra.angleFrom = two;
				ra.angleTo = three;
			default:
		}
	}

	public function changeAreaType(value:String) {
		areaTypeName = value;
		area.changeArea(HiveAreaType.fromString(value));
		fillParameters();
	}

	function fillParameters() {
		switch(area.areaType) {
			case HiveAreaType.POINT:
			case HiveAreaType.RECTANGLE:
				var ra:RectangleArea = cast area.area;
				one = ra.width;
				two = ra.height;
			case HiveAreaType.CIRCLE:
				var ca:CircleArea = cast area.area;
				one = ca.radius;
			case HiveAreaType.RING:
				var ra:RingArea = cast area.area;
				one = ra.minRadius;
				two = ra.maxRadius;
			case HiveAreaType.ARC:
				var ra:ArcArea = cast area.area;
				one = ra.radius;
				two = ra.angleFrom;
				three = ra.angleTo;
			default:
		}
	}

	function getAreaType():String {
		return isActive() ? area.areaType.toString() : HiveAreaNames.POINT;
	}

	override public function isActive():Bool {
		return super.isActive() && area != null;
	}

	function set_area(value:HiveAreaNode):HiveAreaNode {
		area = value;
		if(value != null) {
			areaTypeName = value.areaType.toString();
			fillParameters();
		}

		return value;
	}
}
