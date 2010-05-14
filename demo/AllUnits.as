package
{
    import minimal.MinimalSuite;

    import shapes.ShapeSuite;

    /**
     * @author eidiot
     */
    [Suite]
    public class AllUnits
    {
        public static function suite():Array
        {
            return [
                TextUnit,
                ShapeSuite,
                MinimalSuite
            ];
        }
        /*
        public var _TextUnit:TextUnit;
        public var _ShapeSuite:ShapeSuite;
        public var _MinimalSuite:MinimalSuite;
         */
    }
}