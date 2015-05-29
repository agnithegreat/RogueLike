/**
 * Created by desktop on 15.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.DirectionName;

    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    public class RoomState
    {
        public function get id():String
        {
            return _size.x + "." + _size.y;
        }

        private var _type: int;
        public function get type():int
        {
            return _type;
        }

        private var _doors: Dictionary;

        private var _gameObjects: Dictionary;
        public function get gameObjects():Dictionary
        {
            return _gameObjects;
        }

        private var _size: Rectangle;
        public function get size():Rectangle
        {
            return _size;
        }

        public var lastUpdate: int;

        public function RoomState()
        {
            _gameObjects = new Dictionary();
            _doors = new Dictionary();
        }

        public function init(data: Object):void
        {
            _type = data["type"];
            _size = new Rectangle(data["x"], data["y"], data["width"], data["height"]);
        }

        public function addDoor(direction: DirectionName, id: String):void
        {
            _doors[direction] = id;
        }

        public function removeDoor(direction: DirectionName):void
        {
            delete _doors[direction];
        }

        public function getDoorId(direction: DirectionName):String
        {
            return _doors[direction];
        }

        public function toString():String
        {
            return id;
        }
    }
}
