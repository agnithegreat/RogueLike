/**
 * Created by desktop on 15.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import flash.utils.Dictionary;

    public class RoomState
    {
        private var _id: String;
        public function get id():String
        {
            return _id;
        }

        private var _gameObjects: Dictionary;
        public function get gameObjects():Dictionary
        {
            return _gameObjects;
        }

        public var lastUpdate: int;

        public function RoomState()
        {
            _gameObjects = new Dictionary();
        }

        public function init(data: Object):void
        {
            _id = data["id"];
        }
    }
}
