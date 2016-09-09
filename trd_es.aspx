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
            q_tables = 's';
            var q_name = "trd";
            var q_readonly = ['txtTax', 'txtNoa', 'txtMoney', 'txtTotal','txtWorker2','txtWorker', 'txtMount','txtStraddr', 'txtEndaddr', 'txtPlusmoney', 'txtMinusmoney', 'txtVccano', 'txtCustchgno','txtAccno','txtAccno2','txtYear2','txtYear1'];
            var q_readonlys = ['txtTranno', 'txtTrannoq','txtTrandate','txtStraddr','txtEndaddr','txtProduct','txtCarno','txtCustorde','txtCaseno','txtMount','txtPrice','txtCustdiscount','txtTotal'];
            var bbmNum = [['txtMoney', 10, 0,1], ['txtTax', 10, 0,1], ['txtTotal', 10, 0,1], ['txtMount', 10, 3,1], ['txtPlusmoney', 10, 0,1], ['txtMinusmoney', 10, 0,1]];
            var bbsNum = [ ['txtOverweightcost', 10, 0,1], ['txtOthercost', 10, 0,1], ['txtMount', 10, 3,1], ['txtPrice', 10, 3,1], ['txtTotal', 10, 0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;
            aPop = new Array();
			
			function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
               	//小數 可能會有問題需注意
                var t_money = 0,t_mount = 0;
                for ( i = 0; i < q_bbsCount; i++) {
                    t_money = q_add(t_money,q_float('txtTotal_' + i));
                    t_mount = q_add(t_mount,q_float('txtMount_' + i));
                }
				var t_plusmoney = q_float('txtPlusmoney');
				var t_minusmoney = q_float('txtMinusmoney');
				var t_tax = q_float('txtTax'); 
				
				var t_total = q_add(q_sub(q_add(t_money,t_plusmoney),t_minusmoney),t_tax);
               
                $('#txtMoney').val(FormatNumber(t_money));
                $('#txtTotal').val(FormatNumber(t_total));
                $('#txtMount').val(FormatNumber(t_mount));
            }
            
            $(document).ready(function() {
                //q_bbsShow = -1;
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
            	//DH  有起點、迄點
        		aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
		            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
		            , ['txtStraddrno', '', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b2.aspx']
		            , ['txtEndaddrno', '', 'addr', 'noa,addr', 'txtEndaddrno,txtEndaddr', 'addr_b2.aspx']
		            , ['txtBoatno', 'lblBoat', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']);
            	
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtBdate', r_picd], ['txtEdate', r_picd], ['txtBtrandate', r_picd], ['txtEtrandate', r_picd], ['txtVccadate', r_picd]];
                q_mask(bbmMask);
                
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker();
                $('#lblAccno').click(function() {
                	if($('#txtYear1').val().length>0)
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtYear1').val()+ '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                $('#lblAccno2').click(function() {
                	if($('#txtYear2').val().length>0)
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtYear2').val()+ '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
				$('#lblCustchgno').click(function(e){
					var t_where = "1!=1";
					var t_custchgno = $('#txtCustchgno').val().split(',');
					for(var i in t_custchgno){
						if(t_custchgno[i].length>0)
							t_where += " or noa='"+t_custchgno[i]+"'";
					}
					q_box("custchg_ds.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno, 'custchg', "95%", "95%", q_getMsg("popCustchg"));
				});
                $('#lblVccano').click(function() {
                	var t_where = "where=^^ noa='"+$('#txtCustno').val()+"' ^^";
                	q_gt('cust', t_where, 0, 0, 0, "");
                });
                
                $('#btnImport').click(function(e){
                	$('#divImport').show();
                });
                $('#btnCancel_import').click(function(e){
                	$('#divImport').hide();
                });
               	$('#btnImport_trans').click(function(e){
               		var t_noa = $.trim($('#txtNoa').val());
                	var t_custno = $.trim($('#txtCustno').val());
                	var t_bdate =$.trim($('#txtBdate_import').val());
                	var t_edate =$.trim($('#txtEdate_import').val());
                	var t_where ='';
                	q_box("trd_es_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where+";"+";"+JSON.stringify({noa:t_noa,custno:t_custno,bdate:t_bdate,edate:t_edate}), "trd_es", "95%", "95%", '');
               	});	
                $("#btnCustchg").click(function(e) {
                	Lock(1,{opacity:0});
                    if ($('#txtCustno').val().length == 0) {
                        alert('請輸入客戶編號!');
                        Unlock(1);
                        return;
                    }
                    t_custchgno = 'custchgno=' + $('#txtCustchgno').val();
                    t_where = "  custno='" + $('#txtCustno').val() + "' and  (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
                    q_box("custchg_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_custchgno + ";", 'custchg', "95%", "650px", q_getMsg('popCustchg'));
                });
                $("#btnVcca").click(function(e) {
                    Lock(1,{opacity:0});
                    if ($('#txtCustno').val().length == 0) {
                        alert('請輸入客戶編號!');
                        Unlock(1);
                        return;
                    }
                    t_vccano = 'vccano=' + $('#txtVccano').val();
                    /*未請款發票才抓*/
                    t_where = "  buyerno='" + $('#txtCustno').val() + "' and (trdno='" + $('#txtNoa').val() + "' or len(isnull(trdno,''))=0) ";
                    q_box("vcca_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";;" + t_vccano + ";", 'vcca1', "95%", "650px", q_getMsg('popVcca'));
                });
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
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
                		var as = _q_appendData("umms", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "",t_paysale=0;
                        	for(var i=0;i<as.length;i++){
                        		t_paysale = parseFloat(as[i].paysale.length==0?"0":as[i].paysale);
                        		if(t_paysale!=0)
                        			t_msg += String.fromCharCode(13)+'收款單號【'+as[i].noa+'】 '+FormatNumber(t_paysale);
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
                	case 'cust':
                		var t_custno2 ='',t_cust2='';
                		var as = _q_appendData("cust", "", true);
                		if(as[0]!=undefined){
                			t_custno2 = as[0].custno2;
                			t_cust2 = as[0].cust2;
                		}
                		var t_where = "";
               		 	var tmp = $('#txtVccano').val().split(',');
                    	for (var i in tmp)
                   			t_where += (t_where.length > 0 ? ' or ' : '') + "noa='" + tmp[i] + "'";
                		q_box("vcca_ds.aspx?"+ r_userno + ";" + r_name + ";" + q_time + ";" + t_where + ";" + r_accy + '_' + r_cno+";ORIGIN=TRD&ORGCUSTNO="+$('#txtCustno').val()+"&CUSTNO2="+t_custno2+"&CUST2="+t_cust2, 'vcca', "95%", "95%", q_getMsg("popVcca"));
                		break;
                    case 'custchg':
                        var as = _q_appendData("custchg", "", true);
                        var t_plusmoney = 0, t_minusmoney = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_plusmoney += parseFloat(as[i].plusmoney);
                            t_minusmoney += parseFloat(as[i].minusmoney);
                        }
                        $('#txtPlusmoney').val(FormatNumber(t_plusmoney));
                        $('#txtMinusmoney').val(FormatNumber(t_minusmoney));
                        sum();
                        Unlock(1);
                        break;
                    case 'vcca1':
                        var as = _q_appendData("vcca", "", true);
                        var t_money = 0, t_tax = 0, t_total = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_money += parseFloat(as[i].money);
                            t_tax += parseFloat(as[i].tax);
                            t_total += parseFloat(as[i].total);
                        }
                        $('#txtTax').val(FormatNumber(t_tax));
                        sum();
                        Unlock(1);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'trd_es':
                        if (b_ret != null) {
                        	as = b_ret;
                    		q_gridAddRow(bbsHtm, 'tbbs', 'txtTrandate,txtProduct,txtStraddr,txtCarno,txtMount,txtPrice,txtTotal,txtOthercost,txtMemo,txtTranaccy,txtTranno,txtTrannoq'
                        	, as.length, as, 'trandate,product,straddr,carno,mount,price,total,tax,memo,accy,noa,noq', 'txtTranno','');             	
                        	sum();
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case 'custchg':
                        if (b_ret != null) {
                            var t_where = '1!=1'; 
                            $('#txtCustchgno').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtCustchgno').val($('#txtCustchgno').val()+($('#txtCustchgno').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('custchg', "where=^^" + t_where + "^^", 0, 0, 0, "");
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case 'vcca1':
                        if (b_ret != null) {
                        	var t_where = '1!=1'; 
                            $('#txtVccano').val('');           
                            for (var i = 0; i < b_ret.length; i++) {
                                $('#txtVccano').val($('#txtVccano').val()+($('#txtVccano').val().length>0?',':'')+b_ret[i].noa);
                                t_where += " or noa='" + b_ret[i].noa + "'";
                            }
                            q_gt('vcca1', "where=^^" + t_where + "^^", 0, 0, 0, "");
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
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var string =  xmlString.split(';');
                if(string[0]!=undefined){
                	abbm[q_recno]['accno'] = string[0];
               		//$('#txtAccno').val(string[0]);
                }
                if(string[1]!=undefined){
                	abbm[q_recno]['year1'] = string[1];
               		//$('#txtYear1').val(string[1]);
                }	
                if(string[2]!=undefined){
                	abbm[q_recno]['accno2'] = string[2];
               		//$('#txtAccno2').val(string[2]);
                }	
                if(string[3]!=undefined){
                	abbm[q_recno]['year2'] = string[3];
               		//$('#txtYear2').val(string[3]);
                }
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				/*if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}*/
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
					return;
				}
				if ($('#txtMon').val().length == 0) {
                    $('#txtMon').val($('#txtDatea').val().substring(0, 6));
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trd') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('trd_ds_s.aspx', q_name + '_s', "600px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))/// 重要
                        continue;
                    $('#txtTranno_'+i).bind('contextmenu',function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        var t_accy = $('#txtTranaccy_'+n).val();
                        var t_noa = $(this).val();
                        if(t_noa.length>0 ){
                            q_box("trans_es.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + t_accy, 'trans', "95%", "95%", q_getMsg("popTrans"));
                        }
                    });
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtCustno').focus();
            }

            function btnModi() {
            	if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnModi',r_accy);
            }

            function btnPrint() {
            	switch(q_getPara('sys.project').toUpperCase()){
            		case 'VA':
            			q_box('z_trd_va.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            			break;
            		case 'DH':
            			q_box('z_trans_dh.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
            			break;
            		default:
            			var t_aspx = r_comp.indexOf('金勇')>=0?'z_trd_at.aspx':'z_trd_ds.aspx';
	            	var t_noa = $('#txtNoa').val();
	                if(t_noa.length>0 ){
	                    q_box(t_aspx+"?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + r_accy, 'trans', "95%", "95%", q_getMsg("popTrans"));
	                }
            			break;	
            	}
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
                    $('#btnImport_trans').removeAttr('disabled');
                    $('#txtDatea').datepicker();
                    $('#txtBdate_import').datepicker();
                    $('#txtEdate_import').datepicker();
                } else {
                    $('#btnImport_trans').attr('disabled', 'disabled');
                    $('#txtDatea').datepicker('destroy');
                    $('#txtBdate_import').datepicker('destroy');
                    $('#txtEdate_import').datepicker('destroy');
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
                var t_where =" where=^^ vccno='"+ $('#txtNoa').val()+"'^^";
                q_gt('umms', t_where, 0, 0, 0, 'btnDele',r_accy);
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
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
            }
            .tbbm .tdZ {
                width: 1%;
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
            .dbbs {
                width: 1200px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
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
					<td><span> </span><a style="float:right; color: blue; font-size: medium;">取貨日期</a></td>
					<td colspan="4">
					<input id="txtBdate_import"  type="text" style="float:left; width:100px; font-size: medium;"/>
					<span style="float:left; display:block; width:25px;"><a>～</a></span>
					<input id="txtEdate_import"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr style="height:35px;">
					<td> </td>
					<td><input id="btnImport_trans" type="button" value="匯入"/></td>
					<td> </td>
					<td> </td>
					<td><input id="btnCancel_import" type="button" value="關閉"/></td>
				</tr>
			</table>
		</div>
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewComp"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewMoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewPlusmoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewMinusmoney"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewTax"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewTotal"> </a> </td>
						<td align="center" style="width:70px; color:black;"><a id="vewMount"> </a> </td>
						<td align="center" style="width:100px; color:black;"><a id="vewVccano"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewUnpay"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="money,0,1" style="text-align: right;">~money,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="tax,0,1" style="text-align: right;">~tax,0,1</td>
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="vccano,10" style="text-align: left;" >~vccano,10</td>
						<td id="unpay,0,1" style="text-align: right;">~unpay,0,1</td>
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno" type="text"  style='width:30%; float:left;'/>
							<input id="txtComp" type="text"  style='width:70%; float:left;'/>
							<input id="txtNick" type="text"  style="display:none;"/>
						</td>
					</tr>
					<tr class="trX">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><input type="button" id="btnImport" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trY">
						<td><span> </span><a id="lblCustchgno" class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtCustchgno" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnCustchg" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr class="trY">
						<td><span> </span><a id="lblVccano" class="lbl btn"> </a></td>
						<td colspan="5"><input id="txtVccano" type="text" class="txt c1"/></td>
						<td> </td>
						<td><input type="button" id="btnVcca" class="txt c1"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno" type="text"  class="txt" style="float: left; width:25%;"/>
							<input id="txtAcomp" type="text"  class="txt"  style="float: left; width:75%;"/>
						</td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text"  class="txt c1 num"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno" class="lbl btn"> </a></td>
						<td><input id="txtAccno" type="text"  class="txt c1"/></td>
						<td><input id="txtYear1" type="text"  class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td><input id="txtAccno2" type="text"  class="txt c1"/> </td>
						<td><input id="txtYear2" type="text"  class="txt c1"/> </td>
					</tr>
					
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;"><input class="btn" id="btnPlus" type="button" value='+' style="font-weight: bold;"/></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;">取貨日期</td>
					<td align="center" style="width:100px;">拖運物品</td>
					<td align="center" style="width:100px;">區域</td>
					<td align="center" style="width:100px;">車牌</td>
					<!--<td align="center" style="width:100px;">才數</td>-->
					<!--<td align="center" style="width:100px;">件數</td>-->
					<!--<td align="center" style="width:100px;">板數</td>-->
					<!--<td align="center" style="width:100px;">KG</td>-->
					<td align="center" style="width:80px;">數量</td>
					<td align="center" style="width:80px;">單價</td>
					<td align="center" style="width:80px;">應收金額</td>
					<td align="center" style="width:80px;">稅額</td>
					<td align="center" style="width:100px;">備註</td>
					<td align="center" style="width:100px;">出車單號</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td><td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;"/></td>
					<td><input type="text" id="txtProduct.*" style="width:95%;"/></td>
					<td><input type="text" id="txtStraddr.*" style="width:95%;"/></td>
					<td><input type="text" id="txtCarno.*" style="width:95%;"/></td>
					<!--<td><input type="text" id="txtCount1.*" style="width:95%;"/></td>-->
					<!--<td><input type="text" id="txtCount2.*" style="width:95%;"/></td>-->
					<!--<td><input type="text" id="txtCount3.*" style="width:95%;"/></td>-->
					<!--<td><input type="text" id="txtCount4.*" style="width:95%;"/></td>-->
					<td><input type="text" id="txtMount.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtTotal.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtOthercost.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtTranno.*" style="float:left; width: 95%;"/>
						<input type="text" id="txtTrannoq.*" style="float:left;display:none;"/>
						<input type="text" id="txtTranaccy.*" style="float:left;display:none;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
