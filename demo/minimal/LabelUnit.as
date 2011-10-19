package minimal
{
    import xface.XFace;

    import com.bit101.components.Label;
    /**
     * @author eidiot
     */
    public class LabelUnit
    {
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
            XFace.display(instance, 10, 10);
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