package xface.core
{
    import p2.reflect.ReflectionMember;
    import p2.reflect.ReflectionVariable;

    import xface.data.RunnerData;
    import xface.data.UnitData;
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;


    /**
     * Base runner.
     * @author eidiot
     */
    public class MethodRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>Runner</code>.
         * @param contentContainer  <code>ContentContainer</code> to display the demo target.
         * @param controlContainer  <code>ControlContainer</code> to display demo controls.
         * @param runnerData        Data for the method runner.
         * @param unitFactory       Function to instantiate the ui-unit case.
         */
        public function MethodRunner(contentContainer:ContentContainer,
                                     controlContainer:ControlContainer,
                                     runnerData:RunnerData,
                                     unitFactory:Function = null)
        {
            this.contentContainer = contentContainer;
            this.controlContainer = controlContainer;
            this.runnerData = runnerData;
            if (unitFactory != null)
            {
                this.unitFactory = unitFactory;
            }

            runnerData.mapInjection(contentContainer, DisplayObjectContainer, Sprite);
            runnerData.mapInjection(controlContainer);
        }
        //======================================================================
        //  Variables
        //======================================================================
        /** @private */
        protected var unitFactory:Function = createUnit;
        /** @private */
        protected var contentContainer:ContentContainer;
        /** @private */
        protected var controlContainer:ControlContainer;
        /** @private */
        protected var runnerData:RunnerData;

        /** @private */
        protected var runningMethod:UnitMethod;
        /** @private */
        protected var runningUnit:*;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Run a unit method.
         */
        public function runMethod(method:UnitMethod):void
        {
            tearDownPast();
            setUpNext(method);
            runningUnit[method.name]();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected function setUpNext(method:UnitMethod):void
        {
            runningMethod = method;
            var unitData:UnitData = runningMethod.unitData;
            //-- Create
            runningUnit = unitFactory(unitData.unitClass);
            //-- Inject
            var injectPoints:Array = unitData.reflection.getMembersByMetaData("Inject");
            for each (var point:ReflectionMember in injectPoints)
            {
                var variable:ReflectionVariable = point as ReflectionVariable;
                if (variable && (variable.type in runnerData.injectionMap))
                {
                   runningUnit[variable.name] = runnerData.injectionMap[variable.type];
                }
            }
            //-- Setup
            for each (var setUpMethod:Function in runnerData.setUpMethods)
            {
                setUpMethod();
            }
            for each (var beforeMethod:UnitMethod in unitData.beforeMethods)
            {
                runningUnit[beforeMethod.name]();
            }
        }
        /** @private */
        protected function tearDownPast():void
        {
            if (!runningMethod)
            {
                return;
            }
            var data:UnitData = runningMethod.unitData;
            for each (var afterMethod:UnitMethod in data.afterMethods)
            {
                runningUnit[afterMethod.name]();
            }
            runningMethod = null;
            runningUnit = null;
            contentContainer.clear();
            controlContainer.clear();
            for each (var tearDownMethod:Function in runnerData.tearDownMethods)
            {
                tearDownMethod();
            }
        }
        /** @private */
        protected function createUnit(unitClass:Class):*
        {
            return new unitClass();
        }
    }
}