package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLLoader;
    import flash.text.TextField;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MMovieClipUtil;
    import jhb0b.utils.MURLLoaderUtil;
    import jhb0b.whats.CBumScrolling;
    import jhb0b.events.CBumEvent;
    import jhb0b.utils.MStringUtil;
    import flash.display.DisplayObject;


    public class CFla00Main extends CContainerWrapper
    {
        public function CFla00Main(tcont:DisplayObjectContainer)
        {
            super(tcont);


            _itemCont = _cont['mvcItemCont'];
            var tsprip:Sprite = _itemCont['mvcItemProto'];
            _itemProto = tsprip['constructor'];
            _itemFilters = tsprip.filters;
            _itemCont.removeChild(tsprip);

            _mvcScrollMask = _cont['mvcScrollMask'];
            _mvcScrollMask.mouseChildren = false;
            _mvcScrollMask.mouseEnabled = false;
            _mvcScrollMask.gotoAndStop(1);

            _mvcSlider = _cont['mvcSlider'];
            _mvcSlider.mouseChildren = false;
            _mvcSlider.gotoAndStop(1);

            MURLLoaderUtil.createAndLoad('./Config.xml',
                function(evt:Event):void
                {
                    _xml = new XML(URLLoader(evt.currentTarget).data.toString());
                    var txl:XMLList = _xml.children();
                    for (var l:int = txl.length(), i:int = 0; i < l; i++)
                    {
                        var tx:XML = txl[i];
                        var tmvc:MovieClip = MovieClip(new _itemProto());
                        tmvc.gotoAndStop(1);
                        tmvc.filters = _itemFilters;
                        tmvc.y = 34 * i;
                        TextField(tmvc['txf_1']).text = tx.attribute('Title');
                        MMovieClipUtil.add_clickHandler_roo(tmvc, pp_mvc_cl);
                        _itemCont.addChild(tmvc);
                    }
                    pp_scrol_init();
                });
        }


        public static const ET_ITEM_CLICK:String = 'itemClick';

        private var _itemCont:DisplayObjectContainer;
        private var _itemProto:Class;
        private var _itemFilters:Array;

        private var _mvcScrollMask:MovieClip;
        private var _mvcSlider:MovieClip;
        private var _bumScroll:CBumScrolling;

        private var _xml:XML;


        private function pp_scrol_init():void
        {
            const tmh:Number = 400;
            var tich:Number = _itemCont.height;
            if (tich > tmh)
            {
                _bumScroll = new CBumScrolling(_itemCont, _mvcScrollMask, _mvcSlider, -15, 320);
                _bumScroll.set_scrollFrameDelta(34);
            }
            else
            {
                _mvcSlider.visible = false;
            }
        }

        private function pp_mvc_cl(evt:MouseEvent):void
        {
            var tdo:DisplayObject = DisplayObject(evt.currentTarget);
            var ti:uint = _itemCont.getChildIndex(tdo);
            this.dispatchEvent(new CBumEvent(ET_ITEM_CLICK,
                { mdnm: _xml.children()[ti].attribute('FileName').toString() }));
        }
    }
}

