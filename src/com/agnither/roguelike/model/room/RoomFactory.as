/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.DirectionName;

    import flash.utils.Dictionary;

    public class RoomFactory
    {
        public static function createRoom(data: Object):RoomState
        {
            var room: RoomState = new RoomState();
            room.init(data);
            return room;
        }

        public static function createMockRoom(x: int, y: int):RoomState
        {
            var id: String = getId(x, y);

            var type: int = Math.random() * 3 + 1;

            var doors: Dictionary = new Dictionary();
            doors[DirectionName.LEFT] = getId(x-1, y);
            doors[DirectionName.RIGHT] = getId(x+1, y);
            doors[DirectionName.UP] = getId(x, y-1);
            doors[DirectionName.DOWN] = getId(x, y+1);

            return createRoom({"id": id, "type": type, "doors": doors, "x": x * 640, "y": y * 480});
        }

        private static function getId(x: int, y: int):String
        {
            return x + "." + y;
        }
    }
}
