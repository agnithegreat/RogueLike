/**
 * Created by desktop on 22.05.2015.
 */
package com.agnither.roguelike.enums
{
    public class CollisionGroups
    {
        public static const GAME_OBJECT: int = 1;
        public static const PERSONAGE: int = 2 | GAME_OBJECT;
        public static const HERO: int = 4 | PERSONAGE;

        public static const WALL: int = 8;
        public static const DOOR: int = 16;
    }
}
