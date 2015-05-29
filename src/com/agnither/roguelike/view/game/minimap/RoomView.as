/**
 * Created by desktop on 29.05.2015.
 */
package com.agnither.roguelike.view.game.minimap
{
    import com.agnither.roguelike.enums.DirectionName;
    import com.agnither.roguelike.model.room.RoomState;
    import com.agnither.utils.gui.components.AbstractComponent;

    public class RoomView extends AbstractComponent
    {
        private var _room: RoomState;

        public function RoomView(room: RoomState)
        {
            _room = room;

            super();
        }

        override protected function initialize():void
        {
            createFromFlash("assets.map.RoomMC", "minimap");

            x = _room.size.x * 64;
            y = _room.size.y * 48;

            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                getChild(direction.name).visible = _room.getDoorId(direction) != null;
            }

            update();
        }

        public function update():void
        {
            visible = _room.visited;
        }
    }
}
