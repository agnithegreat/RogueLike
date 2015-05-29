/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.controller
{
    import com.agnither.roguelike.enums.DirectionName;
    import com.agnither.roguelike.model.objects.Hero;
    import com.agnither.roguelike.model.room.Room;
    import com.agnither.roguelike.model.room.RoomFactory;

    import flash.geom.Point;
    import flash.utils.Dictionary;

    import starling.animation.Juggler;
    import starling.core.Starling;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class GameController extends EventDispatcher
    {
        private var _gameJuggler: Juggler;

        private var _rooms: Dictionary;

        private var _currentRoom: Room;
        public function get room():Room
        {
            return _currentRoom;
        }

        public function get hero():Hero
        {
            return _currentRoom.hero;
        }

        public function GameController()
        {
            _gameJuggler = new Juggler();

            _currentRoom = new Room();
            _currentRoom.addEventListener(Room.NEXT_ROOM, handleNextRoom);
            _gameJuggler.add(_currentRoom);
        }

        public function init():void
        {
            _rooms = RoomFactory.createMap();

            moveTo("0.0");

            var hero: Hero = new Hero();
            hero.init({hp: 5, speed: 200});
            hero.place(320, 240);
            _currentRoom.setHero(hero);

            start();
        }

        public function moveTo(id: String):void
        {
            _currentRoom.setState(_rooms[id]);
        }

        public function start():void
        {
            Starling.juggler.add(_gameJuggler);
        }

        public function stop():void
        {
            Starling.juggler.remove(_gameJuggler);
        }

        private function handleNextRoom(event: Event):void
        {
            var direction: Point = event.data as Point;
            var roomId: String = _currentRoom.currentRoom.getDoorId(DirectionName.getDirection(direction));
            moveTo(roomId);
        }
    }
}
