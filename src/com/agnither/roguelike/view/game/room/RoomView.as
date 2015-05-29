package com.agnither.roguelike.view.game.room
{
    import com.agnither.roguelike.enums.DirectionName;
    import com.agnither.roguelike.model.room.RoomState;
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

        private var _roomState: RoomState;

        public function RoomView(room: RoomState)
        {
            _roomState = room;

            super();
        }

        override protected function initialize():void
        {
            createFromFlash("assets.level.LevelTest" + _roomState.type + "MC", "level" + _roomState.type);
            getChild("walls").removeFromParent(true);

            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                getChild(direction.name).visible = _roomState.getDoorId(direction) != null;
            }
        }
    }
}