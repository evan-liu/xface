package shapes
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    /**
     * @author eidiot
     */
    public class CircleUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:DisplayObjectContainer;
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
            shape.x = 110;
            shape.y = 110;
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