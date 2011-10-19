package shapes
{
    import xface.XFace;

    import flash.display.Shape;

    /**
     * @author eidiot
     */
    public class RectangleUnit
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
            XFace.display(shape, 10, 10);
        }
        [After]
        public function tearDown():void
        {
            shape = null;
        }
        [Test]
        public function fill_color():void
        {
            XFace.changeBackgroundColor(0x00FF00);
            with (shape.graphics)
            {
                beginFill(0xFF0000);
                drawRect(0, 0, 200, 100);
                endFill();
            }
        }
        [Test]
        public function only_rim():void
        {
            XFace.changeBackgroundColor(0x0000FF);
            with (shape.graphics)
            {
                lineStyle(0, 0xFF0000);
                drawRect(0, 0, 200, 100);
                endFill();
            }
        }
    }
}