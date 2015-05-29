/**
 * Created by desktop on 16.05.2015.
 */
package com.agnither.roguelike.enums
{
    import flash.geom.Point;

    public class DirectionName
    {
        public static const LEFT: DirectionName = new DirectionName("left", new Point(-1, 0));
        public static const RIGHT: DirectionName = new DirectionName("right", new Point(1, 0));
        public static const UP: DirectionName = new DirectionName("up", new Point(0, -1));
        public static const DOWN: DirectionName = new DirectionName("down", new Point(0, 1));

        public static const DIRECTIONS: Array = [LEFT, RIGHT, UP, DOWN];

        public static function getDirection(dir: Point):DirectionName
        {
            for each (var direction: DirectionName in DIRECTIONS)
            {
                if (direction.direction.equals(dir))
                {
                    return direction;
                }
            }
            return null;
        }

        private var _name: String;
        public function get name():String
        {
            return _name;
        }

        private var _direction: Point;
        public function get direction():Point
        {
            return _direction;
        }

        public function DirectionName(name: String, direction: Point)
        {
            _name = name;
            _direction = direction;
        }
    }
}
