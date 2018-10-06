package
{
    import flash.desktop.NativeProcess;
    import flash.desktop.NativeProcessStartupInfo;
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.InvokeEvent;
    import flash.events.MouseEvent;
    import flash.filesystem.File;

    import hobis.airpc.CNwndBase;
    import hobis.airpc.MAppXmlUpdateCounter;
    import hobis.airpc.MNwndHelper;
    import hobis.prepared.MMakeFormat;

    import jhb0b.utils.MDisplayObjectContainerUtil;
    import jhb0b.utils.MLoaderUtil;
    import jhb0b.utils.MStringUtil;
    import flash.text.TextField;



    [SWF(width="340", height="400", frameRate="30")]
    public final class CEntryPoint extends CNwndBase
    {
        protected override function ppInitOnce(evt:Event):void
        {
            super.ppInitOnce(evt);


            MAppXmlUpdateCounter.Update(MMakeFormat.make('{#XXOP#}yyMMddhhmmssfff'));
            MNwndHelper.align_rightBottom(_nwnd, 10, 40);
            _nwnd.title = '';
            _stg.scaleMode = StageScaleMode.NO_SCALE;
            _stg.align = StageAlign.TOP_LEFT;
            _napp.addEventListener(InvokeEvent.INVOKE, pp_napp_invoke);
        }

        private var _args:Array;



        private function pp_napp_invoke(te:InvokeEvent):void
        {
            _args = te.arguments;
            if (_args.length == 0)
            {
                pp_mainStart();
            }
            else
            {
                pp_subStart(_args[0]);
            }
        }


        private function pp_mainStart():void
        {
            _nwnd.title = 'Developer Tools  v1.04';
            MLoaderUtil.createAndLoad(_own, './MainUi.swf', null,
                function(evt:Event):void
                {
                    var sprMain:Sprite = Sprite(LoaderInfo(evt.currentTarget).content);
                    MDisplayObjectContainerUtil.contLoop_io(sprMain, 'bect_',
                        function(tcdo:DisplayObject, ti:int):Boolean
                        {
                            var tbt:SimpleButton = SimpleButton(tcdo);
                            tbt.addEventListener(MouseEvent.CLICK, pp_bt_cl);
                            return false;
                        });
                }
            );
        }

		private function pp_bt_cl(te:MouseEvent):void
		{
            const tnms:Object =
            {
                1: 'SubBase64.swf',
                2: 'SubUrlEncoding.swf',
                3: 'SubSha256.swf'
            };

            var tbt:SimpleButton = SimpleButton(te.currentTarget);
			var tn:int = MStringUtil.get_lastNum(tbt.name);
            var tfnm:String = tnms[tn];

            var trf:File = _appdf.resolvePath('DeveloperTools.exe');
            //p_test('trf.nativePath: ' + trf.nativePath);
            var tnpsi:NativeProcessStartupInfo = new NativeProcessStartupInfo();
            tnpsi.workingDirectory = _appdf;
            tnpsi.executable = trf;
            tnpsi.arguments = Vector.<String>([tfnm]);
            var tnp:NativeProcess = new NativeProcess();
            tnp.start(tnpsi);
		}



        private function pp_subStart(tnm:String):void
        {
            _nwnd.title = '~~~~ ' + tnm;
            pp_nwnd_update(600, 500);
            MLoaderUtil.createAndLoad(_own, './' + tnm, null,
                function(evt:Event):void
                {
                    // var tldi:LoaderInfo = LoaderInfo(evt.currentTarget);
                    // pp_nwnd_update(tldi.width, tldi.height);
                });

            // switch (tnb)
            // {
            //     case '1':
            //         _nwnd.title = '~~~~ Base64';
            //         pp_nwnd_update(600, 500);
            //         MLoaderUtil.createAndLoad(_own, './SubBase64.swf', null,
            //             function(evt:Event):void
            //             {
            //                 // var tldi:LoaderInfo = LoaderInfo(evt.currentTarget);
            //                 // pp_nwnd_update(tldi.width, tldi.height);
            //             });
            //         break;

            //     case '2':
            //         _nwnd.title = '~~~~ UrlEncoding';
            //         pp_nwnd_update(600, 500);
            //         MLoaderUtil.createAndLoad(_own, './SubUrlEncoding.swf', null,
            //             function(evt:Event):void
            //             {
            //             });
            //         break;

            //     case '3':
            //         _nwnd.title = '~~~~ Sha256';
            //         pp_nwnd_update(600, 500);
            //         MLoaderUtil.createAndLoad(_own, './SubSha256.swf', null,
            //             function(evt:Event):void
            //             {
            //             });
            //         break;
            // }
        }

        private function pp_nwnd_update(tw:Number, th:Number):void
        {
            _stg.stageHeight = th;
            _stg.stageWidth = tw;
            MNwndHelper.align_rightBottom(_nwnd, (300) + 60, 40);
        }

    }
}
















