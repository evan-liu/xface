package minimal
{
    import com.bit101.components.Label;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class LabelUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:DisplayObjectContainer;
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:Label;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            instance = new Label();
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
        public function test():void
        {
            instance.text = "This is a label";
        }
    }
}