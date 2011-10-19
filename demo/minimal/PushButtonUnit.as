package minimal
{
    import xface.XFace;

    import com.bit101.components.PushButton;
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
            XFace.display(instance, 10, 10);
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