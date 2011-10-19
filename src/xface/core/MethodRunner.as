package xface.core
{
    import p2.reflect.ReflectionMember;
    import p2.reflect.ReflectionVariable;

    import xface.data.UnitData;
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;


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
         * @param container     <code>DemoContentContainer</code> to display the ui.
         * @param unitFactory   Function to instantiate the ui-unit case.
         */
        public function MethodRunner(contentContainer:ContentContainer,
                                   controlContainer:ControlContainer,
                                   unitFactory:Function = null)
        {
            this.contentContainer = contentContainer;
            this.controlContainer = controlContainer;
            if (unitFactory != null)
            {
                this.unitFactory = unitFactory;
            }
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
        //--
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
            var data:UnitData = runningMethod.unitData;
            //-- Create
            runningUnit = unitFactory(data.unitClass);
            //-- Inject
            var injectPoints:Array = data.reflection.getMembersByMetaData("Inject");
            for each (var point:ReflectionMember in injectPoints)
            {
                if (!(point is ReflectionVariable))
                {
                    continue;
                }
                var variable:ReflectionVariable = ReflectionVariable(point);
                switch (variable.type)
                {
                    case "flash.display::DisplayObjectContainer":
                    case "xface.ui::ContentContainer":
                       runningUnit[variable.name] = contentContainer;
                       break;
                    case "xface.ui::ControlContainer":
                       runningUnit[variable.name] = controlContainer;
                       break;
                    default:
                       break;
                }
            }
            //-- Setup
            for each (var beforeMethod:UnitMethod in data.beforeMethods)
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
        }
        /** @private */
        protected function createUnit(unitClass:Class):*
        {
            return new unitClass();
        }
    }
}