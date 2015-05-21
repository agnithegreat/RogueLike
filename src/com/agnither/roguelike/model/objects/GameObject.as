/**
 * Created by desktop on 16.05.2015.
 */
package com.agnither.roguelike.model.objects
{
    import com.agnither.roguelike.model.physics.Power;

    import flash.geom.Point;
    import flash.utils.Dictionary;

    import nape.phys.Body;
    import nape.phys.BodyType;
    import nape.shape.Polygon;
    import nape.shape.Shape;

    import starling.animation.IAnimatable;
    import starling.events.EventDispatcher;

    public class GameObject extends EventDispatcher implements IAnimatable
    {
        public static const UPDATE: String = "update";

        private static var count: int = 0;

        protected var _id: int = ++count;
        public function get id():int
        {
            return _id;
        }

        protected var _body: Body;
        public function get body():Body
        {
            return _body;
        }

        protected var _shape: Shape;
        public function get shape():Shape
        {
            return _shape;
        }

        public function get x():int
        {
            return _body.position.x;
        }

        public function get y():int
        {
            return _body.position.y;
        }

        protected var _powers: Dictionary;

        protected var _movement: Point;

        public function GameObject(type: BodyType)
        {
            _body = new Body(type);
            _body.allowRotation = false;
            _shape = new Polygon(Polygon.box(20, 10));
            _shape.body = _body;

            _powers = new Dictionary();
            _movement = new Point();
        }

        public function place(x: int, y: int):void
        {
            _body.position.setxy(x, y);
        }

        public function addPower(power: Power):void
        {
            _powers[power.id] = power;
            updateMovement();
        }

        public function removePower(power: Power):void
        {
            delete _powers[power.id];
            updateMovement();
        }

        public function advanceTime(time: Number):void
        {
            _body.velocity.setxy(_movement.x, _movement.y);

            update();
        }

        protected function updateMovement():void
        {
            _movement.x = 0;
            _movement.y = 0;

            for each (var power: Power in _powers)
            {
                var p: Point = power.getPower(this);
                _movement.x += p.x;
                _movement.y += p.y;
            }
        }

        protected function update():void
        {
            dispatchEventWith(UPDATE);
        }
    }
}
