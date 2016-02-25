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
			var q_name = "addr2";
			var q_readonly = ['txtNoa'];
			var bbmNum = [['txtPrice',10,2,1]];
			var bbmMask = [['txtDatea','999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
			brwCount2 = 8;
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx']
			,['txtProductno', 'lblProduct', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']	
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
				q_getFormat();
				q_mask(bbmMask);
				document.title = '客戶單價主檔';
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkData_change':
						var as = _q_appendData("addr2", "", true);
						if (as[0] != undefined) {
							alert('已存在 單號【' + as[0].noa + '】' + as[0].cust + '_'+as[0].product+ '_'+as[0].datea+'_'+as[0].price);
						}
						break;
					case 'checkData_btnOk':
						var as = _q_appendData("addr2", "", true);
						if (as[0] != undefined) {
							alert('已存在 單號【' + as[0].noa + '】' + as[0].cust + '_'+as[0].product+ '_'+as[0].datea+'_'+as[0].price);
							Unlock(1);
							return;
						} else {
							var t_noa = trim($('#txtNoa').val());
							if (t_noa.length == 0 || t_noa == "AUTO")
			                    q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
			                else
			                    wrServer(t_noa);
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
				}
			}
			function btnOk() {
				Lock(1,{opacity:0});
				$('#txtCustno').val($.trim($('#txtCustno').val()));
				$('#txtProductno').val($.trim($('#txtProductno').val()));
				if($('#txtCustno').val().length==0){
					alert('請輸入客戶編號!');
					Unlock(1);
					return;
				}
				if($('#txtProductno').val().length==0){
					alert('請輸入物品編號!');
					Unlock(1);
					return;
				}
				t_where = "where=^^ custno='" + $('#txtCustno').val() + "' and productno='" + $('#txtProductno').val()+ "' and datea='" + $('#txtDatea').val() + "'^^";
				q_gt('addr2', t_where, 0, 0, 0, "checkData_btnOk");
				
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
				Unlock(1);
			}
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('addr2_bs_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
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
				$('#txtAddr').focus();
			}
			function btnPrint() {
				//q_box('z_cart.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
			}
			function wrServer(key_value) {
				var i;
				$('#txtNoa').val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}
			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}
			function refreshBbm() {
			}
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
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
        </script>
        <style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 500px;
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
                width: 500px;
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
                width: 10%;
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
            #div_row{
            display:none;
            width:750px;
            background-color: #ffffff;
            position: absolute;
            left: 20px;
            z-index: 50;
            }
            .table_row tr td .lbl.btn {
                color: #000000;
                font-weight: bolder;
                font-size: medium;
                cursor: pointer;
            }
            .table_row tr td .lbl.btn:hover {
                color: #FF8F19;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:130px; color:black;"><a>客戶</a></td>
                        <td align="center" style="width:130px; color:black;"><a>品名</a></td>
                        <td align="center" style="width:100px; color:black;"><a>生效日</a></td>
                        <td align="center" style="width:80px; color:black;"><a>單價</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox" /></td>
                        <td id="cust" style="text-align: center;">~cust</td>
                        <td id="product" style="text-align: center;">~product</td>
                        <td id="datea" style="text-align: center;">~datea</td>
                        <td id="price" style="text-align: center;">~price</td>
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
                        <td class="tdZ"> </td>
                    </tr>
                    <tr> </tr>
                    <tr>
                    	<td><span> </span><a id="lblNoa" class="lbl">編號</a></td>
                        <td><input id="txtNoa" type="text" class="txt t1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCust" class="lbl btn">客戶</a></td>
                        <td colspan="2">
                        	<input id="txtCustno" type="text" class="txt" style="width:50%;"/>
                        	<input id="txtCust" type="text" class="txt" style="width:50%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblProduct" class="lbl btn">品名</a></td>
                        <td colspan="2">
                        	<input id="txtProductno" type="text" class="txt" style="width:50%;"/>
                        	<input id="txtProduct" type="text" class="txt" style="width:50%;"/>
                        </td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblDatea" class="lbl">生效日</a></td>
                        <td><input id="txtDatea" type="text" class="txt t1" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblPrice" class="lbl">單價</a></td>
                        <td><input id="txtPrice" type="text" class="txt t1 num" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <input id="q_sys" type="hidden" />
    </body>
</html>
