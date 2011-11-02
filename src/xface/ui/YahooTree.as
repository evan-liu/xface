package xface.ui
{
    import com.yahoo.astra.fl.controls.Tree;
    import com.yahoo.astra.fl.controls.treeClasses.BranchNode;
    import com.yahoo.astra.fl.controls.treeClasses.TNode;
    import com.yahoo.astra.fl.controls.treeClasses.TreeCellRenderer;
    import com.yahoo.astra.fl.events.TreeEvent;

    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    /**
     * To remove 'event.stopPropagation();' in keyDownHandler(),
     * or other listeners for key down event will not be called.
     */
    public class YahooTree extends Tree
    {
        override protected function keyDownHandler(event:KeyboardEvent):void
        {
            if (!selectable)
                return;
            switch (event.keyCode)
            {
                case Keyboard.UP:
                case Keyboard.DOWN:
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN:
                    moveSelectionVertically(event.keyCode,
                                            event.shiftKey && _allowMultipleSelection,
                                            event.ctrlKey && _allowMultipleSelection);
                    break;
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                case Keyboard.SPACE:
                case Keyboard.ENTER:
                    if (caretIndex == -1)
                        caretIndex = 0;
                    var renderer:TreeCellRenderer = event.currentTarget as TreeCellRenderer;
                    var node:TNode = selectedItem as TNode;
                    if (node is BranchNode)
                    {
                        var branchNode:BranchNode = node as BranchNode;
                        if (branchNode.isOpen())
                        {
                            branchNode.closeNode();

                            var closeEvent:TreeEvent = new TreeEvent(TreeEvent.ITEM_CLOSE);
                            closeEvent.triggerEvent = event;
                            closeEvent.itemRenderer = renderer;
                            dispatchEvent(closeEvent);
                        }
                        else
                        {
                            branchNode.openNode();

                            var openEvent:TreeEvent = new TreeEvent(TreeEvent.ITEM_OPEN);
                            openEvent.triggerEvent = event;
                            openEvent.itemRenderer = renderer;
                            dispatchEvent(openEvent);
                        }
                    }
                    break;
                default:
                    var nextIndex:int = getNextIndexAtLetter(String.fromCharCode(event.keyCode), selectedIndex);
                    if (nextIndex > -1)
                    {
                        selectedIndex = nextIndex;
                        scrollToSelected();
                    }
                    break;
            }
        }
    }
}