package com.agnither.roguelike.view.game.room
{
    import com.agnither.roguelike.Settings;
    import com.agnither.roguelike.controller.GameController;
    import com.agnither.roguelike.model.room.Room;
    import com.agnither.roguelike.model.room.RoomState;
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.geom.Point;

    import starling.animation.IAnimatable;
    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    public class GameView extends AbstractComponent
    {
        private var _game: GameController;

        private var _rooms: Sprite;
        private var _hero: HeroView;

        private var _room: RoomView;
        private var _next: RoomView;

        private var _pivot: Point;

        private var _tween: IAnimatable;

        public function GameView(game: GameController)
        {
            _game = game;
            _game.room.addEventListener(Room.TO_ROOM, handleToRoom);
        }

        override protected function initialize():void
        {
            _rooms = new Sprite();
            addChild(_rooms);

            _room = new RoomView(_game.room.currentRoom);
            _rooms.addChild(_room);

            _hero = new HeroView(_game.hero);
            addChild(_hero);

            _pivot = new Point();
        }

        private function handleToRoom(event: Event):void
        {
            if (_tween)
            {
                Starling.juggler.remove(_tween);
                completeTween();
            }

            var room: RoomState = event.data as RoomState;
            _next = new RoomView(room);

            _next.x = room.size.x * Settings.ROOM_WIDTH;
            _next.y = room.size.y * Settings.ROOM_HEIGHT;
            _rooms.addChild(_next);

            _pivot.x = room.size.x * Settings.ROOM_WIDTH;
            _pivot.y = room.size.y * Settings.ROOM_HEIGHT;

            _tween = Starling.juggler.tween(this, 0.5, {pivotX: _pivot.x, pivotY: _pivot.y, transition: Transitions.EASE_OUT, onComplete: completeTween});
        }

        private function completeTween():void
        {
            var temp: RoomView = _next;
            _next = _room;
            _room = temp;

            _next.destroy();
            _next = null;

            _tween = null;
        }
    }
}
