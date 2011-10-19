package xface
{
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;
    import xface.ui.MethodSelector;

    import com.bit101.components.CheckBox;
    import com.bit101.components.PushButton;

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.errors.IllegalOperationError;
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
        public static function addControlToTop(...controls):void
        {
            controlContainer.addToTop(controls);
        }
        public static function addControlToBottom(...controls):void
        {
            controlContainer.addToBottom(controls);
        }
        public static function addButtonToTop(label:String, handler:Function, width:Number = 50):void
        {
            controlContainer.addToTop(createButton(label, handler, width));
        }
        public static function addButtonToBottom(label:String, handler:Function, width:Number = 50):void
        {
            controlContainer.addToBottom(createButton(label, handler, width));
        }
        public static function addCheckBoxToTop(label:String, handler:Function, selected:Boolean = false):void
        {
            controlContainer.addToTop(createCheckBox(label, handler, selected));
        }
        public static function addCheckBoxToBottom(label:String, handler:Function, selected:Boolean = false):void
        {
            controlContainer.addToBottom(createCheckBox(label, handler, selected));
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
    }
}