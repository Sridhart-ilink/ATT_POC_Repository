using System.Net.Http;
using System.Xml;
using System.IO;
using Newtonsoft.Json;
using System;
using System.Data;

namespace JavascriptBasedApp
{
    public partial class SarfPage : System.Web.UI.Page
    {
        string sarfID = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            bindSarfDetails();
        }
        private void bindSarfDetails()
        {
            using (var client = new HttpClient())
            {
                sarfID = Request.QueryString["processInstanceId"].ToString();
                string serviceUrl = System.Configuration.ConfigurationManager.AppSettings.Get("ServiceUrl");
                client.BaseAddress = new Uri(serviceUrl);
                var response = client.GetAsync("SarfDetailsByTaskID/Get/" + sarfID).Result;
                var data = response.Content.ReadAsStringAsync();
                var dt = JsonConvert.DeserializeObject<DataTable>(data.Result);
                if (response.IsSuccessStatusCode)
                {
                    txtsarfname.Value = dt.Rows[0][0].ToString();
                    txtfacode.Value = dt.Rows[0][1].ToString();
                    txtsearchring.Value = dt.Rows[0][2].ToString();
                    txtiplan.Value = dt.Rows[0][3].ToString();
                    txtpace.Value = dt.Rows[0][4].ToString();
                    txtmarket.Value = dt.Rows[0][5].ToString();
                    txtcounty.Value = dt.Rows[0][6].ToString();
                    txtfatype.Value = dt.Rows[0][7].ToString();
                    txtmarketcluster.Value = dt.Rows[0][8].ToString();
                    txtregion.Value = dt.Rows[0][9].ToString();
                    txtrfdesign.Value = dt.Rows[0][10].ToString();
                }
            }
            workflowImg.Attributes["src"] = System.Configuration.ConfigurationManager.AppSettings.Get("WFImgUrl") + sarfID;
        }
    }
}