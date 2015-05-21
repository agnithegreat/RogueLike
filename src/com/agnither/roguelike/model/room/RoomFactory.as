/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    public class RoomFactory
    {
        public static function createRoom(data: Object):RoomState
        {
            var room: RoomState = new RoomState();
            room.init(data);
            return room;
        }

        public static function createMockRoom():RoomState
        {
            return createRoom({id: "1", doors: {}});
        }
    }
}
