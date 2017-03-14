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
			var q_readonly = ['txtTotal','txtTotal2','txtWorker','txtWorker2','txtReserve','txtCustdiscount','txtOverw'];
			var bbmNum = [['txtMount',10,2,1],['txtPrice',10,2,1],['txtTotal',10,0,1],['txtWeight',10,0,1]
			,['txtMount2',10,2,1],['txtPrice2',10,2,1],['txtPrice3',10,2,1],['txtTotal2',10,0,1]
			];
			var bbmMask = [['textDate','999/99/99'],['txtDatea','999/99/99'],['txtTrandate','999/99/99'],['txtMon','999/99'],['txtMon2','999/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'trandate';
			//q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
			,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,ext,post,addr_fact', 'txtCustno,txtComp,txtNick,txtStraddrno,txtStraddr,txtSaddr,cmbShip', 'cust_b.aspx']
			,['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
			,['txtStraddrno', 'lblXstraddr', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b.aspx'] 
			,['txtCardealno', 'lblCardeal', 'acomp', 'noa,acomp', 'txtCardealno,txtCardeal', 'acomp_b.aspx']
			, ['txtSaddr', '', 'view_road', 'memo', '0txtSaddr', 'road_b.aspx']
			,['textCustno_modi', '', 'cust', 'noa,comp,nick', 'textCustno_modi', 'cust_b.aspx']
			);
        	
        	isSave = false;
        	
        	function calcTotal2(){
        		
        	}
        	function sum() {
				if(q_cur!=1 && q_cur!=2)
					return;
				if(q_float('txtMount')==0)	
					$('#txtMount').val(1);
				if(q_float('txtMount2')==0)	
					$('#txtMount2').val(1);	
				
				var t_driverno = $.trim($('#txtDriverno').val());
            	if(t_driverno.length==0){
            		if($('#txtMemo').val().substring(0,1)!='*')
            			$('#txtDiscount').val(1);
            		sum1();
            	}
            	else{
            		q_gt('driver', "where=^^ noa='"+t_driverno+"' ^^", 0, 0, 0, "getDriver");
            	}
			}
			function sum1(){
				var mount1=q_float('txtMount');
				var price1=q_float('txtPrice');								
				var total = round(q_mul(mount1,price1),0);
				$('#txtTotal').val(total);
				
				var t_date  = $.trim($('#txtTrandate').val());
				var t_addrno  = $.trim($('#txtStraddrno').val());
				var t_weight  = q_float('txtWeight');
				$('#txtCustdiscount').val(0);
				$('#txtOverw').val(0);
				if(q_getPara('sys.project').toUpperCase()=='ES' && (t_addrno=='N01' || t_addrno=='C01' || t_addrno=='S01')){
					q_gt('tranmoney_es', "where=^^['"+t_date+"','"+t_addrno+"',"+t_weight+")^^", 0, 0, 0, "tranmoney_es");
				}else if(q_getPara('sys.project').toUpperCase()=='ES' && t_addrno=='T01'){
					q_gt('tranmoney_es', "where=^^['"+t_date+"','"+t_addrno+"',"+t_weight+")^^", 0, 0, 0, "tranmoney_es_T01");
				}else{
					sum2();
				}
			}
			function sum2(){
				/*
        		外車司機 : 現收扣一成  現發扣2成(稅金要再還給司機的)  月結＆回收都是扣2成
				EX: 運費報價2000
				司機收現金2000, 實際要扣200, 司機實拿1800
				司機收2100(含發票)  實際要扣400, 司機實拿1700
				司機沒有收錢(月結＆回收)  實際要扣400, 司機實拿1600
				*/
				/*
				自家司機: 只有2種扣佣方式
				1. 3/7分-->運費2000, 給司機600 (2000*0.3)    公司70%  司機30%
				2. 5/5分-->運費-油費-ETC費用後, 司機公司對半(公司50%  司機50%)
				3. 固定薪資-->輸入資料時, 司機運費和司機淨付額=客戶運費, 不另外扣成
				*/
				if($('#cmbRs').val()=='Y'){
					$('#txtReserve').val(round(q_mul(q_float('txtTotal'),parseFloat(q_getPara('sys.taxrate')))/100,0));
				}else{
					$('#txtReserve').val(0);
				}
				var t_total2 = 0;
				t_total2 = round(q_mul(q_add(q_float('txtPrice2'),q_float('txtPrice3')),q_float('txtMount2')),0);
				t_total2 = round(q_mul(t_total2,q_float('txtDiscount')),0);
        		if($('#txtCalctype').val().indexOf('公司車')<0 && $('#cmbShip').val()=='現金' && $('#cmbRs').val()=='Y' ){
        			t_total2 = round( q_add(t_total2,q_float('txtReserve')),0);
        		}
        		$('#txtTotal2').val(t_total2);
				//判斷是不是由BTNOK觸發
				if(isSave){
					var t_noa = trim($('#txtNoa').val());
					var t_date = trim($('#txtTrandate').val());
					if (t_noa.length == 0 || t_noa == "AUTO")
						q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
					else
						wrServer(t_noa);	
				}
			}
			
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				var date = new Date();
				date.setMonth(date.getMonth()-1);
				var year = '000'+(date.getFullYear()-1911);
				year = year.substring(year.length-3,year.length);
				var month = '00'+(date.getMonth()+1);
				month = month.substring(month.length-2,month.length);
				q_content += ' order=^^trandate desc,noa^^';
			    q_gt(q_name, q_content + "where=^^ trandate>='"+year+'/'+month+"'^^", q_sqlCount, 1, 0, '', r_accy);

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
                
                //HOT KEY
                $('#btnIns').val('新增(alt+1)').css('white-space','normal').css('width','70px');
                $('#btnModi').val('修改(alt+2)').css('white-space','normal').css('width','70px');
                $('#btnDele').val('刪除(alt+3)').css('white-space','normal').css('width','70px');
                $('#btnSeek').val('查詢(alt+4)').css('white-space','normal').css('width','70px');
                $('#btnPrint').val('列印(alt+5)').css('white-space','normal').css('width','70px');
                $('#btnPrevPage').val('翻上頁(alt+6)').css('white-space','normal').css('width','70px');
                $('#btnPrev').val('上筆(alt+7)').css('white-space','normal').css('width','70px');
                $('#btnNext').val('下筆(alt+8)').css('white-space','normal').css('width','70px');
                $('#btnNextPage').val('翻下頁(alt+9)').css('white-space','normal').css('width','70px');
                $('#btnOk').val('確定(F9)').css('white-space','normal').css('width','70px');
                
                q_cmbParse("cmbShip", "@,月結,現金,回收");
                q_cmbParse("cmbRs", "@,Y@是");
                
                $("#cmbShip").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).change(function(e){
					sum();	
				});
				$("#cmbRs").focus(function() {
					var len = $(this).children().length > 0 ? $(this).children().length : 1;
					$(this).attr('size', len + "");
				}).blur(function() {
					$(this).attr('size', '1');
				}).change(function(e){
					sum();	
				});
				
				/*$("#txtStraddrno").focus(function() {
					var input = document.getElementById ("txtStraddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
		                input.selectionEnd = $(input).val().length;
		            }
				});*/
				
				$('#txtMount').change(function(e){
					sum();
				});
				$('#txtWeight').change(function(e){
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
				$('#txtOverw').change(function(e){
					sum();
				});
				$('#txtMount2').change(function(e){
					sum();
				});
				$('#txtPrice2').change(function(e){
					sum();
				});
				$('#txtDiscount').change(function(e){
					sum();
				});
				$('#txtMemo').change(function(e){
					sum();
				});
				
				//----------------------------------------------------------------
				$('#textDate').datepicker();
				$('#btnClose_import').click(function(e){
					$('#divImport').toggle();
				});
				$('#btnClose_modi').click(function(e){
					$('#divModi').toggle();
				});
				
				$('#btnAppend_import').click(function(e){
					if(q_cur != 1 && q_cur != 2){
                   		var t_key = q_getPara('sys.key_trans');
                   		var t_date = $('#textDate').val();
                   		var t_n = $('#textN').val(); 
                   		t_key = (t_key.length==0?'BA':t_key);//一定要有值
                   		q_func('qtxt.query.appendData', 'trans_bs.txt,appendData,' + encodeURI(t_key) + ';'+ encodeURI(t_date) + ';'+ encodeURI(t_n));
                	}
				});
				//$('#btnXchg').after($('#btnBatInsert'));
				
				$('#textBtrandate_modi').datepicker();
				$('#textEtrandate_modi').datepicker();
				
				$('#btnIns').before($('#btnIns').clone().attr('id', 'btnBatInsert').show());
				$('#btnBatInsert').click(function() {
					$('#divImport').toggle();
				}).attr('value','整批新增').css('white-space','normal').css('width','50px');
				$('#btnIns').before($('#btnIns').clone().attr('id', 'btnBatModi').show());
				$('#btnBatModi').click(function() {
					$('#divModi').toggle();
				}).attr('value','整批修改').css('white-space','normal').css('width','50px');
				
				$('#btnRun_modi').click(function(e){
					var t_btrandate = $.trim($('#textBtrandate_modi').val());
					var t_etrandate = $.trim($('#textEtrandate_modi').val());
					var t_custno = $.trim($('#textCustno_modi').val());
					q_func('qtxt.query.batch_transmoney_es', 'trans_es.txt,batch_transmoney_es,' + encodeURI(t_btrandate)+';'+encodeURI(t_etrandate)+';'+encodeURI(t_custno));
				});
			}
			
			function  q_onkeydown(e){
				if(!e.altKey)
            		return;
            	switch(e.keyCode){
            		case 49:
            			if($('#btnIns').attr('disabled')!='disabled')
            				$('#btnIns').click();
            			break;
        			case 50:
        				if($('#btnModi').attr('disabled')!='disabled')
        					$('#btnModi').click();
            			break;
        			case 51:
        				if($('#btnDele').attr('disabled')!='disabled')
        					$('#btnDele').click();
            			break;
        			case 52:
        				if($('#btnSeek').attr('disabled')!='disabled')
        					$('#btnSeek').click();
            			break;
        			case 53:
        				if($('#btnPrint').attr('disabled')!='disabled')
        					$('#btnPrint').click();
            			break;
        			case 54:
        				if($('#btnPrevPage').attr('disabled')!='disabled')
        					$('#btnPrevPage').click();
            			break;
        			case 55:
        				if($('#btnPrev').attr('disabled')!='disabled')
        					$('#btnPrev').click();
            			break;
        			case 56:
        				if($('#btnNext').attr('disabled')!='disabled')
        					$('#btnNext').click();
            			break;
        			case 57:
        				if($('#btnNextPage').attr('disabled')!='disabled')
        					$('#btnNextPage').click();
            			break;
        			/*case 48:
        				if($('#btnOk').attr('disabled')!='disabled')
        					$('#btnOk').click();
            			break;*/
            		default:
            			break;
            	}	
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
					case 'tranmoney_es':
						var as = _q_appendData("tranmoney_es", "", true);
						if(as[0]!=undefined){
							if(as[0].msg.length>0)
								alert(as[0].msg);
							else{
								$('#txtPrice').val(as[0].price);
								$('#txtCustdiscount').val(as[0].rate);
								$('#txtOverw').val(as[0].rate2);
								$('#txtTotal').val(as[0].money);
								if($('#txtMemo').val().substring(0,1)!='*'){
									$('#txtPrice2').val(as[0].money2);
								}						
							}
						}
						sum2();
						break;
					case 'tranmoney_es_T01':
						var as = _q_appendData("tranmoney_es", "", true);
						if(as[0]!=undefined){
							if(as[0].msg.length>0)
								alert(as[0].msg);
							else{
								$('#txtPrice').val(as[0].money);
								$('#txtTotal').val(as[0].money);
								$('#txtCasetype').val(as[0].memo);
								if($('#txtMemo').val().substring(0,1)!='*'){
									$('#txtPrice2').val(as[0].money2);
								}						
							}
						}
						sum2();
						break;
                    case 'getDriver':
                        var as = _q_appendData("driver", "", true);
                        $('#txtCalctype').val('');
                        if(as[0]!=undefined){
                        	$('#txtCalctype').val(as[0].cartype);
                        	switch(as[0].cartype){
                        		case '公司車':
                        			if($('#txtMemo').val().substring(0,1)!='*')
                        				$('#txtDiscount').val(1);
                        			break;
                        		case '公司車(3/7)':
                        			if($('#txtMemo').val().substring(0,1)!='*')
                        				$('#txtDiscount').val(0.3);
                        			break;
                        		case '公司車(5/5)':
                        			if($('#txtMemo').val().substring(0,1)!='*')
                        				$('#txtDiscount').val(0.5);
                        			break;
                        		default:
                        			// 外車、靠行
                        			if($('#cmbShip').val()=='現金' && $('#cmbRs').val()!='Y'){
                        				if($('#txtMemo').val().substring(0,1)!='*')
	                        				$('#txtDiscount').val(0.9);
                        			}
	                        		else{
	                        			if($('#txtMemo').val().substring(0,1)!='*')
	                        				$('#txtDiscount').val(0.8);
	                        		}
	                        			
                        			break;
                        	}
                    	}
                    	sum1();
                        break;
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
					case 'txtDriverno':
						sum();	
						break;
					case 'txtCarno':
						sum();	
						break;
					case 'txtStraddrno':
						sum();
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
                	case 'qtxt.query.batch_transmoney_es':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	alert(as[0].msg);
                        	location.reload();
                        } else {
                        }
                		break;
                	case 'qtxt.query.appendData':
                		var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                        	alert(as[0].msg);
                        	location.reload();
                        } else {
                        }
                		break;
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
				isSave = false;
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
				$('#txtCustno').focus();
				
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				isSave = false;
				sum();
				$('#txtCustno').focus();
				
			}
			function btnPrint() {
				switch(q_getPara('sys.project').toUpperCase()){
					case 'ES':
						q_box('z_trans_es.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({
		                    noa : trim($('#txtNoa').val())
		                }) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
						break;
					default:
						q_box('z_trans_ds.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
						break;
				}
			}
			function waitBtnNext(){
				//isUpDown = 1 時表示還在讀資料
				if(isUpDown==0){
                    $('#btnModi').click();
                    q_msg($('#txtStraddr'), '已儲存!',0,3000 );		
            	}else{
            		setTimeout(function(){waitBtnNext();}, 500);
            	}
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
                if(q_cur==2){
                	//修改後自動跳下一筆資料(即  按上筆),然後修改
     			  	// 存檔後，繼續改
     			  	q_stModi = 1;
                    $('#btnNext').click();
                    waitBtnNext();
                }
                
                
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
				
				if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!");
                }
                isSave = true;
                sum();
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
					//$('#txtDatea').datepicker('destroy');
					//$('#txtTrandate').datepicker('destroy');
					$('#btnBatInsert').removeAttr('disabled');
				}else{
					//$('#txtDatea').datepicker();
					//$('#txtTrandate').datepicker();
					$('#btnBatInsert').attr('disabled','disabled');
					if(q_cur==2){
						$('#txtNoa').attr('readonly','readonly').css('color','green').css('background-color','rgb(237,237,237)');
					}else if(q_cur==1){
						$('#txtNoa').css('color','black').css('background-color','white');
					}
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
                /*overflow: hidden;*/
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
					<td><span> </span><a id="lblDatea_import" style="float:right; color: blue; font-size: medium;">取貨日期</a></td>
					<td colspan="4"><input id="textDate"  type="text" style="float:left; width:100px; font-size: medium;"/></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblN_import" style="float:right; color: blue; font-size: medium;">筆數</a></td>
					<td><input id="textN"  type="text" style="float:left; width:100px; font-size: medium;"/></td>
				</tr>
				<tr> </tr>
				<tr> </tr>
				<tr>
					<td> </td>
					<td><input type="button" id="btnAppend_import" value="新增空白行" /></td>
					<td> </td>
					<td><input type="button" id="btnClose_import" value="關閉" /></td>
				</tr>
			</table>
		</div>
		<div id="divModi" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
			<table style="width:100%;">
				<tr style="height:1px;">
					<td style="width:150px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
					<td style="width:80px;"></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblCust_modi" style="float:right; color: blue; font-size: medium;">客戶</a></td>
					<td colspan="4"><input id="textCustno_modi"  type="text" style="float:left; width:100px; font-size: medium;"/></td>
				</tr>
				<tr style="height:35px;">
					<td><span> </span><a id="lblBtrandate_modi" style="float:right; color: blue; font-size: medium;">取貨日期</a></td>
					<td colspan="4">
						<input id="textBtrandate_modi"  type="text" style="float:left; width:100px; font-size: medium;"/>
						<span style="float:left;display:block;width:20px;">~</span>
						<input id="textEtrandate_modi"  type="text" style="float:left; width:100px; font-size: medium;"/>
					</td>
				</tr>
				<tr> </tr>
				<tr> </tr>
				<tr>
					<td> </td>
					<td><input type="button" id="btnRun_modi" value="修改金額" /></td>
					<td> </td>
					<td><input type="button" id="btnClose_modi" value="關閉" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<!--<input type="button" id="btnBatInsert" style="float:left;width:100px;" value="整批新增">-->
		<!--<input type="button" id="btnBatModi" style="float:left;width:100px;" value="整批修改">-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;">取貨日期</td>
						<td align="center" style="width:120px; color:black;">單號</td>
						<td align="center" style="width:80px; color:black;">客戶</td>
						<td align="center" style="width:50px; color:black;">結帳<BR>方式</td>
						<td align="center" style="width:50px; color:black;">發票</td>
						<td align="center" style="width:80px; color:black;">卸貨地點</td>
						<td align="center" style="width:80px; color:black;">司機</td>
						<td align="center" style="width:80px; color:black;">車型</td>
						<td align="center" style="width:80px; color:black;">才數</td>
						<td align="center" style="width:80px; color:black;">件數</td>
						<td align="center" style="width:80px; color:black;">板數</td>
						<td align="center" style="width:80px; color:black;">重量</td>
						
						<td align="center" style="width:80px; color:black;">客戶金額</td>
						<td align="center" style="width:80px; color:black;">司機單價</td>
						<td align="center" style="width:80px; color:black;">司機金額</td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="ship" style="text-align: center;">~ship</td>
						<td id="rs" style="text-align: center;">~rs</td>
						<td id="aaddr" style="text-align: center;">~aaddr</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="casetype" style="text-align: center;">~casetype</td>
						<td id="mount3" style="text-align: center;">~mount3</td>
						<td id="mount4" style="text-align: center;">~mount4</td>
						<td id="status" style="text-align: center;">~status</td>
						<td id="weight" style="text-align: center;">~weight</td>
						
						<td id="total,0,1" style="text-align: right;">~total,0,1</td>
						<td id="price2,0,1" style="text-align: right;">~price2,0,1</td>
						<td id="total2,0,1" style="text-align: right;">~total2,0,1</td>
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
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a class="lbl">結帳方式</a></td>
						<td><select id="cmbShip" class="txt c1" > </select></td>
						<td><span> </span><a class="lbl">發票</a></td>
						<td><select id="cmbRs" class="txt c1" > </select></td>
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
						<td>
							<input id="txtCarno"  type="text" class="txt c1"/>
							<input id="txtCalctype"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
							<input id="txtDriver"  type="text" style="float:left;width:50%;"/>
						</td>
						<td> </td>
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
						<td style="background-color: #cad3ff;"><span> </span><a class="lbl" style="display:none;">數量</a>
							<a class="lbl">車型</a>
						</td>
						<td style="background-color: #cad3ff;"><input id="txtMount"  type="text" class="txt c1 num" style="display:none;"/>
							<input id="txtCasetype"  type="text" class="txt c1"/>
						</td>
                        <td><span> </span><a class="lbl">單價</a></td>
						<td><input id="txtPrice" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">應收金額</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">稅額</a></td>
                        <td><input id="txtReserve" type="text" class="txt c1 num"/></td>
						<td class="tdZ"> </td>
					</tr>
					<tr style="background-color: pink;">
						<td style="background-color: #cad3ff;"><span> </span><a id="lblMount2" class="lbl" style="display:none;"> </a></td>
						<td style="background-color: #cad3ff;"><input id="txtMount2"  type="text" class="txt c1 num" style="display:none;"/></td>
						<td><span> </span><a class="lbl">司機運費</a></td>
						<td>
							<input id="txtPrice2"  type="text" class="txt c1 num" title="若區域有設定，此格將自動計算。若要手動修改，請在備註第一個字輸入  *"/>
							<input id="txtPrice3"  type="text" class="txt c1 num" style="display:none;"/>
						</td>
						<td><span> </span><a class="lbl">折扣</a></td>
						<td><input id="txtDiscount"  type="text" class="txt c1 num" title="若要手動修改，請在備註第一個字輸入  *"//></td>
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
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCustdiscount" class="lbl">漲幅%(客戶)</a></td>
						<td><input id="txtCustdiscount" type="text" class="txt c1 num" title="區域有設定才會計算"/></td>
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
						<td><span> </span><a id="lblOverw_es" class="lbl">漲幅%(司機)</a></td>
						<td><input id="txtOverw" type="text" class="txt c1 num" title="區域有設定才會計算"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
