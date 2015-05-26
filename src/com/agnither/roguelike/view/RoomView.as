/**
 * Created by desktop on 26.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.utils.Dictionary;

    public class RoomView extends AbstractComponent
    {
        override protected function getManifest():Dictionary
        {
            var manifest: Dictionary = new Dictionary();
            manifest["assets.level.DoorMC"] = DoorView;
            return manifest;
        }

        public function RoomView()
        {
            super();
        }

        override protected function initialize():void
        {
            createFromFlash("assets.level.LevelTestMC", "level");
            getChild("walls").removeFromParent(true);
        }
    }
}
