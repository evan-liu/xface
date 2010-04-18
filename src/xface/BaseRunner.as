package xface
{
    import xface.data.SuiteData;
    import xface.data.UnitData;
    import p2.reflect.Reflection;
    import p2.reflect.ReflectionMember;
    import p2.reflect.ReflectionVariable;

    import xface.utils.isSuite;
    import xface.utils.isUnit;

    import flash.display.DisplayObjectContainer;
    /**
     * Base runner.
     * @author eidiot
     */
    public class BaseRunner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>Runner</code>.
         * @param container     <code>DisplayObjectContainer</code> to display the ui.
         * @param unitFactory   Function to instantiate the ui-unit case.
         */
        public function BaseRunner(container:DisplayObjectContainer,
                                   unitFactory:Function = null)
        {
            this.container = container;
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
        protected var container:DisplayObjectContainer;
        //--
        /** @private */
        protected var runningMethod:UnitMethod;
        /** @private */
        protected var runningUnit:*;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Parse elements from the unit or suite class.
         */
        public function parseElements(unitOrSuite:Class):Array
        {
            var reflection:Reflection = Reflection.create(unitOrSuite);
            if (isUnit(reflection))
            {
                return [new UnitData(unitOrSuite)];
            }
            if (isSuite(reflection))
            {
                return new SuiteData(unitOrSuite).elements;
            }
            return [];
        }
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
                if (variable.type == "flash.display::DisplayObjectContainer")
                {
                    runningUnit[variable.name] = container;
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
            while (container.numChildren > 0)
            {
                container.removeChildAt(0);
            }
        }
        /** @private */
        protected function createUnit(unitClass:Class):*
        {
            return new unitClass();
        }
    }
}