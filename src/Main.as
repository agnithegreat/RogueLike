/**
 * Created by desktop on 15.05.2015.
 */
package
{
    import com.agnither.roguelike.App;

    [SWF (frameRate = 60, width = 1210, height = 770)]
    public class Main extends StarlingMainBase
    {
        public function Main()
        {
            super(App);
        }

        override protected function initializeStarling():void
        {
            super.initializeStarling();

            showStats = true;
        }
    }
}
