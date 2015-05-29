/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.CbTypes;
    import com.agnither.roguelike.enums.DirectionName;
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
        public static const TO_ROOM: String = "to_room_GameController";

        private static const maxIterations: int = 500;

        private var _space: Space;

        private var _roomState: RoomState;
        public function get currentRoom():RoomState
        {
            return _roomState;
        }

        private var _wall: Body;

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

            _space.listeners.add(new InteractionListener(CbEvent.ONGOING, InteractionType.SENSOR, CbTypes.DOOR, CbTypes.HERO, handleDoorSensor));
        }

        public function setHero(hero: Hero):void
        {
            _hero = hero;
            _hero.body.space = _space;
        }

        public function setState(roomState: RoomState):void
        {
            _roomState = roomState;

            if (_wall != null)
            {
                _wall.space = null;
                _wall = null;
            }

            _wall = LevelToBody.create(_roomState);
            _wall.space = _space;

            dispatchEventWith(TO_ROOM, false, _roomState);
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

        private function handleDoorSensor(callback: InteractionCallback):void
        {
            var heroX: int = _hero.x - _wall.position.x;
            var heroY: int = _hero.y - _wall.position.y;

            var direction: Point = new Point();

            if (heroX < 0) direction.x = -1;
            else if (heroX > 640) direction.x = 1;

            if (heroY < 0) direction.y = -1;
            else if (heroY > 480) direction.y = 1;

            if (direction.length > 0)
            {
                var dir: DirectionName = DirectionName.getDirection(direction);
                dispatchEventWith(NEXT_ROOM, false, _roomState.getDoorId(dir));
            }
        }
    }
}
