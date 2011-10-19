package
{
    import xface.XFace;

    import flash.display.Sprite;

    [SWF(width="550", height="400", backgroundColor="0xFFFFFF", frameRate="30")]

    /**
     * @author eidiot
     */
    public class DemoUIUnitRunner extends Sprite
    {
        public function DemoUIUnitRunner()
        {
            super();
            XFace.run(this, AllUnits);
        }
    }
}