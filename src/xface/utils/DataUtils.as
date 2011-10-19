package xface.utils
{
    import p2.reflect.Reflection;
    public class DataUtils
    {
        /**
         * Check if a Class is a suite.
         * @param reflection    Reflection of the target class.
         * @author eidiot
         */
        public static function isSuite(reflection:Reflection):Boolean
        {
            return reflection.getMetaDataByName("Suite") != null;
        }
        /**
         * Check if a Class is a Unit.
         * @param reflection    Reflection of the target class.
         * @author eidiot
         */
        public static function isUnit(reflection:Reflection):Boolean
        {
            return reflection.getMethodsByMetaData("Test").length > 0;
        }
        /**
         * Remove postfix from a name string.
         * @param source    A name string with a postfix or not.
         * @param postFix   Postfix to be removed.
         * @return          Result after removing the postfix.
         * @author eidiot
         */
        public static function removePostfix(source:String, postFix:String):String
        {
            var postfixIndex:int = -postFix.length;
            if (source.slice(postfixIndex) == postFix)
            {
                return source.slice(0, postfixIndex);
            }
            return source;
        }
    }
}