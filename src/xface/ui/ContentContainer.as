package xface.ui
{
    import flash.display.Sprite;
    /**
     * @author eidiot
     */
    public class ContentContainer extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function ContentContainer()
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
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Draw a cross.
         */
        public function drawCross(x:Number = 0, y:Number = 0, crossLength:int = 100,
                                  crossColor:uint = 0x999999, crossAlpha:Number = 1):void
        {
            var r:int = crossLength / 2;
            graphics.lineStyle(1, crossColor, crossAlpha);
            graphics.moveTo(x - r, y);
            graphics.lineTo(x + r, y);
            graphics.moveTo(x, y - r);
            graphics.lineTo(x, y + r);
        }
        /**
         * Clear the content container.
         */
        public function clear():void
        {
            graphics.clear();
            while (numChildren > 0)
            {
                removeChildAt(0);
            }
            x = y = 0;
            scaleX = scaleY = 1;
        }
    }
}