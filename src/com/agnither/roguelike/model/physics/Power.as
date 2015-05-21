/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.physics
{
    import com.agnither.roguelike.model.objects.GameObject;

    import flash.geom.Point;

    public class Power
    {
        private static var count: int = 0;

        protected var _id: int = ++count;
        public function get id():int
        {
            return _id;
        }

        private var _power: Point;

        public function Power(x: Number, y: Number)
        {
            _power = new Point(x, y);
        }

        public function getPower(object: GameObject):Point
        {
            return _power;
        }
    }
}
