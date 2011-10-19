package minimal
{
    import xface.XFace;

    import com.bit101.components.Label;
    import com.bit101.components.RadioButton;

    import flash.events.MouseEvent;
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
            XFace.display(instance, 10, 30);

            XFace.addLabel("Label Text: ");
            XFace.addRadioButton("ActionScript", g1RadioButton_clickHandler, true, "g1");
            XFace.addRadioButton("JavaScript", g1RadioButton_clickHandler, false, "g1");

            XFace.addLabelToBottom("Y: ");
            XFace.addRadioButtonToBottom("30", g2RadioButton_clickHandler, true, "g2");
            XFace.addRadioButtonToBottom("50", g2RadioButton_clickHandler, false, "g2");
        }
        [After]
        public function tearDown():void
        {
            instance = null;
        }
        [Test]
        public function test():void
        {
            instance.text = "ActionScript";
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function g1RadioButton_clickHandler(event:MouseEvent):void
        {
            instance.text = RadioButton(event.target).label;
        }
        private function g2RadioButton_clickHandler(event:MouseEvent):void
        {
            instance.y = Number(RadioButton(event.target).label);
        }
    }
}