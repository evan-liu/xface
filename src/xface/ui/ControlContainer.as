package xface.ui
{
    import flash.geom.Rectangle;
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    /**
     * @author eidiot
     */
    public class ControlContainer extends Sprite
    {
    	//======================================================================
    	//  Constructor
    	//======================================================================
        public function ControlContainer()
        {
        	super();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var topNext:Number = 0;
        private var bottomNext:Number = 0;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  margin
        //------------------------------
        private var _margin:Number = 10;
        /** Margin value of controls. */
        public function get margin():Number
        {
            return _margin;
        }
        /** @private */
        public function set margin(value:Number):void
        {
            _margin = value;
        }
        //------------------------------
        //  space
        //------------------------------
        private var _space:Number = 5;
        /** Space between controls. */
        public function get space():Number
        {
            return _space;
        }
        /** @private */
        public function set space(value:Number):void
        {
            _space = value;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        public function addToTop(...controls):void
        {
        	if (topNext < _margin)
        	{
        		topNext = _margin;
        	}
        	for each (var control:DisplayObject in controls)
        	{
        	    if (!control)
        	    {
        	    	continue;
        	    }
        	    addChild(control);
        	    var bounds:Rectangle = control.getBounds(this);
        	    control.x = topNext - bounds.x;
        	    control.y = margin - bounds.y;
        	    topNext += bounds.width + _space;
        	}
        }
        public function addToBottom(...controls):void
        {
        	if (bottomNext < margin)
        	{
        		bottomNext = margin;
        	}
        	for each (var control:DisplayObject in controls)
        	{
        	    if (!control)
        	    {
        	    	continue;
        	    }
        	    addChild(control);
        	    var bounds:Rectangle = control.getBounds(this);
        	    control.x = bottomNext - bounds.x;
        	    control.y = stage.stageHeight - margin - bounds.height - bounds.y;
        	    bottomNext = bounds.width + _space;
        	}
        }
        /**
         * Clear the container.
         */
        public function clear():void
        {
        	while (numChildren > 0)
            {
                removeChildAt(0);
            }
            topNext = 0;
            bottomNext = 0;
        }
    }
}