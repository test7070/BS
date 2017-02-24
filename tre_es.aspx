<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">

            q_tables = 's';
            var q_name = "tre";
            var q_readonly = ['txtCarchgno','txtAccno', 'txtNoa', 'txtMoney', 'txtTotal', 'txtWorker2', 'txtWorker', 'txtRc2ano', 'txtPaydate', 'txtPlusmoney', 'txtMinusmoney', 'txtAccno', 'txtAccno2', 'txtYear2', 'txtYear1'];
            var q_readonlys = ['txtOrdeno', 'txtTranno', 'txtTrannoq'];
            var bbmNum = [['txtMoney', 10, 0], ['txtTotal', 10, 0], ['txtPlusmoney', 10, 0], ['txtMinusmoney', 10, 0]];
            var bbsNum = [['txtMount', 10, 3], ['txtPrice', 10, 3], ['txtDiscount', 10, 3], ['txtMoney', 10, 0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            aPop = new Array();

            q_xchg = 1;
            brwCount2 = 20;

            function tre() {
            }


            tre.prototype = {
                isLoad : false,
                carchgno : new Array()
            };
            
            function sum(){
            	
            }

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
                bbmMask = [['txtDatea_import', r_picd],['txtBdate_import', r_picd], ['txtEdate_import', r_picd],['txtDatea', r_picd], ['txtDate2', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtPaydate', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);

                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val() + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                });

                $('#txtPlusmoney').change(function(e) {
                    sum();
                });
                $('#txtMinusmoney').change(function(e) {
                    sum();
                });
                /*$('#btnTrans').click(function(e) {
                    if (q_cur != 1 && q_cur != 2) {
                        if (r_accy.substring(0, 3) != $('#txtDate2').val().substring(0, 3)) {
                            alert('年度異常!');
                            return;
                        }
                        Lock(1, {
                            opacity : 0
                        });
                        q_func('tre.import_ds', r_accy + ',' + $('#cmbCarteamno').val() + ',' + $('#txtBdate').val() + ',' + $('#txtEdate').val() + ',' + $('#txtDate2').val() + ',' + r_name);
                    }
                });*/
                $("#btnCarchg").click(function(e) {
                	Lock(1,{opacity:0});
                	/*if ($('#txtCarno').val().length == 0) {
                        alert('請輸入車牌!');
                        Unlock(1);
                        return;
                    }*/
                    if ($('#txtDriverno').val().length == 0) {
                        alert('請輸入司機!');
                        Unlock(1);
                        return;
                    }
                    
                    t_carchgno = 'carchgno=' + $('#txtCarchgno').val();
                    t_where = " driverno='" + $('#txtDriverno').val() + "' and  (treno='" + $('#txtNoa').val() + "' or len(isnull(treno,''))=0) ";
                    q_box("carchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_carchgno + ";", 'carchg', "95%", "650px", q_getMsg('popCarchg'));  
                });
                $('#lblCarchgno').click(function(e){
					var t_where = "1!=1";
					var t_carchgno = $('#txtCarchgno').val().split(',');
					for(var i in t_carchgno){
						if(t_carchgno[i].length>0)
							t_where += " or noa='"+t_carchgno[i]+"'";
					}
					q_box("carchg_ds.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'carchg', "95%", "95%", q_getMsg("popCarchg"));
				});
				//-----------------------------------------------
                $('#divImport').mousedown(function(e) {
                    if (e.button == 2) {
                        $(this).data('xtop', parseInt($(this).css('top')) - e.clientY);
                        $(this).data('xleft', parseInt($(this).css('left')) - e.clientX);
                    }
                }).mousemove(function(e) {
                    if (e.button == 2 && e.target.nodeName != 'INPUT') {
                        $(this).css('top', $(this).data('xtop') + e.clientY);
                        $(this).css('left', $(this).data('xleft') + e.clientX);
                    }
                }).bind('contextmenu', function(e) {
                    if (e.target.nodeName != 'INPUT')
                        e.preventDefault();
                });

                $('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#txtDatea_import').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                $('#btnImport_trans').click(function() {
                   if(q_cur != 1 && q_cur != 2){
                   		var t_key = q_getPara('sys.key_tre');
                   		var t_date = $('#textDate').val();//登錄日期
                   		var t_bdate = $('#textBdate').val();
                   		var t_edate = $('#textEdate').val();
                   		var t_carno = $('#textCarno').val();
                   		var t_driverno = $('#textDriverno').val();
                   		
                   		t_key = (t_key.length==0?'BJ':t_key);//一定要有值
                   		q_func('qtxt.query.tre_es', 'tre_es.txt,import,' + encodeURI(t_key) + ';'+ encodeURI(t_date) + ';'+ encodeURI(t_bdate) + ';' + encodeURI(t_edate)+ ';' + encodeURI(t_carno)+ ';' + encodeURI(t_driverno));
                	}
                });
                $('#textDate').keydown(function(e) {
                    if (e.which == 13)
                        $('#textBdate').focus();
                });
                $('#textBdate').keydown(function(e) {
                    if (e.which == 13)
                        $('#textEdate').focus();
                });
                $('#textEdate').keydown(function(e) {
                });
                $('#textDate').datepicker();
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.tre_es':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	alert(as[0].msg);
                        	location.reload();
                        } else {
                        }
                		break;
                    default:
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'carchg':
                        if (b_ret != null) {
                            var t_where = '1!=1';
                            $('#txtCarchgno').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtCarchgno').val($('#txtCarchgno').val()+($('#txtCarchgno').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('carchg', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("pays", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'付款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
                        	}
                        	if(t_msg.length>0){
                        		alert('已沖帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnModi();
		                sum();
		                Unlock(1);
		                $('#txtDatea').focus();
                		break;
                    case 'carchg':
                        var as = _q_appendData("carchg", "", true);
                        var t_plusmoney = 0, t_minusmoney = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_plusmoney += parseFloat(as[i].plusmoney);
                            t_minusmoney += parseFloat(as[i].minusmoney);
                        }
                        $('#txtPlusmoney').val(t_plusmoney);
                        $('#txtMinusmoney').val(t_minusmoney);
                        sum();
                        Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tre_es_s.aspx', q_name + '_s', "530px", "530px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var ix = 0; ix < q_bbsCount; ix++) {
                    $('#lblNo_' + ix).text(ix + 1);
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
            	q_box('z_trans_es.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['tranno']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (q_cur == 1 || q_cur == 2) {
                    $('#btnCarchg').removeAttr('disabled');
                    $('#btnImport').attr('disabled','disabled');
                	$('#divImport').hide();
                } else {
                    $('#btnCarchg').attr('disabled', 'disabled');
                    $('#btnImport').removeAttr('disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                Lock(1,{opacity:0});
                var t_where =" where=^^ rc2no='"+ $('#txtNoa').val()+"'^^";
                q_gt('pays', t_where, 0, 0, 0, 'btnDele',r_accy);
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
                width: 950px;
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
                width: 10%;
            }
            .tbbm .tr1 {
                background-color: #FFEC8B;
            }
            .tbbm .tr_carchg {
                background-color: #DAA520;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 1500px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
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
		<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblDatea_import" style="float:right; color: blue; font-size: medium;"> </a></td>
					<td colspan="4">
					<input id="textDate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblDate_import" style="float:right; color: blue; font-size: medium;"> </a></td>
					<td colspan="4">
					<input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					<span style="float:left; display:block; width:25px;"><a>～</a></span>
					<input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblCarno_import" style="float:right; color: blue; font-size: medium;">車牌</a></td>
					<td colspan="4">
						<input id="textCarno"  type="text" style="float:left; width:225px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblDriverno_import" style="float:right; color: blue; font-size: medium;"> </a></td>
					<td colspan="4">
						<input id="textDriverno"  type="text" style="float:left; width:225px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td> </td>
					<td><input id="btnImport_trans" type="button" value="匯入"/></td>
					<td></td>
					<td></td>
					<td><input id="btnCancel_import" type="button" value="關閉"/></td>
				</tr>
			</table>
		</div>
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTotal'> </a></td>
						<td align="center" style="width:80px; color:black;">廠商</td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="tggno" style="text-align: center;">~tggno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr name="schema" style="height:1px;">
						<td> </td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td><input id="txtCarno" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><input id="btnImport" type="button" class="txt c1" value="匯入"/></td>
					</tr>
					<tr class="tr_carchg">
						<td><span> </span><a id="lblCarchgno" class="lbl btn"> </a></td>
						<td colspan="7"><input id="txtCarchgno" type="text" class="txt c1"/></td>
						<td><input type="button" id="btnCarchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>			
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTggno" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text"  class="txt" style="width:40%;"/>
							<input id="txtTgg" type="text"  class="txt" style="width:60%;"/>
						</td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="6"><input id="txtMemo" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						<td><input id="txtYear1" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text"  class="txt c1"/></td>
						<td><input id="txtYear2" type="text"  class="txt c1"/></td>
						<td></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:100px;"><a id='lblTrandate_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDriver_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCustno_s'> </a></td>

					<td align="center" style="width:200px;"><a id='lblStraddr_s'> </a></td>
					<td align="center" style="width:200px;display:none;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;display:none;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDiscount_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:170px;"><a id='lblTranno_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtDriver.*" style="width:95%;" />
						<input type="text" id="txtDriverno.*" style="display:none;" />
					</td>
					<td><input type="text" id="txtComp.*" style="width:95%;" /></td>
					<td><input type="text" id="txtStraddr.*" style="width:95%;" /></td>
					<td style="display:none;"><input type="text" id="txtProduct.*" style="width:95%;" /></td>
					<td style="display:none;"><input type="text" id="txtMount.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtDiscount.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtMoney.*" style="width:95%;text-align: right;" /></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtTranaccy.*" style="display:none"/>
						<input type="text" id="txtTranno.*" style="float:left; width: 95%;"/>
						<input type="text" id="txtTrannoq.*" style="display:none"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>