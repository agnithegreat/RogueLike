/**
 * Created by desktop on 21.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.roguelike.controller.GameController;
    import com.agnither.roguelike.model.room.Room;
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
            _game.room.addEventListener(Room.NEXT_ROOM, handleNextRoom);
        }

        override protected function initialize():void
        {
            _rooms = new Sprite();
            addChild(_rooms);

            _room = new RoomView();
            _rooms.addChild(_room);

            _next = new RoomView();

            _hero = new HeroView(_game.hero);
            addChild(_hero);

            _pivot = new Point();
        }

        private function handleNextRoom(event: Event):void
        {
            if (_tween)
            {
                Starling.juggler.remove(_tween);
                completeTween();
            }

            var direction: Point = event.data as Point;
            var dx: int = direction.x * 640;
            var dy: int = direction.y * 480;
            _next.x = _room.x + dx;
            _next.y = _room.y + dy;
            _rooms.addChild(_next);

            _pivot.x += dx;
            _pivot.y += dy;

            _tween = Starling.juggler.tween(this, 0.5, {pivotX: _pivot.x, pivotY: _pivot.y, transition: Transitions.EASE_OUT, onComplete: completeTween});
        }

        private function completeTween():void
        {
            _rooms.removeChild(_room);

            var temp: RoomView = _next;
            _next = _room;
            _room = temp;

            _tween = null;
        }
    }
}
