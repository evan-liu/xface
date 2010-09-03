package shapes
{
    import xface.ui.ContentContainer;

    import flash.display.Shape;
    /**
     * @author eidiot
     */
    public class RectangleUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:ContentContainer;
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
            container.addChild(shape);
            shape.x = 10;
            shape.y = 10;
        }
        [After]
        public function tearDown():void
        {
            shape = null;
        }
        [Test]
        public function fill_color():void
        {
            container.color = 0x00FF00;
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
            container.color = 0x0000FF;
            with (shape.graphics)
            {
                lineStyle(0, 0xFF0000);
                drawRect(0, 0, 200, 100);
                endFill();
            }
        }
    }
}