/*

package
{
    import com.greensock.TweenNano;
    import com.greensock.easing.Expo;

    import flash.desktop.NativeProcess;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.InvokeEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;

    import hobis.airpc.CNwndBase;
    import hobis.airpc.MAppXmlUpdateCounter;
    import hobis.airpc.MNwndHelper;
    import hobis.prepared.MMakeFormat;

    import jhb0b.utils.MDisplayObjectContainerUtil;
    import jhb0b.utils.MLoaderUtil;
    import jhb0b.utils.MStringUtil;



    [SWF(width="340", height="400", frameRate="30")]
    public final class CEntryPoint extends CNwndBase
    {
        protected override function ppInitOnce(evt:Event):void
        {
            super.ppInitOnce(evt);


            MAppXmlUpdateCounter.Update(MMakeFormat.make('{#XXOP#}yyMMddhhmmssfff'));
            MNwndHelper.align_rightBottom(_nwnd, 10, 40);

            _nwnd.title = 'Developer Tools  v1.04';
            _stg.scaleMode = StageScaleMode.NO_SCALE;
            _stg.align = StageAlign.TOP_LEFT;


            _napp.addEventListener(InvokeEvent.INVOKE,
                function(te:InvokeEvent):void
                {
                    _args = te.arguments;
                    if (_args.length == 0)
                    {
                        pp_mainStart();
                    }
                });
        }

        private var _args:Array;

        private var _ldrMain:Loader;
        private var _sprMain:Sprite;
        private var _btnClose:SimpleButton;
        private var _sprRecter:Sprite;

        private var _ldrSub:Loader;
        private var _sprSub:Sprite;



        private function pp_mainStart():void
        {
            _ldrMain = MLoaderUtil.createAndLoad(_own, './MainUi.swf', null,
                function(evt:Event):void
                {
                    _sprMain = Sprite(_ldrMain.content);
                    _sprRecter = _sprMain['mcRecter'];
                    _sprRecter.mouseChildren = false;
                    _sprRecter.mouseEnabled = false;
                    _sprRecter.visible = false;

                    _btnClose = _sprMain['bt_close'];
                    _btnClose.visible = false;
                    _btnClose.addEventListener(MouseEvent.CLICK,
                        function(te:MouseEvent):void
                        {
                            pp_closeSub();
                        });

                    MDisplayObjectContainerUtil.contLoop_io(_sprMain, 'bect_',
                        function(tcdo:DisplayObject, ti:int):Boolean
                        {
                            var tbt:SimpleButton = SimpleButton(tcdo);
                            tbt.addEventListener(MouseEvent.CLICK, pp_bt_cl);
                            return false;
                        });

                    // _napp.addEventListener(KeyboardEvent.KEY_UP,
                    //     function(te:KeyboardEvent):void
                    //     {
                    //         var tkc:uint = te.keyCode - (112 - 1);
                    //         var tbt:SimpleButton = _sprMain['bect_' + tkc];
                    //         if (tbt != null)
                    //         {
                    //             tbt.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    //         }
                    //     });
                }
            );
        }

		private function pp_bt_cl(te:MouseEvent):void
		{
            var tnp:NativeProcess = new NativeProcess();


            // var tbt:SimpleButton = SimpleButton(te.currentTarget);
            // var ty:Number = tbt.y;
			// var tn:int = MStringUtil.get_lastNum(tbt.name);
            // switch (tn)
            // {
            //     case 1:
            //         pp_openSub('./SubBase64.swf', ty);
            //         break;

            //     case 2:
            //         pp_openSub('./SubUrlEncoding.swf', ty);
            //         break;

            //     case 3:
            //         pp_openSub('./SubSha256.swf', ty);
            //         break;
            // }
		}


		private function pp_closeSub():void
		{
            if (_ldrSub == null) return;
            _sprMain.removeChild(_ldrSub);
            try { _ldrSub.unloadAndStop(true); } catch (e:Error) { }
            _ldrSub = null;
            _btnClose.visible = false;
            _sprRecter.visible = false;
		}

		private function pp_openSub(turl:String, ty:Number = NaN):void
		{
            pp_closeSub();
            var tlc:LoaderContext = new LoaderContext(false, new ApplicationDomain());
            _ldrSub = MLoaderUtil.createAndLoad(_sprMain, turl, tlc,
                function(evt:Event):void { });
            //_ldrSub.visible = false;
            _ldrSub.alpha = 0;
            _ldrSub.x = 200;
            TweenNano.to(_ldrSub, 1, { alpha: 1, ease: Expo.easeOut });
            _sprMain.swapChildren(_btnClose, _ldrSub);
            _btnClose.visible = true;
            _sprRecter.visible = true;
            _sprRecter.y = ty + 16;
		}

    }
}


*/












































