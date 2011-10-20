package
{
    import xface.XFace;

    import com.bit101.components.TextArea;

    import flash.events.MouseEvent;

    /**
     * @author eidiot
     */
    public class TextUnit
    {
        //======================================================================
        //  Class constants
        //======================================================================
        private static const STEP:Number = 10;
        //======================================================================
        //  Variables
        //======================================================================
        private var instance:TextArea;
        //======================================================================
        //  Public methods
        //======================================================================
        [Before]
        public function setUp():void
        {
            XFace.changeBackgroundColor(0xEEEFF0);

            instance = new TextArea();
            XFace.display(instance);

            XFace.addButton("Up", upHandler);
            XFace.newLineForControls();
            XFace.addButton("Left", leftHandler),
            XFace.addButton("Right", rightHandler);

            XFace.addButtonToBottom("Down", downHandler),
            XFace.addSpaceToBottom();
            XFace.addButtonToBottom("Left", leftHandler),
            XFace.addButtonToBottom("Right", rightHandler);
        }
        [Test]
        public function test():void
        {
            instance.text = "Select ui-unit methods from the right list. \n Enjoy!";
            instance.x = 100;
            instance.y = 100;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function upHandler(event:MouseEvent):void
        {
            instance.y -= STEP;
        }
        private function downHandler(event:MouseEvent):void
        {
            instance.y += STEP;
        }
        private function leftHandler(event:MouseEvent):void
        {
            instance.x -= STEP;
        }
        private function rightHandler(event:MouseEvent):void
        {
            instance.x += STEP;
        }
    }
}