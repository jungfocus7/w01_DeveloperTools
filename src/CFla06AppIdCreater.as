package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.system.System;
    import flash.text.TextField;

    import hobis.prepared.MDateFormatter;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MTextFieldUtil;



    public class CFla06AppIdCreater extends CContainerWrapper
    {
        public function CFla06AppIdCreater(tcont:DisplayObjectContainer)
        {
            super(tcont);


			//~~~~
			MTextFieldUtil.set_text(_cont, 'tf_1', '');
			_xxyyzz = '{#HobisApp#}yyMMdd{#Work#}hhmmssfff';
			MTextFieldUtil.set_text(_cont, 'tf_2', _xxyyzz);


			TextField(_cont['tf_2']).addEventListener(Event.CHANGE,
				function(evt:Event):void {
					_xxyyzz = MTextFieldUtil.get_text(_cont, 'tf_2');
				});

			SimpleButton(_cont['bt_1']).addEventListener(MouseEvent.CLICK,
				function(evt:MouseEvent):void {
					var strtm:String = _xxyyzz.replace(_reg1,
						function():String {
							//trace(' ' + arguments);
							//trace(' ' + arguments[1]);
							if (_arr1 == null)
								_arr1 = [];
							_arr1.push(arguments[1]);
							return _reg2.source;
						});
					strtm = MDateFormatter.get_format(strtm);
					//trace(strtm);
					//trace(strtm, _arr1);
					//MTextFieldUtil.set_text(_own, 'tf_1', strtm);
					//trace(MDateFormatter.get_format(_xxyyzz));
					if (_arr1 != null) {
						var i:uint = 0;
						strtm = strtm.replace(_reg2,
							function():String {
								return _arr1[i++];
							});
						_arr1 = null;
					}

					MTextFieldUtil.set_text(_cont, 'tf_1', strtm);
					System.setClipboard(strtm);
				});
        }

		private static const _reg1:RegExp = /\{#([\s\S]+?)#\}/g;
		private static const _reg2:RegExp = /◀◐◑▶/g;

		private var _xxyyzz:String;
		private var _arr1:Array;

    }
}

