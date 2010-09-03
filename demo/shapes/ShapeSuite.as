package shapes
{

    [Suite]
    /**
     * @author eidiot
     */
    public class ShapeSuite
    {
        public static function suite():Array
        {
            return [
                RectangleUnit,
                CircleUnit
            ];
        }
        /*
        public var _RectangleUnit:RectangleUnit;
        public var _CircleUnit:CircleUnit;
         */
    }
}