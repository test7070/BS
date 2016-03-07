<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "cust";
            var q_readonly = ['txtWorker'];
            var bbmNum = [];
            var bbmMask = [['txtInvestdate','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtExt', 'lblXpost', 'addr3', 'noa,namea', 'txtExt,txtPost', 'addr3_bs_b.aspx'] 
            	,['txtSalesno', 'lblDriver', 'driver', 'noa,namea', 'txtSalesno,txtSales', 'driver_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                q_mask(bbmMask);
                mainForm(0);
            }

            function mainPost() {
				q_mask(bbmMask);
				
				q_cmbParse("cmbChkstatus", ',01,02,03,04,05,06,07,08,09,10,11,12');
				q_cmbParse("cmbChkdate", ',0@日,1@一,2@二,3@三,4@四,5@五,6@六');
				q_cmbParse("cmbDueday", ',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31');
				
				$('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
                		q_gt('cust', t_where, 0, 0, 0, "checkNoa_change", r_accy);
					}
                });
                $('#txtSerial').change(function() {
                	$(this).val($.trim($(this).val()).toUpperCase());
                	if ($(this).val().length > 0 && checkId($(this).val())!=2){
                		Lock();
	            		alert(q_getMsg('lblSerial')+'錯誤。');
	            		Unlock();
	            	}
                });
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkNoa_change':
                		var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].comp);
                        }
                		break;
                	case 'checkNoa_btnOk':
                		var as = _q_appendData("cust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].comp);
                            Unlock(1);
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('cust_bs_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
				_btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtComp').focus();
            }

            function btnPrint() {
                q_box('z_custtran.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }
             function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	if($('#txtNoa').val().length==0){
            		alert('請輸入編號。');
            		Unlock(1);
            		return;
            	}
            	if ($('#txtSerial').val().length > 0 && checkId($('#txtSerial').val())!=2){
                    alert(q_getMsg('lblSerial')+'錯誤。');
                    Unlock(1);
            		return;
				}
                $('#txtWorker' ).val(r_name);
                if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('cust', t_where, 0, 0, 0, "checkNoa_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
            }
            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtInvestdate').datepicker('destroy');
                } else {	
                    $('#txtInvestdate').datepicker();
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if (q_tables == 's')
                    bbsAssign();
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVXYWZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 250px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 700px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:120px; color:black;"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='nick' style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblx' class="lbl">新編號</a></td>
						<td><input id="txtHead"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td><input id="txtSerial"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblInvestdate' class="lbl">合約到期日 </a></td>
						<td><input id="txtInvestdate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td colspan="3"><input id="txtComp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text"  class="txt c1"/></td>
					</tr>
					
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td colspan="2"><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td colspan="2"><input id="txtMobile" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblCountry' class="lbl">縣市</a></td>
						<td><input id="txtCountry" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblXpost' class="lbl btn">區域</a></td>
						<td>
							<input id="txtExt" type="text" class="txt" style="width:40%;"/>
							<input id="txtPost" type="text" class="txt" style="width:60%;"/>
						</td>
						<td><span> </span><a id='lblXaddr_fact' class="lbl">地址</a></td>
						<td colspan="3"><input id="txtAddr_fact" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">收貨方式</a></td>
						<td><input id="txtTrantype" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDriver' class="lbl btn">司機</a></td>
						<td colspan="2">
							<input id="txtSalesno" type="text" class="txt" style="width:40%;"/> 
							<input id="txtSales" type="text" class="txt" style="width:60%;"/>
						</td>
						
					</tr>
					<tr style="background-color:pink;">
						<td> </td>
						<td colspan="5"><a style="color:black;">方式一、方式二皆有輸入時，以方式一為主。</a></td>
						<td class="tdZ"> </td>
					</tr>
					<tr style="background-color:pink;">
						<td><span> </span><a class="lbl">方式一</a></td>
						<td><span> </span><a class="lbl">收貨週</a></td>
						<td><select id="cmbChkstatus" class="txt c1"> </select></td>
						<td><span> </span><a class="lbl">收貨日</a></td>
						<td><select id="cmbChkdate" class="txt c1"> </select></td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr style="background-color:pink;">
						<td><span> </span><a class="lbl">方式二</a></td>
						<td><span> </span><a class="lbl">收貨日期</a></td>
						<td><select id="cmbDueday" class="txt c1"> </select></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">收貨備註</a></td>
						<td colspan="5"><textarea id="txtInvomemo" style="width:100%; height:50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">客戶備註(一)</a></td>
						<td colspan="5"><textarea id="txtMemo" style="width:100%; height:50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">客戶備註(二)</a></td>
						<td colspan="5"><textarea id="txtMemo2" style="width:100%; height:50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">簽約備註</a></td>
						<td colspan="5"><textarea id="txtInvestMemo" style="width:100%; height:50px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
