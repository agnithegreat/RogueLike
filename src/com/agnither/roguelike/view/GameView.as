/**
 * Created by desktop on 21.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.roguelike.controller.GameController;
    import com.agnither.utils.gui.components.AbstractComponent;

    public class GameView extends AbstractComponent
    {
        private var _game: GameController;

        private var _room: RoomView;
        private var _hero: HeroView;

        public function GameView(game: GameController)
        {
            _game = game;
        }

        override protected function initialize():void
        {
            _room = new RoomView();
            addChild(_room);

            _hero = new HeroView(_game.hero);
            addChild(_hero);
        }
    }
}
