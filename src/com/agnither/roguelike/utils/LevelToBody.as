/**
 * Created by desktop on 22.05.2015.
 */
package com.agnither.roguelike.utils
{
    import com.agnither.roguelike.model.room.Room;

    import flash.display.BitmapData;
    import flash.display.Shape;

    import nape.phys.Body;

    public class LevelToBody
    {
        public static function create(data: Object):Body
        {
            var width: int = data["width"];
            var height: int = data["height"];

            var shape: Shape = new Shape();
            shape.graphics.beginFill(0xFFFFFF);
            shape.graphics.drawRect(0, 0, width, height);
            shape.graphics.drawRect(100, 0, 100, Room.up);
            shape.graphics.drawRect(Room.left, Room.up, Room.right-Room.left, Room.down-Room.up);

//            var tileWidth: int = data["tileWidth"];
//            var tileHeight: int = data["tileHeight"];

            var bitmapData: BitmapData = new BitmapData(width, height, true, 0);
            bitmapData.draw(shape);

            return BodyFromGraphic.create(bitmapData);
        }
    }
}
