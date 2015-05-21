/**
 * Created by desktop on 15.05.2015.
 */
package com.agnither.roguelike
{
    import com.agnither.roguelike.controller.AppController;

    import starling.display.Sprite;

    public class App extends Sprite implements IStartable
    {
        private var _appController: AppController;

        public function start():void
        {
            _appController = new AppController();
            _appController.init(this);
        }
    }
}
