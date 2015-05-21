/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.objects
{
    import nape.callbacks.CbType;

    import nape.phys.BodyType;

    public class Personage extends GameObject
    {
        protected var _hp: int;
        public function get hp():int
        {
            return _hp;
        }

        protected var _speed: Number;
        protected var _speedMultiplier: Number;
        protected var _direction: Number;

        public function get movementX():Number
        {
            return _speed * _speedMultiplier * Math.cos(_direction);
        }

        public function get movementY():Number
        {
            return _speed * _speedMultiplier * Math.sin(_direction);
        }

        public function Personage()
        {
            _speed = 0;
            _direction = 0;
            _speedMultiplier = 0;

            super(BodyType.DYNAMIC);
        }

        public function init(data: Object):void
        {
            _hp = data["hp"];
            _speed = data["speed"];
        }

        public function move(speedMultiplier: Number):void
        {
            _speedMultiplier = speedMultiplier;
            updateMovement();
        }

        public function rotate(direction: Number):void
        {
            _direction = direction;
            updateMovement();
        }

        public function stop():void
        {
            _speedMultiplier = 0;
            updateMovement();
        }

        override protected function updateMovement():void
        {
            super.updateMovement();

            _movement.x += _speed * _speedMultiplier * Math.cos(_direction);
            _movement.y += _speed * _speedMultiplier * Math.sin(_direction);
        }
    }
}
