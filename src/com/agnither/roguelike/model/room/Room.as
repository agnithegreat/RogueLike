/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.CbTypes;
    import com.agnither.roguelike.model.objects.GameObject;
    import com.agnither.roguelike.model.objects.Hero;
    import com.agnither.roguelike.utils.LevelToBody;

    import flash.geom.Point;

    import flash.utils.getTimer;

    import nape.callbacks.CbEvent;
    import nape.callbacks.InteractionCallback;
    import nape.callbacks.InteractionListener;
    import nape.callbacks.InteractionType;

    import nape.geom.Vec2;
    import nape.phys.Body;
    import nape.space.Space;

    import starling.animation.IAnimatable;
    import starling.events.EventDispatcher;

    public class Room extends EventDispatcher implements IAnimatable
    {
        public static const NEXT_ROOM: String = "next_room_GameController";

        private static const maxIterations: int = 500;

        private var _space: Space;

        private var _roomState: RoomState;

        private var _hero: Hero;
        public function get hero():Hero
        {
            return _hero;
        }

        public function Room()
        {
            initRoomPhysics();
        }

        private function initRoomPhysics():void
        {
            _space = new Space(new Vec2());
            var wall: Body = LevelToBody.create({});
            wall.space = _space;

            _space.listeners.add(new InteractionListener(CbEvent.BEGIN, InteractionType.SENSOR, CbTypes.DOOR, CbTypes.HERO, handleEnterDoorSensor));
        }

        private function handleEnterDoorSensor(callback: InteractionCallback):void
        {
            var direction: Point = new Point();
            direction.x = Math.round((_hero.x - 320)/320);
            direction.y = Math.round((_hero.y - 240)/240);
            dispatchEventWith(NEXT_ROOM, false, direction);
        }

        public function setHero(hero: Hero):void
        {
            _hero = hero;
            _hero.body.space = _space;
        }

        public function setState(roomState: RoomState):void
        {
            _roomState = roomState;
        }

        public function advanceTime(time: Number):void
        {
            var currentUpdate: int = getTimer();
            if (_roomState.lastUpdate)
            {
                var deltaTime: Number = (currentUpdate - _roomState.lastUpdate) * 0.001;
                var iterations: int = Math.max(1, Math.min(deltaTime / time, maxIterations));
                for (var i:int = 0; i < iterations; i++)
                {
                    var change: Number = deltaTime < time ? deltaTime : time;
                    deltaTime -= change;
                    update(change);
                }
            }
            _roomState.lastUpdate = currentUpdate;
        }

        public function update(time: Number):void
        {
            _space.step(time);

            _hero.advanceTime(time);

            for each (var gameObject:GameObject in _roomState.gameObjects)
            {
                gameObject.advanceTime(time);
            }
        }
    }
}
