package
{
    import xface.ui.MinimalRunnerUI;
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