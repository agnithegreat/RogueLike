/**
 * Created by desktop on 20.05.2015.
 */
package com.agnither.roguelike.model.room
{
    import com.agnither.roguelike.enums.CbTypes;
    import com.agnither.roguelike.enums.CollisionGroups;
    import com.agnither.roguelike.model.objects.GameObject;
    import com.agnither.roguelike.model.objects.Hero;

    import flash.utils.getTimer;

    import nape.callbacks.CbEvent;
    import nape.callbacks.InteractionCallback;
    import nape.callbacks.InteractionListener;
    import nape.callbacks.InteractionType;
    import nape.geom.Vec2;
    import nape.phys.Body;
    import nape.phys.BodyType;
    import nape.phys.Material;
    import nape.shape.Polygon;
    import nape.shape.Shape;
    import nape.space.Space;

    import starling.animation.IAnimatable;
    import starling.events.EventDispatcher;

    public class Room extends EventDispatcher implements IAnimatable
    {
        public static const left: int = 40;
        public static const right: int = 600;
        public static const up: int = 60;
        public static const down: int = 420;

        public static const tileWidth: int = 70;
        public static const tileHeight: int = 51;

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
            var wall: Body = new Body(BodyType.STATIC);
            for (var i:int = -1; i <= 8; i++)
            {
                for (var j:int = -1; j <= 7; j++)
                {
                    if (i == -1 || j == -1 || i == 8 || j == 7)
                    {
                        var x: int = left + i*tileWidth;
                        var y: int = up + j*tileHeight;
                        var shape: Shape = new Polygon(Polygon.rect(x, y, tileWidth, tileHeight), new Material(0, 0, 0));
                        var isDoor: Boolean = i == 4 || j == 3;
                        shape.filter.collisionGroup = isDoor ? CollisionGroups.DOOR : CollisionGroups.WALL;
                        shape.filter.collisionMask = isDoor ? ~CollisionGroups.HERO : ~0;
                        wall.shapes.add(shape);
                    }
                }
            }
            wall.space = _space;
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
