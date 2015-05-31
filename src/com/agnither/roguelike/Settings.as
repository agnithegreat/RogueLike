/**
 * Created by desktop on 31.05.2015.
 */
package com.agnither.roguelike
{
    import com.agnither.roguelike.enums.DirectionName;

    import flash.geom.Point;

    public class Settings
    {
        public static const ROOM_WIDTH: int = 1210;
        public static const ROOM_HEIGHT: int = 770;

        public static const WALL_WIDTH: int = 110;
        public static const WALL_HEIGHT: int = 110;

        public static const ROOM_POINTS: Array = [
            new Point(0, 0),
            new Point(ROOM_WIDTH, 0),
            new Point(ROOM_WIDTH, ROOM_HEIGHT),
            new Point(0, ROOM_HEIGHT),

            new Point(WALL_WIDTH, WALL_HEIGHT),
            new Point(ROOM_WIDTH-WALL_WIDTH, WALL_HEIGHT),
            new Point(ROOM_WIDTH-WALL_WIDTH, ROOM_HEIGHT-WALL_HEIGHT),
            new Point(WALL_WIDTH, ROOM_HEIGHT-WALL_HEIGHT)
        ];

        public static const WALL_POINTS: Object = {
            "up": [0, 1, 4, 5],
            "down": [7, 6, 3, 2],
            "left": [0, 4, 3, 7],
            "right": [5, 1, 6, 2]
        };

        public static function getWallPoints(direction: DirectionName):Array
        {
            var points: Array = [];
            var wallPoints: Array = WALL_POINTS[direction.name];
            for (var i:int = 0; i < 4; i++)
            {
                points.push(ROOM_POINTS[wallPoints[i]]);
            }
            return points;
        }
    }
}
