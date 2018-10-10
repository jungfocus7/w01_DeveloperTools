package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.system.System;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MStringUtil;
    import jhb0b.utils.MTextFieldUtil;


    public class CFla01UrlEncoder extends CContainerWrapper
    {
        public function CFla01UrlEncoder(tcont:DisplayObjectContainer)
        {
            super(tcont);


            MTextFieldUtil.set_text(_cont, 'tf_1', 'https://www.youtube.com/watch?v=tj0KZZRqpn8');
            MTextFieldUtil.clear_text(_cont, 'tf_2');

            SimpleButton(_cont['bt_1']).addEventListener(MouseEvent.CLICK, pp_bt_1_cl);
            SimpleButton(_cont['bt_2']).addEventListener(MouseEvent.CLICK, pp_bt_2_cl);
            SimpleButton(_cont['bt_3']).addEventListener(MouseEvent.CLICK, pp_bt_3_cl);
            SimpleButton(_cont['bt_4']).addEventListener(MouseEvent.CLICK, pp_bt_4_cl);

            // _stage.addEventListener(KeyboardEvent.KEY_DOWN,
            //     function(evt:KeyboardEvent):void
            //     {
            //         if (evt.ctrlKey)
            //         {
            //             var tkc:uint = evt.keyCode;
            //             if (tkc == Keyboard.E)
            //             {
            //                 pp_bt_1_cl(null);
            //             }
            //             else
            //             if (tkc == Keyboard.D)
            //             {
            //                 pp_bt_2_cl(null);
            //             }
            //             evt.preventDefault();
            //         }
            //     });
        }


        //:: Encoding
        private function pp_bt_1_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_1');
            ttxt = encodeURIComponent(ttxt);
            if (ttxt == null)
                MTextFieldUtil.set_text(_cont, 'tf_2', 'Error');
            else
                MTextFieldUtil.set_text(_cont, 'tf_2', ttxt);
        }

        //:: Decoding
        private function pp_bt_2_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_1');
            ttxt = decodeURIComponent(ttxt);
            if (ttxt == null)
                MTextFieldUtil.set_text(_cont, 'tf_2', 'Error');
            else
                MTextFieldUtil.set_text(_cont, 'tf_2', ttxt);
        }

        //:: ▲Copyup
        private function pp_bt_3_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_2');
            if (!MStringUtil.is_empty(ttxt))
                MTextFieldUtil.set_text(_cont, 'tf_1', ttxt);
        }

        //:: Cliboard
        private function pp_bt_4_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_2');
            System.setClipboard(ttxt);
        }

    }
}

