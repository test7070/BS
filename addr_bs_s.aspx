<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            aPop = new Array(
            	['txtNoa', '', 'addr', 'noa,addr', 'txtNoa', 'addr_b.aspx']
            	, ['txtStraddrno', 'lblXstraddrno', 'addr3', 'noa,namea', 'txtStraddrno', 'addr3_bs_b.aspx'] 
            	, ['txtProductno', '', 'ucc', 'noa,product', 'txtProductno', 'ucc_b.aspx']          	
            );
            var q_name = "addr_s";

            $(document).ready(function() {
                main();
            });

            function main() {
                mainSeek();
                q_gf('', q_name);
                $('#txtNoa').focus();
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                /* bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                 q_mask(bbmMask);

                 $('#txtBdate').focus();*/
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_addr = $.trim($('#txtAddr').val());
                t_straddrno = $('#txtStraddrno').val();
                t_straddr = $('#txtStraddr').val();
                t_productno = $('#txtProductno').val();
                t_product = $('#txtProduct').val();
                
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa) 
                	+ q_sqlPara2("straddrno", t_straddrno) 
                	+ q_sqlPara2("productno", t_productno) ;
                if (t_addr.length > 0)
                    t_where += " and charindex('" + t_addr + "',addr)>0";
                if (t_straddr.length > 0)
                    t_where += " and charindex('" + t_straddr + "',straddr)>0";
                if (t_product.length > 0)
                    t_where += " and charindex('" + t_product + "',product)>0";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblAddr'></a></td>
					<td>
					<input class="txt" id="txtAddr" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblXstraddrno'>區域編號</a></td>
                    <td>
                    <input class="txt" id="txtStraddrno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblXstraddr'>區域名稱</a></td>
                    <td>
                    <input class="txt" id="txtStraddr" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblProductno'>產品編號</a></td>
                    <td>
                    <input class="txt" id="txtProductno" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                <tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblProduct'>產品名稱</a></td>
                    <td>
                    <input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" />
                    </td>
                </tr>
                
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
