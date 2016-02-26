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
                q_gf('', 'z_trans_bs');       
            });
            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_trans_bs',
					options : [{
						type : '0', //[1]
						name : 'path',
						value : location.protocol + '//' +location.hostname + location.pathname.toLowerCase().replace('z_quat_rkp.aspx','')
					},{
						type : '0', //[2]
						name : 'db',
						value : q_db
					}, {
						type : '2', //[3][4]
						name : 'xaddr3',
						dbf : 'addr3',
						index : 'noa,namea',
						src : 'addr3_bs_b.aspx'
					}, {
						type : '2', //[5][6]
						name : 'xdriver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					}, {
						type : '2', //[7][8]
						name : 'xcust',
						dbf : 'cust',
						index : 'noa,comp',
						src : 'cust_b.aspx'
					},{
						type : '6', //[9]
						name : 'xtrandate'
					},{
						type : '1', //[10][11]
						name : 'xinvestdate'
					},{
						type : '1', //[12][13]
						name : 'ydatea'
					},{
						type : '1', //[14][15]
						name : 'ytrandate'
					}]
				});
				q_popAssign();
				bbmMask = [['txtXtrandate','999/99/99'],['txtXinvestdate1','999/99/99'],['txtXinvestdate2','999/99/99']
					,['txtYtrandate1','999/99/99'],['txtYtrandate2','999/99/99'],['txtYdatea1','999/99/99'],['txtYdatea2','999/99/99']];
				q_mask(bbmMask);
				$('#txtXtrandate').datepicker();
				$('#txtXinvestdate1').datepicker();
				$('#txtXinvestdate2').datepicker();
				$('#txtYtrandate1').datepicker();
				$('#txtYtrandate2').datepicker();
				$('#txtYdatea1').datepicker();
				$('#txtYdatea2').datepicker();
				
				$('#txtXtrandate').val(q_date());
				$('#txtYtrandate1').val(q_date());
				$('#txtYtrandate2').val(q_date());
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            }catch(e){
	            }    
	            if(t_para.length==0 || t_para.noa==undefined){
	            }else{
	            	$('#txtNoa').val(t_para.noa);
	            }
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
			<div style="width:1900px;"><a>收貨到期明細表 :合約到期日太於本次收貨日的才會顯示。</a></div>
			<div id="container">
				<div id="q_report"> </div>
			</div>
			
			<div class="prt" style="margin-left: -40px;">			
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          