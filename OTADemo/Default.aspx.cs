using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OTADemo
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private string ReadXmlFile(string name)
        {
            string serverpath = Server.MapPath("~/RequestModels/");
            string content = string.Empty;
            try
            {
                string xmlFilePath = $"{serverpath}/{name}.xml";
                using (StreamReader reader = new StreamReader(xmlFilePath))
                {
                    content = reader.ReadToEnd();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return content;
        }

        protected void Send_Click(object sender, EventArgs e)
        {
            PostToServer(requestBody.Text);
        }

        protected void DownLoadSchema_Click(object sender, EventArgs e)
        {
            Response.ContentType = "APPLICATION/OCTET-STREAM";
            String Header = "Attachment; Filename=OTA_2013B_XSD.zip";
            Response.AppendHeader("Content-Disposition", Header);
            var file = new FileInfo(Server.MapPath("~/OTAXSD/OTA_2013B_XSD.zip"));
            Response.WriteFile(file.FullName);
            Response.End();
        }

        protected void Version_SelectedIndexChanged(object sender, EventArgs e)
        {
            operation.SelectedIndex = -1;
            requestBody.Text = "";
            txtResponse.Text = "";
        }

        protected void Operation_SelectedIndexChanged(object sender, EventArgs e)
        {
            var selectedValue = operation.SelectedValue;
            if (version.SelectedValue == "v2")
            {
                selectedValue += "V2";
            }
            requestBody.Text = ReadXmlFile(selectedValue);
        }


        private void PostToServer(string xml)
        {
            using (HttpClientHandler handler = new HttpClientHandler())
            {
                handler.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;
                using (HttpClient client = new HttpClient(handler, false))
                {
                    byte[] jsonBytes = Encoding.UTF8.GetBytes(xml);
                    MemoryStream ms = new MemoryStream();
                    using (GZipStream gzip = new GZipStream(ms, CompressionMode.Compress, true))
                    {
                        gzip.Write(jsonBytes, 0, jsonBytes.Length);
                    }
                    ms.Position = 0;
                    StreamContent content = new StreamContent(ms);
                    content.Headers.ContentType = new MediaTypeHeaderValue("application/xml");
                    content.Headers.ContentEncoding.Add("gzip");
                    HttpResponseMessage response = client.PostAsync($"https://uat-xml.gorentals.nz/{operation.SelectedValue}", content).Result;
                    var result =  response.Content.ReadAsStringAsync().Result;
                    txtResponse.Text = result;
                }
            }
        }
    }
}