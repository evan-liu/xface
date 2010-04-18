package
{
    import com.bit101.components.TextArea;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class TextUnit
    {
        //======================================================================
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:DisplayObjectContainer;
        //======================================================================
        //  Public methods
        //======================================================================
        [Test]
        public function test():void
        {
            var textArea:TextArea = new TextArea();
            container.addChild(textArea);
            textArea.text = "Select ui-unit methods from the right list. \n Enjoy!";
            textArea.x = 10;
            textArea.y = 10;
        }
    }
}