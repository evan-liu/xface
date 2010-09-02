package
{
    import xface.ui.YahooTreeRunnerUI;

    [SWF(width="550", height="400", backgroundColor="0xFFFFFF", frameRate="30")]

    /**
     * @author eidiot
     */
    public class DemoUIUnitRunner extends YahooTreeRunnerUI
    {
        public function DemoUIUnitRunner()
        {
            super();
            run(AllUnits);
        }
    }
}