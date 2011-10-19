package xface.ui
{
    import com.bit101.components.List;
    import flash.events.Event;
    import xface.data.UnitMethod;


    /**
     * Runner ui using @bit101's Minimal Compos.
     * @author eidiot
     */
    public class MinimalRunnerUI extends AbstractRunnerUI
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function MinimalRunnerUI(width:Number = 150)
        {
            super(width);
        }
        //======================================================================
        //  Properties
        //======================================================================
        /**
         * List componet to show the unit methods.
         */
        public const list:List = new List();
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function buildUI(elements:Array):void
        {
            var dataList:Array = parseElementsToArray(elements);
            for each (var data:Object in dataList)
            {
                list.addItem(data);
            }
            list.draw();
            uiContainer.addChild(list);
            list.setSize(uiWidth, stage.stageHeight);
            list.x = stage.stageWidth - list.width;
            //
            list.addEventListener(Event.SELECT, changeHandler);
        }
        /** @private */
        override protected function runFirst():void
        {
            for each (var item:Object in list.items)
            {
                if (item.value is UnitMethod)
                {
                    list.selectedItem = item;
                    return;
                }
            }
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        /** @private */
        protected function changeHandler(event:Event):void
        {
            var method:UnitMethod = list.selectedItem.value as UnitMethod;
            if (method)
            {
                runner.runMethod(method);
            }
        }
    }
}