package com.agnither.roguelike.controller
{
    import com.agnither.roguelike.Settings;
    import com.agnither.roguelike.model.objects.Hero;
    import com.agnither.roguelike.model.room.Room;
    import com.agnither.roguelike.model.room.RoomFactory;

    import flash.utils.Dictionary;

    import starling.animation.Juggler;
    import starling.core.Starling;
    import starling.events.Event;
    import starling.events.EventDispatcher;

    public class GameController extends EventDispatcher
    {
        private var _gameJuggler: Juggler;

        private var _rooms: Dictionary;
        public function get rooms():Dictionary
        {
            return _rooms;
        }

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
            hero.place(Settings.ROOM_WIDTH/2, Settings.ROOM_HEIGHT/2);
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
            var roomId: String = event.data as String;
            if (roomId != null)
            {
                moveTo(roomId);
            }
        }
    }
}
