package
{
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.system.System;
    import flash.text.TextField;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MArrayUtil;
    import jhb0b.utils.MStringUtil;



    public class CFla04Importer extends CContainerWrapper
    {
        public function CFla04Importer(tcont:DisplayObjectContainer)
        {
            super(tcont);





/*
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.display.NativeWindow;
import flash.display.NativeWindowInitOptions;
import flash.display.NativeWindowSystemChrome;
import flash.display.NativeWindowType;
import flash.display.Screen;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.filesystem.StorageVolume;
import flash.filesystem.StorageVolumeInfo;
import flash.geom.Rectangle;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.MessageChannel;
import flash.system.Security;
import flash.system.SecurityDomain;
import flash.system.Worker;
import flash.system.WorkerDomain;
import flash.system.WorkerState;
import flash.text.TextField;
import flash.ui.Keyboard;
import flash.utils.ByteArray;
import flash.utils.setTimeout;

import hobis.airpc.MLog;

import jhb0b.utils.MArrayUtil;
import jhb0b.utils.MLoaderUtil;
import jhb0b.utils.MStringUtil;
		*/

            _tf1 = _cont['tf_1'];
            _tf1.text ='';

            SimpleButton(_cont['bt_1']).addEventListener(MouseEvent.CLICK,
                function(te:MouseEvent):void {
                    _atxt = Clipboard.generalClipboard.getData(ClipboardFormats.TEXT_FORMAT).toString();
                    if (!MStringUtil.is_empty(_atxt)) {
                        _larr = _atxt.split('\r\n');
                        if ((_larr != null) && (_larr.length > 0)) {
                            _larr = MArrayUtil.distinct(_larr);
                            _larr.sort();

                            var tnews:String = '';
                            _larr.forEach(
                                function(te:String, ti:uint, ta:Array):void {
                                    if (!MStringUtil.is_empty(te))
                                        tnews += MStringUtil.clear_whiteSpace(te) + '\n';
                                });
                            _tf1.text = tnews;
                            _tf1.scrollV = _tf1.maxScrollV;
                            System.setClipboard(tnews);
                        }
                    }
                });
        }

        private var _tf1:TextField;

        private var _atxt:String
        private var _larr:Array;
    }
}

