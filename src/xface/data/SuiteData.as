package xface.data
{
    import xface.utils.removePostfix;
    import p2.reflect.Reflection;
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionVariable;

    import xface.utils.isSuite;
    import xface.utils.isUnit;

    import flash.utils.getDefinitionByName;
    /**
     * Suite data.
     * @author eidiot
     */
    public class SuiteData
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>SuiteData</code>.
         */
        public function SuiteData(suiteClass:Class)
        {
            var suiteReflection:Reflection = Reflection.create(suiteClass);
            //-- Name
            var metadata:ReflectionMetaData = suiteReflection.getMetaDataByName("Suite");
            _name = metadata.getValueFor("label");
            if (!_name)
            {
                _name = suiteReflection.name;
                if (_name.indexOf("::") != -1)
                {
                    _name = _name.split("::")[1];
                }
                _name = removePostfix(_name, "Suite");
            }
            //-- Units
            for each (var variable:ReflectionVariable in suiteReflection.variables)
            {
                var variableClass:Class = Class(getDefinitionByName(variable.type));
                var variableReflection:Reflection = Reflection.create(variableClass);
                if (isUnit(variableReflection))
                {
                    _elements.push(new UnitData(variableClass));
                }
                else if (isSuite(variableReflection))
                {
                    _elements.push(new SuiteData(variableClass));
                }
            }
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the suite. It's name of the suite class.
         * Use <code>[Suite(label="anotherValue")]</code> to set it to another value.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  elements
        //------------------------------
        private var _elements:Array = [];
        /**
         * Elements (units or other suites) in the suite.
         */
        public function get elements():Array
        {
            return _elements.concat();
        }
    }
}