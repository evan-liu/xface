package xface.ui
{
    import fl.events.ListEvent;

    import xface.UnitMethod;

    import com.yahoo.astra.fl.controls.Tree;
    import com.yahoo.astra.fl.controls.treeClasses.TreeDataProvider;
    /**
     * @author eidiot
     */
    public class TreeRunnerUI extends AbstractRunnerUI
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function TreeRunnerUI(width:Number = 150, openAllNode:Boolean = false)
        {
            super(width);
            this.openAllNode = openAllNode;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var openAllNode:Boolean;
        //======================================================================
        //  Properties
        //======================================================================
        public const tree:Tree = new Tree();
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function buildUI(elements:Array):void
        {
            tree.setSize(uiWidth, stage.stageHeight);
            tree.x = stage.stageWidth - uiWidth;
            uiContainer.addChild(tree);
            var data:XML = parseElementsToXML(elements);
            tree.dataProvider = new TreeDataProvider(data);
            tree.addEventListener(ListEvent.ITEM_CLICK, itemClickHandler);
        }
        /** @private */
        override protected function runFirst():void
        {
            if (firstMethodKey && firstMethodKey in methodMap)
            {
                var firstMethod:UnitMethod = methodMap[firstMethodKey];
                runner.runMethod(firstMethod);
                if (openAllNode)
                {
                    tree.openAllNodes();
                }
                else
                {
                    tree.exposeNode("label", firstMethod.name);
                }
            }
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function itemClickHandler(event:ListEvent):void
        {
            var key:String = event.item.data;
            if (key && key in methodMap)
            {
                runner.runMethod(methodMap[key]);
            }
        }
    }
}