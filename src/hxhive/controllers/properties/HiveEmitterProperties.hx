package hxhive.controllers.properties;

import hxfireflies.animators.AnimatorIn;
import hxfireflies.animators.AnimatorOut;
import hxfireflies.animators.AnimatorLinear;
import hxfireflies.animators.IAnimator;
import hxhive.data.nodes.HiveEmitterNode;
import angular.service.Scope;

class HiveEmitterProperties extends HiveProperties {
	public var emitter(default, set):HiveEmitterNode = null;

	public var easingTypes:Array<String> = [
		"none",
		"linear",
		"in",
		"out"
	];

	public var spawnCount:Int;
	public var spawnInterval:Float;

	public var lifeTimeEndless:Bool = false;
	public var lifeTime:Float = 0;
	public var lifeTimeDelta:Float = 0;

	public var alphaFrom:Float = 0;
	public var alphaFromDelta:Float = 0;
	public var alphaTo:Float = 0;
	public var alphaToDelta:Float = 0;
	public var alphaEasing:String = "linear";

	public var velocityFrom:Float = 0;
	public var velocityFromDelta:Float = 0;
	public var velocityTo:Float = 0;
	public var velocityToDelta:Float = 0;
	public var velocityEasing:String = "linear";

	public var monoScale:Bool = true;

	public var scaleFrom:Float = 0;
	public var scaleFromDelta:Float = 0;
	public var scaleTo:Float = 0;
	public var scaleToDelta:Float = 0;
	public var scaleEasing:String = "linear";

	public var scaleYFrom:Float = 0;
	public var scaleYFromDelta:Float = 0;
	public var scaleYTo:Float = 0;
	public var scaleYToDelta:Float = 0;
	public var scaleYEasing:String = "linear";

	public var spinFrom:Float = 0;
	public var spinFromDelta:Float = 0;
	public var spinTo:Float = 0;
	public var spinToDelta:Float = 0;
	public var spinEasing:String = "linear";

	public function new(scope:Scope) {
		super(scope);
	}

	override public function update() {
		emitter.getEmitter().spawnCount = spawnCount;
		emitter.getEmitter().spawnInterval = spawnInterval * 1000;
		if(lifeTimeEndless) {
			emitter.emitterData.lifetimeDelta = 0;
			emitter.emitterData.lifetime = -1;
		}
		else {
			emitter.emitterData.lifetime = lifeTime * 1000;
			emitter.emitterData.lifetimeDelta = lifeTimeDelta * 1000;
		}

		emitter.emitterData.alphaFrom = alphaFrom;
		emitter.emitterData.alphaFromDelta = alphaFromDelta;
		emitter.emitterData.alphaTo = alphaTo;
		emitter.emitterData.alphaToDelta = alphaToDelta;

		emitter.emitterData.velocityFrom = velocityFrom;
		emitter.emitterData.velocityFromDelta = velocityFromDelta;
		emitter.emitterData.velocityTo = velocityTo;
		emitter.emitterData.velocityToDelta = velocityToDelta;

		emitter.emitterData.scaleFrom = scaleFrom;
		emitter.emitterData.scaleFromDelta = scaleFromDelta;
		emitter.emitterData.scaleTo = scaleTo;
		emitter.emitterData.scaleToDelta = scaleToDelta;

		emitter.emitterData.scaleYFrom = scaleYFrom;
		emitter.emitterData.scaleYFromDelta = scaleYFromDelta;
		emitter.emitterData.scaleYTo = scaleYTo;
		emitter.emitterData.scaleYToDelta = scaleYToDelta;

		emitter.emitterData.spinFrom = spinFrom;
		emitter.emitterData.spinFromDelta = spinFromDelta;
		emitter.emitterData.spinTo = spinTo;
		emitter.emitterData.spinToDelta = spinToDelta;
	}

	function createAnimator(value:String):IAnimator {
		return switch(value) {
			case "in":
				new AnimatorIn();
			case "out":
				new AnimatorOut();
			case "linear":
				new AnimatorLinear();
			default:
				null;
		}
	}

	public function changeAlphaEasing(value:String) {
		alphaEasing = value;
		emitter.emitterData.alphaAnimator = createAnimator(value);
	}

	public function changeVelocityEasing(value:String) {
		velocityEasing = value;
		emitter.emitterData.velocityAnimator = createAnimator(value);
	}

	public function changeScaleEasing(value:String) {
		scaleEasing = value;
		emitter.emitterData.scaleAnimator = createAnimator(value);
	}

	public function changeScaleYEasing(value:String) {
		scaleYEasing = value;
		emitter.emitterData.scaleYAnimator = createAnimator(value);
	}

	public function changeSpinEasing(value:String) {
		spinEasing = value;
		emitter.emitterData.spinAnimator = createAnimator(value);
	}

	override public function isActive():Bool {
		return super.isActive() && emitter != null;
	}

	function getAnimatorType(value:IAnimator):String {
		if(Std.instance(value, AnimatorLinear) != null) {
			return "linear";
		}
		if(Std.instance(value, AnimatorOut) != null) {
			return "out";
		}
		if(Std.instance(value, AnimatorIn) != null) {
			return "in";
		}

		return "none";
	}

	function set_emitter(value:HiveEmitterNode):HiveEmitterNode {
		trace('emitter set');
		this.emitter = value;
		if(value != null) {
			spawnCount = emitter.getEmitter().spawnCount;
			spawnInterval = emitter.getEmitter().spawnInterval / 1000;

			lifeTimeEndless = emitter.emitterData.lifetime < 0;
			lifeTime = emitter.emitterData.lifetime / 1000;
			lifeTimeDelta = emitter.emitterData.lifetimeDelta / 1000;

			alphaFrom = emitter.emitterData.alphaFrom;
			alphaFromDelta = emitter.emitterData.alphaFromDelta;
			alphaTo = emitter.emitterData.alphaTo;
			alphaToDelta = emitter.emitterData.alphaToDelta;
			alphaEasing = getAnimatorType(emitter.emitterData.alphaAnimator);

			velocityFrom = emitter.emitterData.velocityFrom;
			velocityFromDelta = emitter.emitterData.velocityFromDelta;
			velocityTo = emitter.emitterData.velocityTo;
			velocityToDelta = emitter.emitterData.velocityToDelta;
			velocityEasing = getAnimatorType(emitter.emitterData.velocityAnimator);

			scaleFrom = emitter.emitterData.scaleFrom;
			scaleFromDelta = emitter.emitterData.scaleFromDelta;
			scaleTo = emitter.emitterData.scaleTo;
			scaleToDelta = emitter.emitterData.scaleToDelta;
			scaleEasing = getAnimatorType(emitter.emitterData.scaleAnimator);

			scaleYFrom = emitter.emitterData.scaleYFrom;
			scaleYFromDelta = emitter.emitterData.scaleYFromDelta;
			scaleYTo = emitter.emitterData.scaleYTo;
			scaleYToDelta = emitter.emitterData.scaleYToDelta;
			scaleYEasing = getAnimatorType(emitter.emitterData.scaleYAnimator);

			spinFrom = emitter.emitterData.spinFrom;
			spinFromDelta = emitter.emitterData.spinFromDelta;
			spinTo = emitter.emitterData.spinTo;
			spinToDelta = emitter.emitterData.spinToDelta;
			spinEasing = getAnimatorType(emitter.emitterData.spinAnimator);
		}

		return value;
	}
}
