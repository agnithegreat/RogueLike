/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.DirectionName;

    import flash.geom.Point;
    import flash.utils.Dictionary;

    public class RoomFactory
    {
        private static var _map: Dictionary;
        private static var _roomsLimit: int;

        public static function createMap():Dictionary
        {
            _map = new Dictionary();
            _roomsLimit = 10;

            var room: RoomState = generateRoom(0, 0);
            _map[room.id] = room;

            var currentList: Array = [room];
            var nextList: Array;

            while (_roomsLimit > 0)
            {
                nextList = [];

                var roomsLength: int = currentList.length;
                for (var i:int = 0; i < roomsLength; i++)
                {
                    room = currentList[i];
                    for each (var direction:DirectionName in DirectionName.DIRECTIONS)
                    {
                        var doorId: String = room.getDoorId(direction);
                        if (doorId != null && _map[doorId] == null)
                        {
                            var pos: Array = doorId.split(".");
                            var newRoom: RoomState = generateRoom(pos[0], pos[1]);
                            _map[newRoom.id] = newRoom;
                            nextList.push(newRoom);
                        }
                    }
                }

                currentList = nextList;
            }

            return _map;
        }

        private static function generateRoom(x: int, y: int):RoomState
        {
            var id: String = getId(x, y);
            var type: int = Math.random() * 3 + 1;

            var position: Point = new Point(x, y);
            var nextPos: Point;

            var doors: Dictionary = new Dictionary();
            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                nextPos = position.add(direction.direction);
                if (nextPos.length < position.length)
                {
                    doors[direction] = getId(nextPos.x, nextPos.y);
                } else if (_roomsLimit > 0 && Math.random() < 0.5)
                {
                    _roomsLimit--;
                    doors[direction] = getId(nextPos.x, nextPos.y);
                }
            }

            if (_roomsLimit > 0)
            {
                var randDirection:int = DirectionName.DIRECTIONS.length * Math.random();
                direction = DirectionName.DIRECTIONS[randDirection];
                if (doors[direction] == null)
                {
                    _roomsLimit--;
                    nextPos = position.add(direction.direction);
                    doors[direction] = getId(nextPos.x, nextPos.y);
                }
            }

            return createRoom(id, type, doors);
        }

        public static function createRoom(id: String, type: int, doors: Dictionary):RoomState
        {
            var pos: Array = id.split(".");

            var data: Object = {};
            data["id"] = id;
            data["x"] = pos[0];
            data["y"] = pos[1];
            data["type"] = type;
            data["doors"] = doors;
            return createRoomInstance(data);
        }

        private static function createRoomInstance(data: Object):RoomState
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

            return createRoom(id, type, doors);
        }

        private static function getId(x: int, y: int):String
        {
            return x + "." + y;
        }
    }
}
