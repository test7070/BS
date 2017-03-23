<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public string custno = "", addrfield = "";
        }
        
        public class Para
        {
            public string custno, cust, zip, addr;
        }
        
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        string connectionString = "";
        public void Page_Load()
        {
        	string db = "DC2";
        	if(Request.QueryString["db"] !=null && Request.QueryString["db"].Length>0)
        		db= Request.QueryString["db"];
        	connectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+db;
            //connectionString = "Data Source=59.125.143.171,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + db;
			var item = new ParaIn();
            if (Request.QueryString["custno"] != null && Request.QueryString["custno"].Length > 0)
            {
                item.custno = Request.QueryString["custno"];
            }
  
            if (Request.QueryString["addrfield"] != null && Request.QueryString["addrfield"].Length > 0)
            {
                item.addrfield = Request.QueryString["addrfield"];
            }
            /*item.custno = "A0008";
            item.addrfield = "invo";*/
        
            //資料
            System.Data.DataTable dt = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connectionString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"SET QUOTED_IDENTIFIER OFF
	declare @cmd nvarchar(max)
	
	declare @tmp table(
		sel int identity(1,1)
		,custno nvarchar(20)
		,cust nvarchar(50)
		,zip nvarchar(20)
		,addr nvarchar(max)
	)
	set @cmd = ""select noa,comp,zip_""+@t_addrfield+"",addr_""+@t_addrfield+""
	from cust 
	where charindex(','+noa+',',','+@t_custno+',')>0""
	
	insert into @tmp(custno,cust,zip,addr)
	execute sp_executesql @cmd,N'@t_custno nvarchar(max)',@t_custno=@t_custno
	select custno
        ,isnull(cust,'') + case when len(isnull(cust,''))>0 then '收' else '' end cust
		,zip
		,addr
	from @tmp;";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@t_custno", item.custno);
                cmd.Parameters.AddWithValue("@t_addrfield", item.addrfield);
                adapter.SelectCommand = cmd;
                adapter.Fill(dt);
                connSource.Close();
            }
            ArrayList custLabel = new ArrayList();
            foreach (System.Data.DataRow r in dt.Rows)
            {
                Para pa = new Para();
                pa.custno = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                pa.cust = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                pa.zip = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pa.addr = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                custLabel.Add(pa);
            }
            //-----PDF--------------------------------------------------------------------------------------------------
           /// W*H 3.5*11 320, 99)
            //var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(320, 99), 0, 0, 0, 0);
            var doc1 = new iTextSharp.text.Document(new iTextSharp.text.Rectangle(340, 99), 0, 0, 0, 0);
            iTextSharp.text.pdf.PdfWriter pdfWriter = iTextSharp.text.pdf.PdfWriter.GetInstance(doc1, stream);
            //font   
            iTextSharp.text.pdf.BaseFont bfChinese = iTextSharp.text.pdf.BaseFont.CreateFont(@"C:\windows\fonts\kaiu.ttf", iTextSharp.text.pdf.BaseFont.IDENTITY_H, iTextSharp.text.pdf.BaseFont.NOT_EMBEDDED);

            doc1.Open();
            iTextSharp.text.pdf.PdfContentByte cb = pdfWriter.DirectContent;
            if (custLabel.Count == 0)
            {
                cb.SetColorFill(iTextSharp.text.BaseColor.RED);
                cb.BeginText();
                cb.SetFontAndSize(bfChinese, 30);
                cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, "無資料", 20, 20, 0);
                cb.EndText();
            }
            else
            {
            	for (int i = 0; i < custLabel.Count; i++)
                {
                    if (i != 0)
                    {
                        //Insert page
                        doc1.NewPage();
                    }
                  
                     //TEXT
                     cb.SetColorFill(iTextSharp.text.BaseColor.BLACK);
                     cb.BeginText();
                     cb.SetFontAndSize(bfChinese, 13);
                     cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)custLabel[i]).zip, 55, 82 , 0);
                     cb.SetFontAndSize(bfChinese,14);
                     cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)custLabel[i]).addr, 55, 57, 0);
                     cb.SetFontAndSize(bfChinese, 15);
                     cb.ShowTextAligned(iTextSharp.text.pdf.PdfContentByte.ALIGN_LEFT, ((Para)custLabel[i]).cust, 55, 27, 0);
                     
                     cb.EndText();
                }
               
            }
            doc1.Close();
            Response.ContentType = "application/octec-stream;";
            Response.AddHeader("Content-transfer-encoding", "binary");
            Response.AddHeader("Content-Disposition", "attachment;filename=客戶信封標籤.pdf");
            Response.BinaryWrite(stream.ToArray());
            Response.End();
        }
    </script>