package
{
    import com.bit101.components.PushButton;
    import com.bit101.components.TextArea;
    import flash.events.MouseEvent;
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;


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
        //  Dependencies
        //======================================================================
        [Inject]
        public var container:ContentContainer;
        [Inject]
        public var controls:ControlContainer;
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
        	container.color = 0xEEEFF0;

        	instance = new TextArea();
            container.addChild(instance);

            controls.addToTop(createButton("Up", upHandler),
                              createButton("Left", leftHandler),
                              createButton("Right", rightHandler));
            controls.addToBottom(createButton("Down", downHandler), 
                              createButton("Left", leftHandler),
                              createButton("Right", rightHandler));
        }
        [Test]
        public function test():void
        {
            instance.text = "Select ui-unit methods from the right list. \n Enjoy!";
            instance.x = 100;
            instance.y = 100;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function createButton(label:String, handler:Function):PushButton
        {
        	return new PushButton(null, 0, 0, label, handler);
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