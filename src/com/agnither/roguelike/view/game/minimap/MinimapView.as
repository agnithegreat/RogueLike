/**
 * Created by desktop on 29.05.2015.
 */
package com.agnither.roguelike.view.game.minimap
{
    import com.agnither.roguelike.controller.GameController;
    import com.agnither.roguelike.model.room.Room;
    import com.agnither.roguelike.model.room.RoomState;
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.geom.Rectangle;

    import flash.utils.Dictionary;

    import starling.animation.Transitions;

    import starling.core.Starling;
    import starling.display.Sprite;

    import starling.events.Event;

    public class MinimapView extends AbstractComponent
    {
        private var _gameController: GameController;

        private var _views: Dictionary;
        private var _container: Sprite;

        private var _hero: AbstractComponent;

        public function MinimapView(gameController: GameController)
        {
            _gameController = gameController;
            _gameController.room.addEventListener(Room.TO_ROOM, handleToRoom);

            super();
        }

        override protected function initialize():void
        {
            _views = new Dictionary();
            _container = new Sprite();
            addChild(_container);

            for each (var roomState: RoomState in _gameController.rooms)
            {
                var roomView: RoomView = new RoomView(roomState);
                _container.addChild(roomView);
                _views[roomState] = roomView;
            }

            _hero = new AbstractComponent();
            _hero.createFromFlash("assets.map.HeroMC", "minimap");
            addChild(_hero);

            x = 160;
            y = 120;
            clipRect = new Rectangle(-160, -120, 320, 240);
        }

        private function handleToRoom(event: Event):void
        {
            var room: RoomState = event.data as RoomState;
            var roomView: RoomView = _views[room] as RoomView;
            roomView.update();

            Starling.juggler.tween(_container, 0.5, {pivotX: roomView.x, pivotY: roomView.y, transition: Transitions.EASE_OUT});
        }
    }
}
