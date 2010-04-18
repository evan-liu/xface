package minimal
{
    import com.bit101.components.PushButton;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class PushButtonUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:DisplayObjectContainer;
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
            container.addChild(instance);
            instance.x = 10;
            instance.y = 10;
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
        [Test]
        public function toggle_is_true():void
        {
            instance.label = "Click me";
            instance.toggle = true;
            instance.selected = true;
        }
    }
}