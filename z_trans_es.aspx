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
           
          