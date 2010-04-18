package xface.utils
{
    /**
     * Remove postfix from a name string.
     * @param source    A name string with a postfix or not.
     * @param postFix   Postfix to be removed.
     * @return          Result after removing the postfix.
     * @author eidiot
     */
    public function removePostfix(source:String, postFix:String):String
    {
        var postfixIndex:int = -postFix.length;
        if (source.slice(postfixIndex) == postFix)
        {
            return source.slice(0, postfixIndex);
        }
        return source;
    }
}