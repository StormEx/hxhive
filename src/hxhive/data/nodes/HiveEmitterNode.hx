package hxhive.data.nodes;

import hxfireflies.animators.AnimatorOut;
import hxfireflies.animators.AnimatorIn;
import hxfireflies.animators.IAnimator;
import hxfireflies.forces.ForceGravity;
import hxdispose.Dispose;
import hxfireflies.animators.AnimatorLinear;
import hxfireflies.particle.IParticleView;
import hxfireflies.pool.IPool;
import hxfireflies.particle.Particle;
import hxfireflies.pool.Pool;
import hxhive.view.HiveParticleView;
import hxhive.particles.HiveEmitter;
import hxfireflies.area.RingArea;
import hxfireflies.area.RectangleArea;
import hxfireflies.area.CircleArea;
import hxfireflies.area.ArcArea;
import hxfireflies.area.PointArea;
import hxfireflies.area.IArea;
import hxfireflies.emitter.EmitterData;

class HiveEmitterNode extends HiveNode {
    public var emitterData(default, null):EmitterData;

    public function new() {
        super("emitter", "", HiveNodeType.EMITTER);

        emitterData = new EmitterData();
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
            emitterData.alphaTo =  valf + (1 - valf) * Math.random();
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
            emitterData.scaleTo =  valf + (1 - valf) * Math.random();
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

        emitterData.area = switch(Math.floor(Math.random() * 5)) {
            case 0:
                trace("point");
                new PointArea();
            case 1:
                trace("arc");
                valf = Math.random() * 360;
                new ArcArea(Math.random() * 60 + 40, valf, Math.random() * (360 - valf) + valf);
            case 2:
                trace("circle");
                new CircleArea(Math.random() * 60 + 40);
            case 3:
                trace("rectangle");
                new RectangleArea(Math.random() * 60 + 40, Math.random() * 60 + 40);
            default:
                trace("ring");
                valf = Math.random() * 60 + 40;
                new RingArea(valf, Math.random() * (100 - valf) + valf);
        }

        emitter = new HiveEmitter(null/*new HiveParticleView(20)*/);
        emitter.pool = null;
        emitter.pool = randomPool(false);
        emitter.force = new ForceGravity(Math.random() * 2 - 1.0);
        emitter.data = emitterData;
        emitter.spawnInterval = 100;
        emitter.enable = true;
        emitter.x = 300;
        emitter.y = 300;
        emitter.data.area.y = 400;
        emitter.data.area.x = 400;
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
                trace('in');
                new AnimatorIn();
            case 1:
                trace('linear');
                new AnimatorLinear();
            case 2:
                trace('out');
                new AnimatorOut();
            default:
                trace('linear');
                new AnimatorLinear();
        }
    }
}
