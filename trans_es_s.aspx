<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var q_name = "trans_s";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx'],
		    ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx'], 
		    ['txtStraddrno', 'lblStraddr', 'addr3', 'noa,namea', 'txtStraddrno', 'addr3_bs_b.aspx'],
		    ['txtEndaddrno', 'lblEndaddr', 'addr3', 'noa,namea', 'txtEndaddrno', 'addr3_bs_b.aspx'],
            ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']);
            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker(); 
                $('#txtNoa').focus();
                
                q_cmbParse("cmbShip", "@,月結,現金,回收");
                q_cmbParse("cmbRs", "@,Y@是,N@否");
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    default:
						break;
                }
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
		        t_driverno = $.trim($('#txtDriverno').val());
		        t_driver = $.trim($('#txtDriver').val());
		        t_custno = $.trim($('#txtCustno').val());
		        t_comp = $.trim($('#txtComp').val());
		        t_carno = $.trim($('#txtCarno').val());
		        t_straddrno = $.trim($('#txtStraddrno').val());

		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();
		        t_btrandate = $('#txtBtrandate').val();
		        t_etrandate = $('#txtEtrandate').val();
		        
		        t_aaddr = $.trim($('#txtAaddr').val());
				t_ship = $.trim($('#cmbShip').val());
				t_rs = $.trim($('#cmbRs').val());
				
		        var t_where = " 1=1 " 
		        + q_sqlPara2("noa", t_noa) 
		        + q_sqlPara2("datea", t_bdate, t_edate) 
		        + q_sqlPara2("trandate", t_btrandate, t_etrandate) 
		        + q_sqlPara2("driverno", t_driverno) 
		        + q_sqlPara2("custno", t_custno) 
		        + q_sqlPara2("straddrno", t_straddrno) 
		        + q_sqlPara2("carno", t_carno) ;
		        if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
                if (t_driver.length>0)
                    t_where += " and charindex('" + t_driver + "',driver)>0";
		       	if (t_aaddr.length>0)
                    t_where += " and charindex('" + t_aaddr + "',aaddr)>0";
                if (t_ship.length>0)
                    t_where += " and charindex('" + t_ship + "',ship)>0";
                if (t_rs == 'Y')
                    t_where += " and rs='Y'";
                if (t_rs == 'N')
                    t_where += " and len(isnull(rs,''))=0";   
                            
		        t_where = ' where=^^' + t_where + '^^ ';
		        return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a>回單日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a>取貨日期</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtrandate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtrandate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriverno'></a></td>
					<td>
					<input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
					<td>
					<input class="txt" id="txtDriver" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>結帳方式</a></td>
					<td><select id="cmbShip" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>發票</a></td>
					<td><select id="cmbRs" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblXstraddr'>運送區域</a></td>
					<td>
					<input class="txt" id="txtStraddrno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblXaaddr'>卸貨地點</a></td>
					<td>
					<input class="txt" id="txtAaddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>