<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
			
			aPop = new Array(['txtXcarno', '', 'car2', 'a.noa', '0txtXcarno', 'car2_b.aspx']);
			var t_acomp = '';
            $(document).ready(function() {
            	q_getId();
            	q_gt('acomp', "", 0, 0, 0, "");
            });
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'acomp':
                		var as = _q_appendData("acomp", "", true);
                        if(as[0]!=undefined){
                        	for(var i=0;i<as.length;i++)
                        		t_acomp += (t_acomp.length>0?',':'')+as[i].noa+'@'+as[i].nick; 
                        }
                		q_gf('', 'z_trans_es');
                		break;
                    default:
						break;
                }
            }
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_trans_es',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_trans_es.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '1', //[3][4]    1
						name : 'xtrandate'
					},{
						type : '1', //[5][6]    2
						name : 'xdatea'
					}, {
						type : '2', //[7][8]    3
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[9][10]    4
						name : 'xdriver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					},{
						type : '6', //[11]       5
						name : 'xcarno'
					}, {
						type : '2', //[12][13]    6
						name : 'xaddr3',
						dbf : 'addr3',
						index : 'noa,namea',
						src : 'addr3_bs_b.aspx'
					},{
						type : '6', //[14]        7
						name : 'noa'
					},{
                        type : '5', //[15]         8
                        name : 'paytype',
                        value : [q_getPara('report.all')].concat("月結,現金,回收".split(','))
                    },{
                        type : '5', //[16]          9
                        name : 'xisinvo',
                        value : [q_getPara('report.all')].concat("Y@是,N@否".split(','))
                    },{
                        type : '5', //[17]           10
                        name : 'xistrd',
                        value : [q_getPara('report.all')].concat("1@已立帳,0@未立帳".split(','))
                    },{
                        type : '5', //[18]            11
                        name : 'xistre',
                        value : [q_getPara('report.all')].concat("1@已立帳,0@未立帳".split(','))
                    },{
                        type : '6', //[19]             12
                        name : 'xaaddr'
                    },{
                        type : '5', //[20]             13
                        name : 'xacomp',
                        value : t_acomp.split(',')
                    },{
                        type : '6', //[21]             14
                        name : 'xrate'
                    },{
                        type : '5', //[22]             15
                        name : 'xpaytype',
                        value : [q_getPara('report.all')].concat("月結,現金,回收".split(','))
                    },{
                        type : '6', //[23]             16
                        name : 'xpayday'
                    },{
                        type : '6', //[24]             17
                        name : 'xmon'
                    },{
                        type : '6', //[25]             18
                        name : 'xmulti_cust'
                    },{
                        type : '5', //[26]             19
                        name : 'xoption2',
                        value : "invo@發票地址,comp@公司地址,fact@工廠地址,home@通信地址".split(',')
                    },{
                        type : '8', //[27]             20
                        name : 'xoption3',
                        value : "1@依客戶對帳單".split(',')
                    }]
				});
				q_popAssign();
				q_langShow();
				bbmMask = [['txtXmon','999/99'],['txtXtrandate1','999/99/99'],['txtXtrandate2','999/99/99'],['txtXdatea1','999/99/99'],['txtXdatea2','999/99/99']];
				q_mask(bbmMask);
				$('#txtXtrandate1').datepicker();
				$('#txtXtrandate2').datepicker();
				$('#txtXdatea1').datepicker();
				$('#txtXdatea2').datepicker();
				
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0){
	            }else if(t_para.noa!=undefined){
	            	$('#txtNoa').val(t_para.noa);
	            }else if(t_para.custno!=undefined){
	            	$('#txtXcust1a').val(t_para.custno);
	            	$('#txtXcust1b').val(t_para.custno);
	            }
	            
	            var t_date,t_year,t_month,t_day;
                t_date = new Date();
                t_date.setDate(1);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day>9?t_day+'':'0'+t_day;
                $('#txtXtrandate1').val(t_year+'/'+t_month+'/'+t_day);
                
                t_date = new Date();
                t_date.setDate(35);
                t_date.setDate(0);
                t_year = t_date.getUTCFullYear()-1911;
                t_year = t_year>99?t_year+'':'0'+t_year;
                t_month = t_date.getUTCMonth()+1;
                t_month = t_month>9?t_month+'':'0'+t_month;
                t_day = t_date.getUTCDate();
                t_day = t_day>9?t_day+'':'0'+t_day;
                $('#txtXtrandate2').val(t_year+'/'+t_month+'/'+t_day);
                
                $('<input id="btnOk2" type="button" value="查詢" style="font-size: 16px; font-weight: bold; color: blue; cursor: pointer;"/>').insertBefore('#btnOk');
            	$('#btnOk').hide();
            	$('#btnOk2').click(function(e){
            		switch($('#q_report').data('info').radioIndex) {
                        case 9:
                        	console.log("./custlabel_es.aspx?db="+q_db+"&custno="+$('#txtXmulti_cust').val()+"&addrfield="+$('#Xoption2').find('select').eq(0).val()+"&option="+($('#Xoption3').find('input').eq(0).prop('checked')?'1':''));
                        	window.open("./custlabel_es.aspx?db="+q_db+"&custno="+$('#txtXmulti_cust').val()+"&addrfield="+$('#Xoption2').find('select').eq(0).val()+"&option="+($('#Xoption3').find('input').eq(0).prop('checked')?'1':''));
                            break;
                        default:
                           	$('#btnOk').click();
                            break;
                    }
            	});
            	
            	$('#Xmulti_cust').removeClass('a2').addClass('a1');
            	$('#txtXmulti_cust').css('width','500px');
            	$('#lblXmulti_cust').click(function() {
            		var custno= $('#txtXmulti_cust').val().length==0?new Array():$('#txtXmulti_cust').val().split(',');
                	q_box("multi_cust_b.aspx?" + r_userno + ";" + r_name + ";" + q_id + ";" + "　" +";"+r_accy+";"+JSON.stringify({custno:custno,condition:""}), "multi_cust", "95%", "95%", '');
				});
            	
            }
			function q_boxClose(s2) {///   q_boxClose 2/4
				var
				ret;
				switch (b_pop) {
					case 'multi_cust':
                        if (b_ret != null) {
                        	as = b_ret;
                        	if(as!=undefined){
                        		var t_cust="";
	                        	for(var i=0;i<as.length;i++){
	                        		t_cust +=(t_cust.length>0?',':'')+as[i].noa;
	                        	}
	                        	$('#txtXmulti_cust').val(t_cust);
                        	}
                        }
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}/// end Switch
				b_pop = '';
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          