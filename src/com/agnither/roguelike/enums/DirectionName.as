/**
 * Created by desktop on 16.05.2015.
 */
package com.agnither.roguelike.enums
{
    import flash.geom.Point;

    public class DirectionName
    {
        public static const LEFT: DirectionName = new DirectionName("left");
        public static const RIGHT: DirectionName = new DirectionName("right");
        public static const UP: DirectionName = new DirectionName("up");
        public static const DOWN: DirectionName = new DirectionName("down");

        public static const DIRECTIONS: Array = [LEFT, RIGHT, UP, DOWN];

        public static function getDirection(direction: Point):DirectionName
        {
            if (direction.x < 0)
            {
                return LEFT;
            }
            if (direction.x > 0)
            {
                return RIGHT;
            }
            if (direction.y < 0)
            {
                return UP;
            }
            if (direction.y > 0)
            {
                return DOWN;
            }
            return null;
        }

        private var _name: String;
        public function get name():String
        {
            return _name;
        }

        public function DirectionName(name: String)
        {
            _name = name;
        }
    }
}
