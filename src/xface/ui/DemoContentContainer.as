package xface.ui
{
    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class DemoContentContainer extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function DemoContentContainer()
        {
            super();
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  color
        //------------------------------
        private var _color:uint = 0xFFFFFF;
        /**
         * Background color.
         */
        public function get color():uint
        {
            return _color;
        }
        public function set color(value:uint):void
        {
            _color = value;
            if (stage)
            {
                with (graphics)
                {
                    clear();
                    beginFill(value);
                    drawRect(0, 0, stage.stageWidth, stage.stageHeight);
                    endFill();
                }
            }
        }
    }
}