package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.system.System;

    import hobis.prepared.MDateFormatter;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MTextFieldUtil;



    public class CFla05TimeStamp extends CContainerWrapper
    {
        public function CFla05TimeStamp(tcont:DisplayObjectContainer)
        {
            super(tcont);





			ppReset();

			_cont.addEventListener(Event.ENTER_FRAME, ppEnterFrame);



			SimpleButton(_cont['bt_1']).addEventListener(MouseEvent.CLICK,
				function(e:MouseEvent):void {
					var strtm:String = MTextFieldUtil.get_text(_cont, 'tf_1');
					MTextFieldUtil.set_text(_cont, 'tf_3', strtm);
					System.setClipboard(strtm);
				});
			SimpleButton(_cont['bt_2']).addEventListener(MouseEvent.CLICK,
				function(e:MouseEvent):void {
					ppReset();
				});
			SimpleButton(_cont['bt_3']).addEventListener(MouseEvent.CLICK,
				function(e:MouseEvent):void {
					ppUpdate();
				});
        }

		private var _xxyyzz:String;


		private function ppReset():void
		{
			MTextFieldUtil.set_text(_cont, 'tf_1', '');
			MTextFieldUtil.set_text(_cont, 'tf_2', 'yyyyMMddhhmmssfff');
			MTextFieldUtil.set_text(_cont, 'tf_3', '');

			_xxyyzz = MTextFieldUtil.get_text(_cont, 'tf_2');
		}

		private function ppUpdate():void
		{
			_xxyyzz = MTextFieldUtil.get_text(_cont, 'tf_2');
		}


		private function ppEnterFrame(e:Event):void
		{
			MTextFieldUtil.set_text(_cont, 'tf_1', MDateFormatter.get_format(_xxyyzz));
		}
    }
}

