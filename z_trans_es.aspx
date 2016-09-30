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
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_trans_es');       
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_trans_es',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_quat_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					},{
						type : '1', //[3][4]
						name : 'xtrandate'
					},{
						type : '1', //[5][6]
						name : 'xdatea'
					}, {
						type : '2', //[7][8]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					}, {
						type : '2', //[9][10]
						name : 'xdriver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					},{
						type : '6', //[11]
						name : 'xcarno'
					}, {
						type : '2', //[12][13]
						name : 'xaddr3',
						dbf : 'addr3',
						index : 'noa,namea',
						src : 'addr3_bs_b.aspx'
					},{
						type : '6', //[14]
						name : 'noa'
					},{
                        type : '5', //[15] 
                        name : 'paytype',
                        value : [q_getPara('report.all')].concat("月結,現金,回收".split(','))
                    },{
                        type : '5', //[16] 
                        name : 'xisinvo',
                        value : [q_getPara('report.all')].concat("Y@是,N@否".split(','))
                    },{
                        type : '5', //[17] 
                        name : 'xistrd',
                        value : [q_getPara('report.all')].concat("1@已立帳,0@未立帳".split(','))
                    },{
                        type : '5', //[18] 
                        name : 'xistre',
                        value : [q_getPara('report.all')].concat("1@已立帳,0@未立帳".split(','))
                    },{
                        type : '6', //[19] 
                        name : 'xaaddr'
                    }]
				});
				q_popAssign();
				q_langShow();
				bbmMask = [['txtXtrandate1','999/99/99'],['txtXtrandate2','999/99/99'],['txtXdatea1','999/99/99'],['txtXdatea2','999/99/99']];
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
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtNoa').val(t_para.noa);
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
            }

			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
			function q_gtPost(s2) {}
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
           
          