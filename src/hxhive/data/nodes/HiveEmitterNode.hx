package hxhive.data.nodes;

import hxfireflies.area.IArea;
import hxfireflies.animators.AnimatorOut;
import hxfireflies.animators.AnimatorIn;
import hxfireflies.animators.IAnimator;
import hxfireflies.forces.ForceGravity;
import hxfireflies.animators.AnimatorLinear;
import hxfireflies.pool.IPool;
import hxfireflies.particle.Particle;
import hxfireflies.pool.Pool;
import hxhive.view.HiveParticleView;
import hxhive.particles.HiveEmitter;
import hxfireflies.emitter.EmitterData;

class HiveEmitterNode extends HiveNode {
	public var emitterData(default, null):EmitterData;

	var _areaNode:HiveAreaNode;

	public function new() {
		super("emitter", "", HiveNodeType.EMITTER);

		emitterData = new EmitterData();
		addChild(new HiveSpriteSetNode());
		random();
	}

	public function random() {
		var valf:Float = 0;

		emitterData.lifetime = (Math.random() * 3 + 1) * 1000;
		emitterData.lifetimeDelta = (Math.random() * 3) * 1000;

		emitterData.alphaFrom = Math.random() * 1;
		if(emitterData.alphaFrom >= 0.5) {
			emitterData.alphaFromDelta = (1 - emitterData.alphaFrom) * Math.random();
			emitterData.alphaTo = Math.random() * 0.5;
			emitterData.alphaToDelta = (emitterData.alphaFrom - emitterData.alphaTo) * Math.random();
		}
		else {
			emitterData.alphaFromDelta = (0.5 - emitterData.alphaFrom) * Math.random();
			valf = emitterData.alphaFrom + emitterData.alphaFromDelta;
			emitterData.alphaTo = valf + (1 - valf) * Math.random();
			emitterData.alphaToDelta = (1 - emitterData.alphaTo) * Math.random();
		}
		emitterData.alphaAnimator = randomAnimator();

		emitterData.scaleFrom = Math.random() * 1;
		if(emitterData.scaleFrom >= 0.5) {
			emitterData.scaleFromDelta = (1 - emitterData.scaleFrom) * Math.random();
			emitterData.scaleTo = Math.random() * 0.5;
			emitterData.scaleToDelta = (emitterData.scaleFrom - emitterData.scaleTo) * Math.random();
		}
		else {
			emitterData.scaleFromDelta = (0.5 - emitterData.scaleFrom) * Math.random();
			valf = emitterData.scaleFrom + emitterData.scaleFromDelta;
			emitterData.scaleTo = valf + (1 - valf) * Math.random();
			emitterData.scaleToDelta = (1 - emitterData.scaleTo) * Math.random();
		}
		emitterData.scaleAnimator = randomAnimator();
		emitterData.scaleSimple = true;

		emitterData.velocityFrom = Math.random() * 100;
		emitterData.velocityFromDelta = Math.random() * (Math.min(100 - emitterData.velocityFrom, emitterData.velocityFrom));
		valf = emitterData.velocityFrom + emitterData.velocityFromDelta;
		if(Math.random() > 0.5) {
			emitterData.velocityTo = Math.random() * (100 - valf) + valf;
		}
		else {
			emitterData.velocityTo = Math.random() * valf;
		}
		emitterData.velocityToDelta = Math.random() * (Math.min(100 - emitterData.velocityTo, emitterData.velocityTo));
		emitterData.velocityAnimator = randomAnimator();

		randomAreaNode();
		emitterData.area = _areaNode.area;

		_emitter = new HiveEmitter(null/*new HiveParticleView(20)*/);
		_emitter.pool = null;
		_emitter.pool = randomPool(true);
//		_emitter.force = new ForceGravity(Math.random() * 2 - 1.0);
		_emitter.data = emitterData;
		_emitter.spawnInterval = 100;
		_emitter.enable = true;
		_emitter.x = 300;
		_emitter.y = 300;
		_emitter.data.area.y = 400;
		_emitter.data.area.x = 400;
	}

	function randomAreaNode() {
		children.remove(_areaNode);
		_areaNode = HiveAreaNode.createRandom();
		_areaNode.changed.add(onAreaNodeChanged);
		addChild(_areaNode);
	}

	function randomPool(alt:Bool):IPool {
		var p:Pool = new Pool();
		p.prototype = new Particle(new HiveParticleView(12, alt));
		p.maxLength = 50;

		return p;
	}

	function randomAnimator():IAnimator {
		return switch(Math.floor(Math.random() * 4)) {
			case 0:
				new AnimatorIn();
			case 1:
				new AnimatorLinear();
			case 2:
				new AnimatorOut();
			default:
				new AnimatorLinear();
		}
	}

	override public function getAreaNode():HiveAreaNode {
		return _areaNode;
	}

	override public function getEmitterNode():HiveEmitterNode {
		return this;
	}

	function onAreaNodeChanged(_) {
		_emitter.data.area = _areaNode.area;
		onNodeChanged();
	}
}
