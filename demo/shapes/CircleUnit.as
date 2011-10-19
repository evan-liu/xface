package shapes
{
    import xface.XFace;

    import com.bit101.components.ComboBox;

    import flash.display.Shape;
    import flash.events.Event;
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
            XFace.display(shape, 110, 130);
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
            var colors:Array =
            [
                {label:"Red", value:0xFF0000},
                {label:"Greed", value:0x00FF00},
                {label:"Blue", value:0x0000FF},
            ];
            XFace.addComboBoxToTop("Select Color", colors, selectFillColorHandler);
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
        //======================================================================
        //  Event handlers
        //======================================================================
        private function selectFillColorHandler(event:Event):void
        {
            with (shape.graphics)
            {
                clear();
                beginFill(ComboBox(event.target).selectedItem.value);
                drawCircle(0, 0, 100);
                endFill();
            }
        }
    }
}