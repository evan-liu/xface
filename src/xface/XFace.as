package xface
{
    import xface.core.MethodRunner;
    import xface.data.RunnerData;
    import xface.data.SuiteData;
    import xface.data.UnitData;
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
    import flash.display.Graphics;
    import flash.display.Sprite;
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

        private static var runnerData:RunnerData = new RunnerData();
        private static var methodRunner:MethodRunner;
        //======================================================================
        //  Class properties
        //======================================================================
        /**
         * Container to add demo contents.
         */
        public static function get container():Sprite
        {
            return contentContainer;
        }
        //======================================================================
        //  Class public methods
        //======================================================================
        /**
         * Set postfixs to be removed in the test unit names.
         */
        public static function setUnitPostfix(...postfixes):void
        {
            UnitData.setPostfix(postfixes);
        }
        /**
         * Set postfixs to be removed in the test suite names.
         */
        public static function setSuitePostfix(...postfixes):void
        {
            SuiteData.setPostfix(postfixes);
        }
        /**
         * Set factory method to create units.
         * This method must accept an Class parameter and retun its one instance.
         */
        public static function setUnitFactory(unitFactory:Function):void
        {
            runnerData.unitFactory = unitFactory;
        }
        /**
         * Add methods to run before every unit method.
         */
        public static function addSetUpMethods(...methods):void
        {
            runnerData.addSetUpMethods(methods);
        }
        /**
         * Add methods to run after every unit method.
         */
        public static function addTearDownMethods(...methods):void
        {
            runnerData.addTearDownMethods(methods);
        }
        /**
         * Map an injection point for [Inject] metadata in units.
         */
        public static function mapInjection(instance:*, ...types):void
        {
            runnerData.mapInjection(instance, types);
        }
        /**
         * Get and mapped injection instance mapInjection() method.
         */
        public static function getInjection(type:Class):*
        {
            return runnerData.getInjection(type);
        }
        /**
         * Set title of the selector window.
         */
        public static function setSelectorTitle(title:String):void
        {
            methodSelector.title = title;
        }
        /**
         * Run view unit demos.
         *
         * @param container         Root of the demo application.
         * @param runTarget         Run target which can be Suite/Unit class or an Array.
         * @param unitFactory       Factory method to create demo units.
         * @param selectorWidth     Width of the methods selector tree.
         * @param openAllNode       If open all node of the methods selector tree.
         */
        public static function run(container:DisplayObjectContainer, runTarget:*,
                                   selectorWidth:Number = 150,
                                   openAllNode:Boolean = true,
                                   selectorTitle:String = null):void
        {
            if (!container.stage)
            {
                throw new IllegalOperationError("Add container to stage before running!");
            }
            container.addChild(contentContainer);
            container.addChild(controlContainer);
            container.addChild(methodSelector);

            methodRunner = new MethodRunner(contentContainer, controlContainer, runnerData);
            methodSelector.fill(runTarget, methodRunner, selectorWidth, openAllNode, selectorTitle);
        }
        /**
         * Minimize the selector window.
         */
        public static function minimizeSelector():void
        {
            methodSelector.minimized = true;
        }
        /**
         * Display the demo target.
         */
        public static function display(target:DisplayObject, x:Number = 0, y:Number = 0,
                                       drawCross:Boolean = false, crossLength:int = 100,
                                       crossColor:uint = 0x999999, crossAlpha:Number = 1):void
        {
            contentContainer.addChild(target);
            target.x = x;
            target.y = y;

            if (drawCross)
            {
                contentContainer.drawCross(x, y, crossLength, crossColor, crossAlpha);
            }
        }
        public static function drawCross(x:Number, y:Number, crossLength:int = 100,
                                         crossColor:uint = 0x999999, crossAlpha:Number = 1):void
        {
            contentContainer.drawCross(x, y, crossLength, crossColor, crossAlpha);
        }
        public static function changeBackgroundColor(color:uint):void
        {
            contentContainer.color = color;
        }
        public static function addControl(...controls):DisplayObject
        {
            return controlContainer.addToTop(controls);
        }
        public static function addLabel(text:String):Label
        {
            return controlContainer.addToTop(new Label(null, 0, 0, text)) as Label;
        }
        public static function addButton(label:String, handler:Function, width:Number = 50):PushButton
        {
            return controlContainer.addToTop(createButton(label, handler, width)) as PushButton;
        }
        public static function addCheckBox(label:String, handler:Function, selected:Boolean = false):CheckBox
        {
            return controlContainer.addToTop(createCheckBox(label, handler, selected)) as CheckBox;
        }
        public static function addRadioButton(label:String, handler:Function, selected:Boolean = false,
                                                   groupName:String = "defaultRadioGroup"):RadioButton
        {
            return controlContainer.addToTop(createRadioButton(label, handler, selected, groupName)) as RadioButton;
        }
        public static function addComboBox(defaultLabel:String, items:Array, handler:Function):ComboBox
        {
            return controlContainer.addToTop(createComboBox(defaultLabel, items, handler)) as ComboBox;
        }
        public static function addControlToBottom(...controls):DisplayObject
        {
            return controlContainer.addToBottom(controls);
        }
        public static function addLabelToBottom(text:String):Label
        {
            return controlContainer.addToBottom(new Label(null, 0, 0, text)) as Label;
        }
        public static function addButtonToBottom(label:String, handler:Function, width:Number = 50):PushButton
        {
            return controlContainer.addToBottom(createButton(label, handler, width)) as PushButton;
        }
        public static function addCheckBoxToBottom(label:String, handler:Function, selected:Boolean = false):CheckBox
        {
            return controlContainer.addToBottom(createCheckBox(label, handler, selected)) as CheckBox;
        }
        public static function addRadioButtonToBottom(label:String, handler:Function, selected:Boolean = false,
                                                      groupName:String = "defaultRadioGroup"):RadioButton
        {
            return controlContainer.addToBottom(createRadioButton(label, handler, selected, groupName)) as RadioButton;
        }
        public static function addComboBoxToBottom(defaultLabel:String, items:Array, handler:Function):ComboBox
        {
            return controlContainer.addToBottom(createComboBox(defaultLabel, items, handler)) as ComboBox;
        }
        public static function addSpace(value:Number = 10):void
        {
            controlContainer.addSpace(value);
        }
        public static function addSpaceToBottom(value:Number = 10):void
        {
            controlContainer.addSpaceToBottom(value);
        }
        public static function newLineForControls():void
        {
            controlContainer.newLineForTopControls();
        }
        public static function newLineForBottomControls():void
        {
            controlContainer.newLineForBottomControls();
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