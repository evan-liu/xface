package xface
{
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;
    import xface.ui.MethodSelector;

    import com.bit101.components.CheckBox;
    import com.bit101.components.ComboBox;
    import com.bit101.components.Label;
    import com.bit101.components.PushButton;
    import com.bit101.components.RadioButton;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    public class XFace
    {
        //======================================================================
        //  Class variables
        //======================================================================
        private static var contentContainer:ContentContainer = new ContentContainer();
        private static var controlContainer:ControlContainer = new ControlContainer();
        private static var methodSelector:MethodSelector = new MethodSelector();

        private static var methodRunner:MethodRunner;
        //======================================================================
        //  Class public methods
        //======================================================================
        public static function run(container:DisplayObjectContainer, runTarget:*,
                                   unitFactory:Function = null,
                                   selectorWidth:Number = 150,
                                   openAllNode:Boolean = true):void
        {
            if (!container.stage)
            {
                throw new IllegalOperationError("Add container to stage before running!");
            }
            container.addChild(contentContainer);
            container.addChild(controlContainer);
            container.addChild(methodSelector);

            methodRunner = new MethodRunner(contentContainer, controlContainer, unitFactory);
            methodSelector.fill(runTarget, methodRunner, selectorWidth, openAllNode);
        }
        public static function display(target:DisplayObject, x:Number = 0, y:Number = 0):void
        {
            contentContainer.addChild(target);
            target.x = x;
            target.y = y;
        }
        public static function changeBackgroundColor(color:uint):void
        {
            contentContainer.color = color;
        }
        public static function addControlToTop(...controls):DisplayObject
        {
            return controlContainer.addToTop(controls);
        }
        public static function addControlToBottom(...controls):DisplayObject
        {
            return controlContainer.addToBottom(controls);
        }
        public static function addLabelToTop(text:String):Label
        {
            return controlContainer.addToTop(new Label(null, 0, 0, text)) as Label;
        }
        public static function addLabelToBottom(text:String):Label
        {
            return controlContainer.addToBottom(new Label(null, 0, 0, text)) as Label;
        }
        public static function addButtonToTop(label:String, handler:Function, width:Number = 50):PushButton
        {
            return controlContainer.addToTop(createButton(label, handler, width)) as PushButton;
        }
        public static function addButtonToBottom(label:String, handler:Function, width:Number = 50):PushButton
        {
            return controlContainer.addToBottom(createButton(label, handler, width)) as PushButton;
        }
        public static function addCheckBoxToTop(label:String, handler:Function, selected:Boolean = false):CheckBox
        {
            return controlContainer.addToTop(createCheckBox(label, handler, selected)) as CheckBox;
        }
        public static function addCheckBoxToBottom(label:String, handler:Function, selected:Boolean = false):CheckBox
        {
            return controlContainer.addToBottom(createCheckBox(label, handler, selected)) as CheckBox;
        }
        public static function addRadioButtonToTop(label:String, handler:Function, selected:Boolean = false,
                                                   groupName:String = "defaultRadioGroup"):RadioButton
        {
            return controlContainer.addToTop(createRadioButton(label, handler, selected, groupName)) as RadioButton;
        }
        public static function addRadioButtonToBottom(label:String, handler:Function, selected:Boolean = false,
                                                      groupName:String = "defaultRadioGroup"):RadioButton
        {
            return controlContainer.addToBottom(createRadioButton(label, handler, selected, groupName)) as RadioButton;
        }
        public static function addComboBoxToTop(defaultLabel:String, items:Array, handler:Function):ComboBox
        {
            return controlContainer.addToTop(createComboBox(defaultLabel, items, handler)) as ComboBox;
        }
        public static function addComboBoxToBottom(defaultLabel:String, items:Array, handler:Function):ComboBox
        {
            return controlContainer.addToBottom(createComboBox(defaultLabel, items, handler)) as ComboBox;
        }
        //======================================================================
        //  Class private methods
        //======================================================================
        private static function createButton(label:String, handler:Function, width:Number):PushButton
        {
            var result:PushButton = new PushButton(null, 0, 0, label, handler);
            result.width = width;
            result.draw();
            return result;
        }
        private static function createCheckBox(label:String, handler:Function, selected:Boolean):CheckBox
        {
            var result:CheckBox = new CheckBox(null, 0, 0, label, handler);
            result.selected = selected;
            return result;
        }
        private static function createRadioButton(label:String, handler:Function, selected:Boolean, groupName:String):RadioButton
        {
            var result:RadioButton = new RadioButton(null, 0, 0, label, selected, handler);
            result.groupName = groupName;
            return result;
        }
        private static function createComboBox(defaultLabel:String, items:Array, handler:Function):ComboBox
        {
            var result:ComboBox = new ComboBox(null, 0, 0, defaultLabel, items);
            result.addEventListener(Event.SELECT, handler);
            return result;
        }
    }
}