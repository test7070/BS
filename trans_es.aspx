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
			var q_name = "trans";
			var q_readonly = ['txtTotal','txtTotal2','txtNoa','txtWorker','txtWorker2'];
			var bbmNum = [['txtMount',10,2,1],['txtPrice',10,2,1],['txtTotal',10,0,1]
			,['txtMount2',10,2,1],['txtPrice2',10,2,1],['txtPrice3',10,2,1],['txtTotal2',10,0,1]
			];
			var bbmMask = [['txtDatea','999/99/99'],['txtTrandate','999/99/99'],['txtMon','999/99'],['txtMon2','999/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
            q_xchg = 1;
            brwCount2 = 15;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
			,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,ext,post,addr_fact,salesno,sales', 'txtCustno,txtComp,txtNick,txtStraddrno,txtStraddr,txtSaddr,txtDriverno,txtDriver', 'cust_b.aspx']
			,['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
			,['txtUccno', 'lblXproduct', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx']
			,['txtSalesno', 'lblXsales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx']
			,['txtStraddrno', 'lblXstraddr', 'addr3', 'noa,namea', 'txtStraddrno,txtStraddr', 'addr3_bs_b.aspx'] 
			,['txtCardealno', 'lblCardeal', 'acomp', 'noa,acomp', 'txtCardealno,txtCardeal', 'acomp_b.aspx']
			);
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				q_mask(bbmMask);
                
				$("#txtStraddrno").focus(function() {
					var input = document.getElementById ("txtStraddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
		                input.selectionEnd = $(input).val().length;
		            }
				});
				
				$('#txtTrandate').change(function(e){
					getDriverprice();
					getPrice();
				});
				
				$('#txtMount').change(function(e){
					sum();
				});
				$('#txtPrice').change(function(e){
					sum();
				});
				$('#txtPrice3').change(function(e){
					sum();
				});
				$('#txtCustdiscount').change(function(e){
					sum();
				});
				$('#txtMount2').change(function(e){
					sum();
				});
				$('#txtPrice2').change(function(e){
					sum();
				});
			}

			function sum() {
				if(q_cur!=1 && q_cur!=2)
					return;
				var mount1=q_float('txtMount');
				var price1=q_float('txtPrice');
				var mount2=q_float('txtMount2');								
				var price2=q_float('txtPrice2');
				var price3=q_float('txtPrice3');
				var discount=q_float('txtDiscount');
				var total = round(q_mul(mount1,price1),0);
				var total2 = round(q_mul(q_mul(mount2,q_add(price2,price3)),discount),0);	
				$('#txtTotal').val(total);
				$('#txtTotal2').val(total2);
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
						getPrice();
						break;
					case 'txtCustno':
						getPrice();
						break;
					case 'txtStraddrno':
                        getDriverprice();
                    case 'txtUccno':
                        getDriverprice();
                        getPrice();
						break;
				}
			}
			function getPrice(){
				t_custno = $.trim($('#txtCustno').val());
				t_custno  = t_custno .length>0?t_custno:'#none';
				t_productno = $.trim($('#txtUccno').val());
				t_trandate = $.trim($('#txtTrandate').val());
				Lock(1, {opacity : 0});
				q_func('qtxt.query.trans_bs_getPrice', 'trans_bs.txt,getPrice,' + encodeURI(t_custno) + ';' + encodeURI(t_productno)+ ';' + encodeURI(t_trandate));
			}
			
			function getDriverprice(){
				t_addrno = $.trim($('#txtStraddrno').val());
				t_addrno = t_addrno.length>0?t_addrno:'#none';
				t_productno = $.trim($('#txtUccno').val());
				t_trandate = $.trim($('#txtTrandate').val());
				Lock(1, {opacity : 0});
				q_func('qtxt.query.trans_bs', 'trans_bs.txt,getDriverprice,' + encodeURI(t_addrno) + ';' + encodeURI(t_productno)+ ';' + encodeURI(t_trandate));
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.trans_bs_resetDate':
                		console.log('trans_bs_resetDate');
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            console.log(as[0].msg);
                        }
                        Unlock(1);
                		break;
                	case 'qtxt.query.trans_bs_getPrice':
                        var as = _q_appendData("tmp0", "", true, true);
                        /*if (as[0] != undefined) {
                            $('#txtPrice').val(as[0].price);
                            $('#txtPrice3').val(as[0].price2);
                        }
                        else{
                            $('#txtPrice').val(0);
                            $('#txtPrice3').val(0);
                        }*/
                        sum();
                        Unlock(1);
                        break;
                    case 'qtxt.query.trans_bs':
                        var as = _q_appendData("tmp0", "", true, true);
                        /*if (as[0] != undefined) {
                            $('#txtPrice2').val(as[0].price);
                        }
                        else{
                            $('#txtPrice2').val(0);
                        }*/
                        sum();
                        Unlock(1);
                        break;
                }
            }
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('trans_es_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				sum();
			}
			function btnPrint() {
				switch(q_getPara('sys.project').toUpperCase()){
					default:
						q_box('z_trans_bs.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
						break;
				}
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
                /*switch(q_getPara('sys.project').toUpperCase()=='DH'){
                	default:
                		Lock(1,{opacity:0});
                		//清空叫收日期
               	 		q_func('qtxt.query.trans_bs_resetDate', 'trans_bs.txt,resetDate,' + encodeURI($('#txtNoa').val()));
            			break;
            	}*/
            }
			function btnOk() {
				Lock(1,{opacity:0});
				//日期檢查
				if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
					alert('取貨日期異常。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert('回單日期異常。');
            		Unlock(1);
            		return;
				}
				
				
				if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!");
                }
                sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				
				/*if(q_getPara('sys.project').toUpperCase() == 'DH'){
					$('.DH').hide();
					$('#vewStraddr').text('起點');
					$('#viewMount').text('數量');
					$('#viewPrice').text('單價');
				}*/
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
					$('#txtTrandate').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
					$('#txtTrandate').datepicker();
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
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
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1400px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;">取貨日期</td>
						<td align="center" style="width:80px; color:black;">回單日期</td>
						<td align="center" style="width:80px; color:black;">客戶</td>
						<td align="center" style="width:80px; color:black;">區域</td>
						<td align="center" style="width:80px; color:black;">司機</td>
						<td align="center" style="width:80px; color:black;">品名</td>
						<td align="center" style="width:80px; color:black;">數量</td>
						<td align="center" style="width:80px; color:black;">單位</td>
						<td align="center" style="width:80px; color:black;">單價</td>
						<td align="center" style="width:80px; color:black;">客戶金額</td>
						<td align="center" style="width:80px; color:black;">司機數量</td>
						<td align="center" style="width:80px; color:black;">司機單價</td>
						<td align="center" style="width:80px; color:black;">司機金額</td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="product" style="text-align: center;">~product</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="unit" style="text-align: right;">~unit</td>
						<td id="price" style="text-align: right;">~price</td>
						<td id="total" style="text-align: right;">~total</td>
						<td id="mount2" style="text-align: right;">~mount2</td>
						<td id="price2" style="text-align: right;">~price2</td>
						<td id="total2" style="text-align: right;">~total2</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblXtrandate" class="lbl">取貨日期</a></td>
						<td><input id="txtTrandate"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblXdatea" class="lbl">回單日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblXsales" class="lbl btn">業務</a></td>
						<td colspan="3">
							<input id="txtSalesno"  type="text" style="float:left;width:30%;"/>
							<input id="txtSales"  type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblXproduct" class="lbl btn">拖運物品</a></td>
						<td colspan="3">
							<input id="txtUccno"  type="text" style="float:left;width:30%;"/>
							<input id="txtProduct"  type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblXstraddr" class="lbl btn">區域</a></td>
						<td colspan="3">
							<input id="txtStraddrno"  type="text" style="float:left;width:30%;"/>
							<input id="txtStraddr"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblSaddr" class="lbl">取貨地點</a></td>
						<td colspan="3"><input id="txtSaddr"  type="text" style="float:left;width:100%;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
							<input id="txtDriver"  type="text" style="float:left;width:50%;"/>
						</td>
						<td> </td>
						<td><span> </span><a id="lblXdtime" class="lbl">取貨時間</a></td>
						<td><input id="txtDtime"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">才數</a></td>
						<td><input id="txtMount3"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">件數</a></td>
						<td><input id="txtMount4"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">板數</a></td>
						<td><input id="txtStatus"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">KG</a></td>
						<td><input id="txtWeight"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr style="background-color: #B18904;">
						<td><span> </span><a class="lbl">數量</a></td>
						<td><input id="txtMount"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">單價</a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">應收金額</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">稅額</a></td>
                        <td><input id="txtReserve" type="text" class="txt c1 num"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a id="lblMount2" class="lbl"> </a></td>
						<td><input id="txtMount2"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">司機運費</a></td>
						<td>
							<input id="txtPrice2"  type="text" class="txt c1 num"/>
							<input id="txtPrice3"  type="text" class="txt c1 num" style="display:none;"/>
						</td>
						<td><span> </span><a class="lbl">折扣</a></td>
						<td><input id="txtDiscount"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">司機淨付額</a></td>
                        <td><input id="txtTotal2"  type="text" class="txt c1 num"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblXaaddr" class="lbl">卸貨地點</a></td>
						<td colspan="3"><input id="txtAaddr" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAddressee" class="lbl">卸貨地址</a></td>
						<td colspan="3"><input id="txtAddressee" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblXstime" class="lbl">卸貨時間</a></td>
						<td><input id="txtStime" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblXsender" class="lbl">卸貨連絡人</a></td>
						<td colspan="2"><input id="txtSender" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblXstel" class="lbl">卸貨連絡電話</a></td>
						<td colspan="2"><input id="txtStel" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo"  type="text" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
							<input id="txtNoq"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
