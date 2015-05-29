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
            _roomsLimit = 20;

            var room: RoomState = generateRoom(0, 0);
            var currentList: Array = [room];
            var nextList: Array;

            while (_roomsLimit > 0)
            {
                nextList = [];

                var roomsLength: int = currentList.length;
                for (var i:int = 0; i < roomsLength; i++)
                {
                    var neighbours: Array = generateNeighbours(currentList[i]);
                    nextList = nextList.concat(neighbours);
                }

                currentList = nextList;
            }

            return _map;
        }

        private static function generateRoom(x: int, y: int):RoomState
        {
            var data: Object = {};
            data["x"] = x;
            data["y"] = y;
            data["type"] = Math.random() * 3 + 1;

            var room: RoomState = new RoomState();
            room.init(data);
            _map[room.id] = room;
            _roomsLimit--;

            return room;
        }

        private static function generateNeighbours(room: RoomState):Array
        {
            var position: Point = new Point(room.size.x, room.size.y);
            var nextPos: Point;
            var opposite: DirectionName;

            var neighbours: Array = [];
            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                nextPos = position.add(direction.direction);
                var roomId: String = getId(nextPos.x, nextPos.y);
                var neighbour: RoomState = _map[roomId];
                if (neighbour)
                {
                    opposite = DirectionName.getOpposite(direction.direction);
                    if (neighbour.getDoorId(opposite))
                    {
                        room.addDoor(direction, neighbour.id);
                    }
                } else if (_roomsLimit > 0 && Math.random() < 0.2 * nextPos.length)
                {
                    neighbour = generateRoom(nextPos.x, nextPos.y);
                    room.addDoor(direction, neighbour.id);
                    opposite = DirectionName.getOpposite(direction.direction);
                    neighbour.addDoor(opposite, room.id);
                    neighbours.push(neighbour);
                }
            }

            if (_roomsLimit > 0)
            {
                var randDirection:int = DirectionName.DIRECTIONS.length * Math.random();
                direction = DirectionName.DIRECTIONS[randDirection];
                nextPos = position.add(direction.direction);
                if (_map[getId(nextPos.x, nextPos.y)] == null)
                {
                    neighbour = generateRoom(nextPos.x, nextPos.y);
                    room.addDoor(direction, neighbour.id);
                    opposite = DirectionName.getOpposite(direction.direction);
                    neighbour.addDoor(opposite, room.id);
                    neighbours.push(neighbour);
                }
            }

            return neighbours;
        }

        private static function getId(x: int, y: int):String
        {
            return x + "." + y;
        }
    }
}
