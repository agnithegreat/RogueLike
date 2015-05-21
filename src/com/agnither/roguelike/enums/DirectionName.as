/**
 * Created by desktop on 16.05.2015.
 */
package com.agnither.roguelike.enums
{
    public class DirectionName
    {
        public static const LEFT: DirectionName = new DirectionName("left");
        public static const RIGHT: DirectionName = new DirectionName("right");
        public static const UP: DirectionName = new DirectionName("up");
        public static const DOWN: DirectionName = new DirectionName("down");

        public static const DIRECTIONS: Array = [LEFT, RIGHT, UP, DOWN];

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
