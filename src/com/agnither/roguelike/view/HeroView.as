/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.view
{
    import com.agnither.roguelike.Assets;
    import com.agnither.roguelike.model.objects.GameObject;
    import com.agnither.roguelike.model.objects.Hero;

    import dragonBones.Armature;
    import dragonBones.animation.WorldClock;

    import starling.display.Sprite;
    import starling.events.EnterFrameEvent;
    import starling.events.Event;

    public class HeroView extends Sprite
    {
        private var _hero: Hero;

        private var _armature: Armature;

        public function HeroView(hero: Hero)
        {
            _armature = Assets.factory.buildArmature("hero");
            addChild(_armature.display as Sprite);
            _armature.animation.gotoAndPlay("default");
            WorldClock.clock.add(_armature);

            addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);

            _hero = hero;
            _hero.addEventListener(GameObject.UPDATE, handleUpdate);
            handleUpdate(null);
        }

        private function onEnterFrameHandler(e: EnterFrameEvent):void {
            WorldClock.clock.advanceTime(-1);
        }

        private function handleUpdate(e: Event):void
        {
            x = Math.round(_hero.x);
            y = Math.round(_hero.y);

            var movX: int = _hero.movementX;
            var movY: int = _hero.movementY;
            if (movX != 0)
            {
                _armature.animation.gotoAndStop("walk", 0, 0);
                _armature.display.scaleX = movX > 0 ? 1 : -1;
            } else if (movY != 0) {
                _armature.display.scaleX = 1;
                if (movY > 0)
                {
                    _armature.animation.gotoAndStop("down", 0, 0);
                } else {
                    _armature.animation.gotoAndStop("up", 0, 0);
                }
            } else {
                _armature.animation.gotoAndStop("idle", 0, 0);
            }
        }
    }
}
