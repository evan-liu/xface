package xface.core
{
    import p2.reflect.ReflectionMetaData;
    import p2.reflect.ReflectionMethod;
    import xface.data.UnitData;
    /**
     * Unit method.
     * @author eidiot
     */
    public class UnitMethod
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>UnitMethod</code>.
         */
        public function UnitMethod(unitData:UnitData,
                                   reflection:ReflectionMethod,
                                   metaDataName:String)
        {
            _unitData = unitData;
            _name = reflection.name;
            _metaData = reflection.getMetaDataByName(metaDataName);
            _order = int(_metaData.getValueFor("order"));
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  name
        //------------------------------
        private var _name:String;
        /**
         * Name of the ui-unit method.
         */
        public function get name():String
        {
            return _name;
        }
        //------------------------------
        //  order
        //------------------------------
        private var _order:int;
        /**
         * Order of the method.
         */
        public function get order():int
        {
            return _order;
        }
        //------------------------------
        //  metaData
        //------------------------------
        /**
         * Meta data of the method ([Test], [Before] or [After]).
         */
        private var _metaData:ReflectionMetaData;
        public function get metaData():ReflectionMetaData
        {
            return _metaData;
        }
        //------------------------------
        //  unitData
        //------------------------------
        private var _unitData:UnitData;
        /**
         * Data of the ui-unit.
         */
        public function get unitData():UnitData
        {
            return _unitData;
        }
    }
}