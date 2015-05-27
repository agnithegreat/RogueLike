/**
 * Created by desktop on 21.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.roguelike.controller.GameController;
    import com.agnither.roguelike.model.room.Room;
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.geom.Point;

    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.events.Event;

    public class GameView extends AbstractComponent
    {
        private var _game: GameController;

        private var _room: RoomView;
        private var _next: RoomView;
        private var _hero: HeroView;

        public function GameView(game: GameController)
        {
            _game = game;
            _game.room.addEventListener(Room.NEXT_ROOM, handleNextRoom);
        }

        override protected function initialize():void
        {
            _room = new RoomView();
            addChild(_room);

            _next = new RoomView();

            _hero = new HeroView(_game.hero);
            addChild(_hero);
        }

        private function handleNextRoom(event: Event):void
        {
            var direction: Point = event.data as Point;
            var dx: int = direction.x * 640;
            var dy: int = direction.y * 480;
            _next.x = dx;
            _next.y = dy;
            addChildAt(_next, 1);

            Starling.juggler.tween(this, 0.4, {pivotX: dx, pivotY: dy, transition: Transitions.EASE_OUT, onComplete: completeTween});
        }

        private function completeTween():void
        {
            pivotX = 0;
            pivotY = 0;

            var temp: RoomView = _next;
            _next = _room;
            _room = temp;
            removeChild(_next);

            _room.x = 0;
            _room.y = 0;
        }
    }
}