/*
package
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    import hobis.airpc.CNwndBase;
    import hobis.airpc.MNwndHelper;

    import jhb0b.utils.MDisplayObjectContainerUtil;
    import jhb0b.utils.MLoaderUtil;
    import jhb0b.utils.MStringUtil;
    import flash.text.TextField;



    [SWF(width="800", height="500", frameRate="30")]
    public final class CEntryPoint extends CNwndBase
    {
        protected override function ppInitOnce(evt:Event):void
        {
            super.ppInitOnce(evt);


            //MAppXmlUpdateCounter.Update(MMakeFormat.make('{#XXOP#}yyMMddhhmmssfff'));
            pp_nwnd_update(false);

            _nwnd.title = '[Developer Tools  ver 1.00]';
            _stg.scaleMode = StageScaleMode.NO_SCALE;
            _stg.align = StageAlign.TOP_LEFT;

            _ldrMain = MLoaderUtil.createAndLoad(_own, './FlaMain.swf', null,
                function(evt:Event):void
                {
                    _sprMain = Sprite(_ldrMain.content);
                    _btnClose = _sprMain['bt_close'];
                    _stg.addChild(_btnClose);
                    _btnClose.visible = false;
                    _btnClose.addEventListener(MouseEvent.CLICK,
                        function(te:MouseEvent):void
                        {
                            pp_closeSub();
                        });
                    MDisplayObjectContainerUtil.contLoop_io(_sprMain, 'bect_',
                        function(tcdo:DisplayObject, ti:int):Boolean
                        {
                            var tbt:SimpleButton = SimpleButton(tcdo);
                            tbt.addEventListener(MouseEvent.CLICK, pp_bt_cl);
                            return false;
                        });
                }
            );
        }

        private function pp_nwnd_update(tb:Boolean, tw:Number = 800, th:Number = 500):void
        {
            _stg.stageWidth = tw;
            _stg.stageHeight = th;
            if (_btnClose != null)
            {
                _btnClose.x = tw - 19;
                _btnClose.visible = tb;
            }
            MNwndHelper.align_rightBottom(_nwnd, 100, 40);
        }

        private var _ldrMain:Loader;
        private var _sprMain:Sprite;
        private var _btnClose:SimpleButton;

        private var _subLoad:Loader;
        private var _sub:Sprite;


		private function pp_bt_cl(te:MouseEvent):void
		{
			var tn:int = MStringUtil.get_lastNum(SimpleButton(te.currentTarget).name);
            switch (tn)
            {
                case 1:
                {
                    pp_openSub('./FlaBase64.swf');
                    break;
                }
            }
		}


		private function pp_closeSub():void
		{
            if (_subLoad == null) return;
            _own.removeChild(_subLoad);
            try { _subLoad.unloadAndStop(true); } catch (e:Error) { }
            _subLoad = null;
            pp_nwnd_update(false);
		}

		private function pp_openSub(turl:String):void
		{
            pp_closeSub();
            _subLoad = MLoaderUtil.createAndLoad(_own, turl, null,
                function(evt:Event):void
                {
                    pp_nwnd_update(true, _subLoad.width, _subLoad.height);
                }
            );
            _subLoad.x = 200;
		}

    }
}




















*/