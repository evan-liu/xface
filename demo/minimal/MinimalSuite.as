package minimal
{

    [Suite(label="Minmal Comps")]
    /**
     * @author eidiot
     */
    public class MinimalSuite
    {
        public static function suite():Array
        {
            return [
                LabelUnit,
                PushButtonUnit
            ];
        }
        /*
        public var _LabelUnit:LabelUnit;
        public var _PushButtonUnit:PushButtonUnit;
         */
    }
}