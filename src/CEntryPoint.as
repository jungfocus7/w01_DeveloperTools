package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.NativeWindow;
    import flash.display.NativeWindowInitOptions;
    import flash.display.NativeWindowType;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.InvokeEvent;
    import flash.utils.Dictionary;

    import hobis.airpc.CNwndBase;
    import hobis.airpc.MAppXmlUpdateCounter;
    import hobis.airpc.MNwndHelper;
    import hobis.prepared.MMakeFormat;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.events.CBumEvent;
    import jhb0b.utils.MLoaderUtil;



    [SWF(width="340", height="400", frameRate="30")]
    public class CEntryPoint extends CNwndBase
    {
        protected override function ppInitOnce(evt:Event):void
        {
            super.ppInitOnce(evt);


            MAppXmlUpdateCounter.Update(MMakeFormat.make('{#XXOP#}yyMMddhhmmssfff'));

            _nwnd.title = '';
            _stage.scaleMode = StageScaleMode.NO_SCALE;
            _stage.align = StageAlign.TOP_LEFT;
            MNwndHelper.align_rightBottom(_nwnd, 10, 60);

            _napp.addEventListener(InvokeEvent.INVOKE,
                function(evt:InvokeEvent):void
                {
                    var args:Array = evt.arguments;
                    if (args.length == 0)
                        pp_moduleLoad(null);
                    else
                        pp_moduleLoad(args[0]);
                });
        }

        private function pp_moduleLoadError(evt:IOErrorEvent):void
        {
            _napp.exit(1);
        }

        private function pp_moduleLoad(tmdnm:String):void
        {
            if (tmdnm == null)
            {
                MLoaderUtil.createAndLoad(_owner, './Fla00Main.swf', null,
                    function(evt:Event):void
                    {
                        _nwnd.title = '개발자 도구  v1.00';
                        _nwnd.activate();


                        var tcont:DisplayObjectContainer = DisplayObjectContainer(LoaderInfo(evt.currentTarget).content);
                        _contWrapp = new CFla00Main(tcont);
                        _contWrapp.addEventListener(CFla00Main.ET_ITEM_CLICK, pp_main_itemClick);
                    }, null, pp_moduleLoadError);
            }
        }

        private var _contWrapp:CContainerWrapper;
        private var _dicNwnd:Dictionary = new Dictionary();


        private function pp_main_itemClick(evt:CBumEvent):void
        {
            var tmdtit:String = evt.get_dataObj().mdtit;
            var tmdnm:String = evt.get_dataObj().mdnm;
            var tmdw:Number = evt.get_dataObj().mdw;
            var tmdh:Number = evt.get_dataObj().mdh;
            pp_nwndCreate(tmdtit, tmdnm, tmdw, tmdh);
        }

        private function pp_nwndClear(tmdnm:String):void
        {
            var tnw:NativeWindow = _dicNwnd[tmdnm];
            if (tnw != null)
            {
                tnw.dispatchEvent(new Event(Event.CLOSING));
                tnw.close();
            }
        }

        private function pp_nwndClosing(evt:Event):void
        {
            var tnw:NativeWindow = NativeWindow(evt.currentTarget);
            try
            {
                MLoaderUtil.unload(Loader(tnw.stage.getChildAt(0)), true);
            }
            catch(e:Error) { }
            delete _dicNwnd[tnw.title];
            p_test('메모리 정리 했어요~~');
        }

        private function pp_nwndCreate(tmdtit:String, tmdnm:String, tsw:Number, tsh:Number):void
        {
            var tnw:NativeWindow = _dicNwnd[tmdtit];
            if (tnw != null)
            {
                tnw.activate();
            }
            else
            {
                var tnwio:NativeWindowInitOptions = new NativeWindowInitOptions();
                tnwio.type = NativeWindowType.NORMAL;
                tnwio.owner = _nwnd;
                tnwio.maximizable = false;
                tnwio.resizable = false;
                tnw = new NativeWindow(tnwio);
                tnw.title = tmdtit;
                tnw.addEventListener(Event.CLOSING, pp_nwndClosing);

                var tstg:Stage = tnw.stage;
                tstg.scaleMode = StageScaleMode.NO_SCALE;
                tstg.align = StageAlign.TOP_LEFT;
                tstg.stageWidth = tsw;
                tstg.stageHeight = tsh;

                var tfurl:String = './' + tmdnm + '.swf';
                MLoaderUtil.createAndLoad(tstg, tfurl);
                MNwndHelper.align_rightBottom(tnw, 10, 60);
                tnw.activate();

                _dicNwnd[tmdtit] = tnw;
            }
        }
    }
}

