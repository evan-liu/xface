package
{
    import xface.ui.MinimalRunnerUI;
    
    [SWF(width="550", height="400", backgroundColor="0xFFFFFF", frameRate="30")]
    
    /**
     * @author eidiot
     */
    public class DemoUIUnitRunner extends MinimalRunnerUI
    {
        public function DemoUIUnitRunner()
        {
            super();
            run(AllUnits);
        }
    }
}