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
        private var topNextX:Number = -1;
        private var topLineY:Number = -1;
        private var topLineHeight:Number = -1;

        private var bottomNextX:Number = -1;
        private var bottomLineY:Number = -1;
        private var bottomLineHeight:Number = -1;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  margin
        //------------------------------
        private var _margin:Number = 2;
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
        private var _space:Number = 3;
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
        /**
         * Add some controls to top of the container.
         */
        public function addToTop(...controls):DisplayObject
        {
            if (topNextX < 0)
            {
                topNextX = _margin;
            }
            if (topLineY < 0)
            {
                topLineY = _margin;
            }
            while (controls.length == 1 && controls[0] is Array)
            {
                controls = controls[0];
            }
            for each (var control:DisplayObject in controls)
            {
                if (!control)
                {
                    continue;
                }
                control.x = control.y = 0;
                addChild(control);
                var bounds:Rectangle = control.getBounds(this);
                control.x = topNextX - bounds.x;
                control.y = topLineY - bounds.y;
                topNextX += bounds.width + _space;
                if (control.height > topLineHeight)
                {
                    topLineHeight = control.height;
                }
            }
            return control;
        }
        /**
         * Add some controls to bottom of the container.
         */
        public function addToBottom(...controls):DisplayObject
        {
            if (bottomNextX < 0)
            {
                bottomNextX = _margin;
            }
            if (bottomLineY < 0)
            {
                bottomLineY = stage.stageHeight - _margin;
            }
            while (controls.length == 1 && controls[0] is Array)
            {
                controls = controls[0];
            }
            for each (var control:DisplayObject in controls)
            {
                if (!control)
                {
                    continue;
                }
                control.x = control.y = 0;
                addChild(control);
                var bounds:Rectangle = control.getBounds(this);
                control.x = bottomNextX - bounds.x;
                control.y = bottomLineY - bounds.height - bounds.y;
                bottomNextX += bounds.width + _space;
                if (control.height > bottomLineHeight)
                {
                    bottomLineHeight = control.height;
                }
            }
            return control;
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
            topNextX = topLineY = topLineHeight = -1;
            bottomNextX = bottomLineY = bottomLineHeight = -1;
        }
        public function addSpace(value:Number):void
        {
            topNextX += value;
        }
        public function addSpaceToBottom(value:Number):void
        {
            bottomNextX += value;
        }
        public function newLineForTopControls():void
        {
            if (topLineHeight > 0)
            {
                topNextX = _margin;
                topLineY += topLineHeight + _margin;
                topLineHeight = 0;
            }
        }
        public function newLineForBottomControls():void
        {
            if (bottomLineHeight > 0)
            {
                bottomNextX = _margin;
                bottomLineY -= bottomLineHeight + _margin;
                bottomLineHeight = 0;
            }
        }
    }
}