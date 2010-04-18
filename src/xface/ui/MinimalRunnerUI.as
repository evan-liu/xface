package xface.ui
{
    import xface.UnitMethod;

    import com.bit101.components.List;

    import flash.events.Event;
    /**
     * Runner ui using @bit101's Minimal Compos.
     * @author eidiot
     */
    public class MinimalRunnerUI extends AbstractRunnerUI
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function MinimalRunnerUI()
        {
            super();
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
        override protected function buildUI(dataList:Array):void
        {
            for each (var data:Object in dataList)
            {
                list.addItem(data);
            }
            list.draw();
            uiContainer.addChild(list);
            list.setSize(150, stage.stageHeight);
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
                    runner.runMethod(item.value);
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