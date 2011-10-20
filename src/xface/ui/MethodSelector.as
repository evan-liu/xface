package xface.ui
{
    import com.bit101.components.Window;
    import com.yahoo.astra.fl.controls.Tree;
    import com.yahoo.astra.fl.controls.treeClasses.TreeDataProvider;
    import fl.events.ListEvent;
    import flash.utils.Dictionary;
    import xface.core.MethodRunner;
    import xface.core.UnitMethod;
    import xface.utils.DataParser;




    public class MethodSelector extends Window
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var tree:Tree = new Tree();

        private var methodMap:Dictionary;
        private var methodRunner:MethodRunner;
        //======================================================================
        //  Public methods
        //======================================================================
        public function fill(runTarget:*, methodRunner:MethodRunner, selectorWidth:Number,
                             openAllNode:Boolean, title:String):void
        {
            this.methodRunner = methodRunner;
            if (title)
            {
                this.title = title;
            }

            hasMinimizeButton = true;
            setSize(selectorWidth, stage.stageHeight);
            tree.addEventListener(ListEvent.ITEM_CLICK, itemClickHandler);
            tree.setSize(selectorWidth, stage.stageHeight - titleBar.height);
            addChild(tree);
            x = stage.stageWidth - width;

            var parser:DataParser = new DataParser();
            var data:XML = parser.parse(runTarget);
            tree.dataProvider = new TreeDataProvider(data);
            methodMap = parser.methodMap;

            var firstMethod:UnitMethod = methodMap[parser.firstMethodKey];
            if (firstMethod)
            {
                methodRunner.runMethod(firstMethod);
                openAllNode ? tree.openAllNodes() :
                              tree.exposeNode("label", firstMethod.name);

                var i:int = 0;
                while (true)
                {
                    var d:Object = tree.getItemAt(i);
                    if (d.data == parser.firstMethodKey)
                    {
                        tree.selectedIndex = i;
                        break;
                    }
                    i++;
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
                methodRunner.runMethod(methodMap[key]);
            }
        }
    }
}