package xface.ui
{
    import xface.BaseRunner;
    import xface.UnitMethod;
    import xface.data.SuiteData;
    import xface.data.UnitData;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.errors.IllegalOperationError;
    /**
     * Abstract class for runner ui.
     * @author eidiot
     */
    public class AbstractRunnerUI extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>AbstractRunnerUI</code>.
         */
        public function AbstractRunnerUI(width:Number = 150)
        {
            super();
            uiWidth = width;
            addChild(contentContainer);
            addChild(uiContainer);
        }
        //======================================================================
        //  Variables
        //======================================================================
        /** @private */
        protected var runner:BaseRunner;
        /** @private */
        protected var uiWidth:Number;
        //======================================================================
        //  Properties
        //======================================================================
        /**
         * Container for ui-unit content when run the unit methods.
         */
        public const contentContainer:Sprite = new Sprite();
        /**
         * Container for unit-ui content to select the unit methods to run.
         */
        public const uiContainer:Sprite = new Sprite();
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Run the unit or suite.
         * @param unitOrSuite   Unit or Suite class like AsUnit 4 and FlexUnit 4.
         * @param unitFactory   Function to create the unit from class.
         *                      like <code>injector.instantiate</code> in Robotlegs.
         *                      Use it for more Dependency injection using [Inject]
         *                      in unit classes.
         */
        public function run(unitOrSuite:Class, unitFactory:Function = null):void
        {
            if (runner)
            {
                throw new IllegalOperationError("It can be runned only once.");
            }
            if (!stage)
            {
                throw new IllegalOperationError("Please add runner ui to stage first.");
            }
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            //--
            runner = new BaseRunner(contentContainer, unitFactory);
            var elements:Array = runner.parseElements(unitOrSuite);
            buildUI(elements);
            runFirst();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected function runFirst():void
        {
        }
        /** @private */
        protected function buildUI(elements:Array):void
        {
        }
        /** @private */
        protected function parseElementsToArray(elements:Array):Array
        {
            var result:Array = [];
            for each (var element:* in elements)
            {
                parseElementToArray(element, result);
            }
            return result;
        }
        /** @private */
        protected function parseElementToArray(element:*, target:Array):void
        {
            if (element is UnitData)
            {
                parseUnitToArray(element, target);
            }
            else if (element is SuiteData)
            {
                parseSuiteToArray(element, target);
            }
        }
        /** @private */
        protected function parseUnitToArray(unit:UnitData, target:Array):void
        {
            var testMethods:Array = unit.testMethods;
            var numMethods:int = testMethods.length;
            for each (var testMethod:UnitMethod in testMethods)
            {
                var label:String = " * " + unit.name;
                if (numMethods > 1 || testMethod.name != "test")
                {
                    label += " / " + testMethod.name;
                }
                addDataToArray(target, label, testMethod);
            }
        }
        /** @private */
        protected function addDataToArray(target:Array, label:String, value:* = null):void
        {
            var data:Object = {"label":label};
            if (value != null)
            {
                data.value = value;
            }
            target.push(data);
        }
        /** @private */
        protected function parseSuiteToArray(suite:SuiteData, target:Array):void
        {
            addDataToArray(target, "===== " + suite.name + " =====");
            for each (var element:* in suite.elements)
            {
                parseElementToArray(element, target);
            }

        }
    }
}