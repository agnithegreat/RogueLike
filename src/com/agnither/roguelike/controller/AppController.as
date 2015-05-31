/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.controller
{
    import com.agnither.roguelike.Assets;
    import com.agnither.roguelike.view.game.minimap.MinimapView;
    import com.agnither.roguelike.view.game.room.GameView;
    import com.agnither.utils.KeyLogger;
    import com.agnither.utils.TouchLogger;
    import com.agnither.utils.gui.DBSWFLoader;
    import com.agnither.utils.gui.Resources;
    import com.agnither.utils.gui.SWFLoader;
    import com.agnither.utils.gui.atlas.AtlasFactory;

    import dragonBones.factories.StarlingFactory;

    import flash.events.Event;

    import starling.display.Sprite;
    import starling.events.EventDispatcher;

    public class AppController extends EventDispatcher
    {
        private var _root: Sprite;

        private var _gameController: GameController;

        private var _swfLoader: SWFLoader;
        private var _dbswfLoader: DBSWFLoader;

        public function AppController()
        {
            super();
        }

        public function init(root: Sprite):void
        {
            _root = root;

            KeyLogger.init(_root.stage);
            TouchLogger.init(_root.stage);

            loadAssets();
        }

        private function start():void
        {
            Resources.addAtlas("minimap", AtlasFactory.fromAtlasDefinition("assets.map.AtlasMC"));

            Resources.addAtlas("level1", AtlasFactory.fromAtlasDefinition("assets.level.Level1MC"));

            _gameController = new GameController();
            _gameController.init();

            var gameView: GameView = new GameView(_gameController);
            _root.addChild(gameView);

            var minimapView: MinimapView = new MinimapView(_gameController);
            _root.addChild(minimapView);
        }

        private function loadAssets():void
        {
            _swfLoader = new SWFLoader();
            _swfLoader.addEventListener(Event.COMPLETE, handleLoadLevel);
            _swfLoader.addFile("level");
            _swfLoader.addFile("minimap");
            _swfLoader.load();
        }

        private function handleLoadLevel(event: Event):void
        {
            _dbswfLoader = new DBSWFLoader();
            _dbswfLoader.addEventListener(Event.COMPLETE, handleLoadHero);
            _dbswfLoader.load("hero");
        }

        private function handleLoadHero(event: Event):void
        {
            Assets.factory = new StarlingFactory();
            Assets.factory.addEventListener(Event.COMPLETE, handleSWFConverted);
            Assets.factory.parseData(_dbswfLoader.file);
        }

        private function handleSWFConverted(event: Event):void
        {
            start();
        }
    }
}
