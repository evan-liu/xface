package xface.data
{
    import flash.utils.Dictionary;
    import flash.utils.getQualifiedClassName;
    public class RunnerData
    {
        public const setUpMethods:Vector.<Function> = new Vector.<Function>();
        public const tearDownMethods:Vector.<Function> = new Vector.<Function>();
        public const injectionMap:Dictionary = new Dictionary();

        public var unitFactory:Function = function(unitClass:Class):* {
            return new unitClass();
        };

        /**
         * Add methods to run before every unit method.
         */
        public function addSetUpMethods(...methods):void
        {
            addMethodsToList(methods, setUpMethods);
        }
        /**
         * Add methods to run after every unit method.
         */
        public function addTearDownMethods(...methods):void
        {
            addMethodsToList(methods, tearDownMethods);
        }
        /**
         * Map an injection point for [Inject] metadata in units.
         */
        public function mapInjection(instance:*, ...types):void
        {
            injectionMap[getQualifiedClassName(instance)] = instance;

            if (types.length == 0)
            {
                return;
            }
            while (types.length == 1 && types[0] is Array)
            {
                types = types[0];
            }
            for each (var type:* in types)
            {
                injectionMap[getQualifiedClassName(type)] = instance;
            }
        }
        /**
         * Get and mapped injection instance mapInjection() method.
         */
        public function getInjection(type:Class):*
        {
            return injectionMap[getQualifiedClassName(type)];
        }

        private function addMethodsToList(methods:Array, list:Vector.<Function>):void
        {
            while (methods.length == 1 && methods[0] is Array)
            {
                methods = methods[0];
            }
            for each (var method:Function in methods)
            {
                if (list.indexOf(method) == -1)
                {
                    list.push(method);
                }
            }
        }
    }
}