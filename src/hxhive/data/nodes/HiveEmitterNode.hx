package hxhive.data.nodes;

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
        emitterData.alphaFromDelta = Math.random() * (Math.min(1 - emitterData.alphaFrom, emitterData.alphaFrom));
        valf = emitterData.alphaFrom + emitterData.alphaFromDelta;
        if(Math.random() > 0.5) {
            emitterData.alphaTo = Math.random() * (1 - valf) + valf;
        }
        else {
            emitterData.alphaTo = Math.random() * valf;
        }
        emitterData.alphaToDelta = Math.random() * (Math.min(1 - emitterData.alphaTo, emitterData.alphaTo));
        emitterData.alphaAnimator = new AnimatorLinear();

        emitterData.scaleFrom = Math.random() * 1;
        emitterData.scaleFromDelta = Math.random() * (Math.min(1 - emitterData.scaleFrom, emitterData.scaleFrom));
        valf = emitterData.scaleFrom + emitterData.scaleFromDelta;
        if(Math.random() > 0.5) {
            emitterData.scaleTo = Math.random() * (1 - valf) + valf;
        }
        else {
            emitterData.scaleTo = Math.random() * valf;
        }
        emitterData.scaleToDelta = Math.random() * (Math.min(1 - emitterData.scaleTo, emitterData.scaleTo));
        emitterData.scaleAnimator = new AnimatorLinear();
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
        emitterData.velocityAnimator = new AnimatorLinear();

        emitterData.area = switch(Math.floor(Math.random() * 5)) {
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
}
