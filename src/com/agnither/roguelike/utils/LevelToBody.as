/**
 * Created by desktop on 22.05.2015.
 */
package com.agnither.roguelike.utils
{
    import com.agnither.roguelike.enums.CbTypes;
    import com.agnither.roguelike.enums.CollisionGroups;

    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.utils.getDefinitionByName;

    import nape.phys.Body;
    import nape.phys.Material;
    import nape.shape.Polygon;

    public class LevelToBody
    {
        public static function create(data: Object):Body
        {
            var ResourceClass: Class = getDefinitionByName("assets.level.LevelTestMC") as Class;
            var level: MovieClip = new ResourceClass();
            var walls: Sprite = level["walls"];

            var bitmapData: BitmapData = new BitmapData(walls.width, walls.height, true, 0);
            bitmapData.draw(walls);

            var body: Body = BodyFromGraphic.create(bitmapData);

            for (var i:int = 1; i <= 4; i++)
            {
                var door: Sprite = level["door"+i];
                if (door != null)
                {
                    var doorPolygon: Polygon = getPolygon(door["shape"], level);
                    doorPolygon.filter.collisionGroup = CollisionGroups.DOOR;
                    doorPolygon.filter.collisionMask = ~CollisionGroups.HERO;
                    doorPolygon.body = body;

                    var sensorPolygon: Polygon = getPolygon(door["sensor"], level);
                    sensorPolygon.filter.collisionGroup = CollisionGroups.DOOR;
                    sensorPolygon.cbTypes.add(CbTypes.DOOR);
                    sensorPolygon.sensorEnabled = true;
                    sensorPolygon.body = body;
                }
            }

            return body;
        }

        private static function getPolygon(shape: Sprite, level: MovieClip):Polygon
        {
            var rect: Rectangle = shape.getRect(level);
            return new Polygon(Polygon.rect(rect.x, rect.y, rect.width, rect.height), new Material(0, 0, 0));
        }
    }
}
