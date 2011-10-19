package shapes
{
    import xface.XFace;

    import flash.display.Shape;
    /**
     * @author eidiot
     */
    public class CircleUnit
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var shape:Shape;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            shape = new Shape();
            XFace.display(shape, 110, 110);
        }
        [After]
        public function tearDown():void
        {
            shape = null;
        }
        [Test]
        public function fill_color():void
        {
            with (shape.graphics)
            {
                beginFill(0xFF0000);
                drawCircle(0, 0, 100);
                endFill();
            }
        }
        [Test]
        public function only_rim():void
        {
            with (shape.graphics)
            {
                lineStyle(0, 0xFF0000);
                drawCircle(0, 0, 100);
                endFill();
            }
        }
    }
}