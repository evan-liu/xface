package minimal
{
    import xface.XFace;

    import com.bit101.components.CheckBox;
    import com.bit101.components.PushButton;

    import flash.events.Event;
    /**
     * @author eidiot
     */
    public class PushButtonUnit
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:PushButton;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            instance = new PushButton();
            XFace.display(instance, 10, 30);
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        [Test]
        public function toggle_is_false():void
        {
            instance.label = "Click me";
            instance.toggle = false;
        }
        [Test(order=-1)]
        public function toggle_is_true():void
        {
            instance.label = "Click me";
            instance.toggle = true;
            instance.selected = true;
            XFace.addCheckBox("Toggle", toggleBox_changeHandler, true);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function toggleBox_changeHandler(event:Event):void
        {
            instance.selected = CheckBox(event.target).selected;
        }
    }
}