package xface.ui {
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
        public function AbstractRunnerUI()
        {
            super();
            addChild(contentContainer);
            addChild(uiContainer);
        }
        //======================================================================
        //  Variables
        //======================================================================
        /** @private */
        protected var runner:BaseRunner;
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
            var dataList:Array = [];
            for each (var element:* in elements)
            {
                parseElementToData(element, dataList);
            }
            buildUI(dataList);
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
        protected function buildUI(dataList:Array):void
        {
        }
        /** @private */
        protected function parseElementToData(element:*, dataList:Array):void
        {
            if (element is UnitData)
            {
                parseUnitToData(element, dataList);
            }
            else if (element is SuiteData)
            {
                parseSuiteToData(element, dataList);
            }
        }
        /** @private */
        protected function parseUnitToData(unit:UnitData, dataList:Array):void
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
                addData(dataList, label, testMethod);
            }
        }
        /** @private */
        protected function addData(dataList:Array, label:String, value:* = null):void
        {
            var data:Object = {"label":label};
            if (value != null)
            {
                data.value = value;
            }
            dataList.push(data);
        }
        /** @private */
        protected function parseSuiteToData(suite:SuiteData, dataList:Array):void
        {
            addData(dataList, "===== " + suite.name + " =====");
            for each (var element:* in suite.elements)
            {
                parseElementToData(element, dataList);
            }

        }
    }
}