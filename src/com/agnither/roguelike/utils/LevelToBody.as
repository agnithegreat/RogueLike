/**
 * Created by desktop on 22.05.2015.
 */
package com.agnither.roguelike.utils
{
    import com.agnither.roguelike.enums.CollisionGroups;
    import com.agnither.roguelike.enums.DirectionName;
    import com.agnither.roguelike.model.room.RoomState;
    import com.agnither.utils.gui.components.AbstractComponent;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import nape.phys.Body;
    import nape.phys.BodyType;
    import nape.phys.Material;
    import nape.shape.Polygon;

    public class LevelToBody
    {
        public static function create(room: RoomState):Body
        {
            var definition: String = "assets.level.LevelTest" + room.type + "MC";
            var level: DisplayObjectContainer = AbstractComponent.getResource(definition);
            var walls: Sprite = level["walls"];

            var body: Body = new Body(BodyType.STATIC);
            body.position.x = room.size.x * 640;
            body.position.y = room.size.y * 480;

            var wallsAmount: int = walls.numChildren;
            for (var i:int = 0; i < wallsAmount; i++)
            {
                var wallPolygon: Polygon = getPolygon(walls.getChildAt(i), level);
                wallPolygon.filter.collisionGroup = CollisionGroups.WALL;
                wallPolygon.filter.collisionMask = ~0;
                wallPolygon.body = body;
            }

            for each (var direction: DirectionName in DirectionName.DIRECTIONS)
            {
                var door: Sprite = level[direction.name];
                if (door != null)
                {
                    var doorPolygon: Polygon = getPolygon(door["shape"], level);
                    doorPolygon.filter.collisionGroup = CollisionGroups.WALL;
                    doorPolygon.filter.collisionMask = room.getDoorId(direction) ? ~CollisionGroups.HERO : ~0;
                    doorPolygon.body = body;
                }
            }

            return body;
        }

        private static function getPolygon(shape: DisplayObject, level: DisplayObjectContainer):Polygon
        {
            var rect: Rectangle = shape.getRect(level);
            return new Polygon(Polygon.rect(rect.x, rect.y, rect.width, rect.height), new Material(0, 0, 0));
        }
    }
}
