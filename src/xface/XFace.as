package xface
{
    import xface.ui.ContentContainer;
    import xface.ui.ControlContainer;
    import xface.ui.MethodSelector;

    import flash.display.DisplayObjectContainer;
    import flash.errors.IllegalOperationError;
    public class XFace
    {
        //======================================================================
        //  Class variables
        //======================================================================
        private static var contentContainer:ContentContainer = new ContentContainer();
        private static var controlContainer:ControlContainer = new ControlContainer();
        private static var methodSelector:MethodSelector = new MethodSelector();

        private static var methodRunner:MethodRunner;
        //======================================================================
        //  Class public methods
        //======================================================================
        public static function run(container:DisplayObjectContainer, runTarget:*,
                                   unitFactory:Function = null,
                                   selectorWidth:Number = 150,
                                   openAllNode:Boolean = true):void
        {
            if (!container.stage)
            {
                throw new IllegalOperationError("Add container to stage before running!");
            }
            container.addChild(contentContainer);
            container.addChild(controlContainer);
            container.addChild(methodSelector);

            methodRunner = new MethodRunner(contentContainer, controlContainer, unitFactory);
            methodSelector.fill(runTarget, methodRunner, selectorWidth, openAllNode);
        }
    }
}