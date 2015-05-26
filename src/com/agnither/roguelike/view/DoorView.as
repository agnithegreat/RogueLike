/**
 * Created by desktop on 26.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.utils.gui.components.AbstractComponent;

    public class DoorView extends AbstractComponent
    {
        public function DoorView()
        {
            super();
        }

        override protected function initialize():void
        {
            createFromFlash("assets.level.DoorMC", "level");
            getChild("shape").removeFromParent(true);
        }
    }
}
