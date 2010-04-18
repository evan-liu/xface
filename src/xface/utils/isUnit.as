package xface.utils
{
    import p2.reflect.Reflection;
    /**
     * Check if a Class is a Unit.
     * @param reflection    Reflection of the target class.
     * @author eidiot
     */
    public function isUnit(reflection:Reflection):Boolean
    {
        return reflection.getMethodsByMetaData("Test").length > 0;
    }
}
