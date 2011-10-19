package xface.utils
{
    import flash.utils.Dictionary;
    import p2.reflect.Reflection;
    import xface.core.UnitMethod;
    import xface.data.SuiteData;
    import xface.data.UnitData;


    public class DataParser
    {
        //======================================================================
        //  Variables
        //======================================================================
        public var methodMap:Dictionary = new Dictionary();
        public var firstMethodKey:String;
        //======================================================================
        //  Public methods
        //======================================================================
        public function parse(target:*):XML
        {
            var result:XML = <node />;
            for each (var element:* in parseElements(target))
            {
                var child:XML = parseElementToXML(element);
                if (child)
                {
                    result.appendChild(child);
                }
            }
            return result;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function parseElements(target:*):Array
        {
            if (target is Array)
            {
                return parseElementsFromArray(target);
            }
            var reflection:Reflection = Reflection.create(target);
            if (DataUtils.isUnit(reflection))
            {
                return [new UnitData(target)];
            }
            if (DataUtils.isSuite(reflection))
            {
                return new SuiteData(target).elements;
            }
            return [];
        }
        private function parseElementsFromArray(target:Array):Array
        {
            var result:Array = [];
            for each (var elementClass:Class in target)
            {
                var elementReflection:Reflection = Reflection.create(elementClass);
                if (DataUtils.isUnit(elementReflection))
                {
                    result.push(new UnitData(elementClass));
                }
                else if (DataUtils.isSuite(elementReflection))
                {
                    result.push(new SuiteData(elementClass));
                }
            }
            return result;
        }
        private function parseElementToXML(element:*):XML
        {
            if (element is UnitData)
            {
                return parseUnitToXML(element);
            }
            if (element is SuiteData)
            {
                return parseSuiteToXML(element);
            }
            return null;
        }
        private function parseUnitToXML(unit:UnitData):XML
        {
            var testMethods:Array = unit.testMethods;
            var numMethods:int = testMethods.length;
            var result:XML = <node label={unit.name} />;
            for each (var testMethod:UnitMethod in testMethods)
            {
                var key:String = unit.name + "/" + testMethod.name;
                methodMap[key] = testMethod;
                if (!firstMethodKey)
                {
                    firstMethodKey = key;
                }
                if (numMethods == 1 && testMethod.name == "test")
                {
                    return <node label={unit.name} data={key} />;
                }
                result.appendChild(<node label={testMethod.name} data={key} />);
            }
            return result;
        }
        private function parseSuiteToXML(suite:SuiteData):XML
        {
            var result:XML = <node label={suite.name} />;
            for each (var element:* in suite.elements)
            {
                var child:XML = parseElementToXML(element);
                if (child)
                {
                    result.appendChild(child);
                }
            }
            return result;
        }
    }
}