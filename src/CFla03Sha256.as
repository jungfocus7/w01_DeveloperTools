package
{
    import flash.display.DisplayObjectContainer;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.system.System;
    import flash.utils.ByteArray;

    import jhb0b.core.CContainerWrapper;
    import jhb0b.utils.MTextFieldUtil;

    import mx.utils.SHA256;



    public class CFla03Sha256 extends CContainerWrapper
    {
        public function CFla03Sha256(tcont:DisplayObjectContainer)
        {
            super(tcont);


            MTextFieldUtil.set_text(_cont, 'tf_1', 'https://www.youtube.com/watch?v=tj0KZZRqpn8');
            MTextFieldUtil.clear_text(_cont, 'tf_2');

            SimpleButton(_cont['bt_1']).addEventListener(MouseEvent.CLICK, pp_bt_1_cl);
        	// SimpleButton(_own['bt_2']).addEventListener(MouseEvent.CLICK, pp_bt_2_cl);
        	// SimpleButton(_own['bt_3']).addEventListener(MouseEvent.CLICK, pp_bt_3_cl);
            SimpleButton(_cont['bt_4']).addEventListener(MouseEvent.CLICK, pp_bt_4_cl);

            // _stage.addEventListener(KeyboardEvent.KEY_DOWN,
            //     function(evt:KeyboardEvent):void
            //     {
            //     });
        }


        //:: Encoding
        private function pp_bt_1_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_1');
            var tba:ByteArray = new ByteArray();
            tba.writeUTFBytes(ttxt);
            ttxt = SHA256.computeDigest(tba);
            tba.clear();
            if (ttxt == null)
                MTextFieldUtil.set_text(_cont, 'tf_2', 'Error');
            else
                MTextFieldUtil.set_text(_cont, 'tf_2', ttxt);
        }

        ////:: Decoding
        //private function pp_bt_2_cl(evt:MouseEvent):void
        //{
        //	var ttxt:String = MTextFieldUtil.get_text(_own, 'tf_1');
        //	ttxt = ppBase64Decode(ttxt);
        //	if (ttxt == null)
        //		MTextFieldUtil.set_text(_own, 'tf_2', 'Error');
        //	else
        //		MTextFieldUtil.set_text(_own, 'tf_2', ttxt);
        //}
        //
        ////:: ▲Copyup
        //private function pp_bt_3_cl(evt:MouseEvent):void
        //{
        //	var ttxt:String = MTextFieldUtil.get_text(_own, 'tf_2');
        //	if (!MStringUtil.is_empty(ttxt))
        //		MTextFieldUtil.set_text(_own, 'tf_1', ttxt);
        //}

        //:: Cliboard
        private function pp_bt_4_cl(evt:MouseEvent):void
        {
            var ttxt:String = MTextFieldUtil.get_text(_cont, 'tf_2');
            System.setClipboard(ttxt);
        }

    }
}

