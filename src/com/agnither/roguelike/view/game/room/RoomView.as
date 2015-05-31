package com.agnither.roguelike.view.game.room
{
    import com.agnither.roguelike.Settings;
    import com.agnither.roguelike.enums.DirectionName;
    import com.agnither.roguelike.model.room.RoomState;
    import com.agnither.utils.gui.DistortedImage;
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.geom.Matrix;

    import flash.utils.Dictionary;

    import starling.display.Image;
    import starling.textures.RenderTexture;

    public class RoomView extends AbstractComponent
    {
        override protected function getManifest():Dictionary
        {
            var manifest: Dictionary = new Dictionary();
            manifest["assets.level::DoorMC"] = DoorView;
            return manifest;
        }

        private var _backTexture: RenderTexture;
        private var _back: Image;

        private var _roomState: RoomState;

        public function RoomView(room: RoomState)
        {
            _roomState = room;

            super();
        }

        override protected function initialize():void
        {
            createFromFlash("assets.level.Level" + _roomState.type + "MC", "level" + _roomState.type);
            getChild("physics").removeFromParent(true);

            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                getChild("door_" + direction.name).visible = _roomState.getDoorId(direction) != null;
            }

            _backTexture = new RenderTexture(Settings.ROOM_WIDTH, Settings.ROOM_HEIGHT);

            var floor: AbstractComponent = getChild("floor");
            _backTexture.draw(floor);
            removeChild(floor, true);

            for each (direction in DirectionName.DIRECTIONS)
            {
                var wall: AbstractComponent = getChild("wall_" + direction.name);
                var transform: Matrix = wall.transformationMatrix;
                wall.transformationMatrix = new Matrix();
                var renderTexture: RenderTexture = new RenderTexture(wall.width, wall.height);
                renderTexture.draw(wall);
                var distortImage: DistortedImage = new DistortedImage(renderTexture);
                distortImage.transformationMatrix = transform;
                distortImage.distort(Settings.getWallPoints(direction));
                _backTexture.draw(distortImage);
                removeChild(wall, true);
            }

            _back = new Image(_backTexture);
            addChildAt(_back, 0);
        }
    }
}
