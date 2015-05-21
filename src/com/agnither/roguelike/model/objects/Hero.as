/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.objects
{
    import com.agnither.roguelike.enums.CbTypes;
    import com.agnither.roguelike.enums.CollisionGroups;
    import com.agnither.utils.KeyLogger;

    import flash.ui.Keyboard;

    public class Hero extends Personage
    {
        public function Hero()
        {
            super();

            _shape.filter.collisionGroup = CollisionGroups.HERO;
            _shape.filter.collisionMask = ~CollisionGroups.DOOR;
            _shape.cbTypes.add(CbTypes.HERO);
        }

        private function control():void
        {
            var left: Boolean = KeyLogger.getKey(Keyboard.A);
            var right: Boolean = KeyLogger.getKey(Keyboard.D);
            var up: Boolean = KeyLogger.getKey(Keyboard.W);
            var down: Boolean = KeyLogger.getKey(Keyboard.S);
            var dx: int = int(right) - int(left);
            var dy: int = int(down) - int(up);
            if (dx == 0 && dy == 0)
            {
                stop();
            } else {
                rotate(Math.atan2(dy, dx));
                move(1);
            }
        }

        override public function advanceTime(time: Number):void
        {
            control();

            super.advanceTime(time);
        }
    }
}
