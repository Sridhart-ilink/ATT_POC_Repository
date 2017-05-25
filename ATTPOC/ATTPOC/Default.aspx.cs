using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Configuration;
using System.Data;
using System.Net.Http;
using System.Xml;
using System.IO;
using Newtonsoft.Json;
namespace JavascriptBasedApp
{
    public partial class _Default : System.Web.UI.Page
    {
         
        protected void Page_Load(object sender, EventArgs e)
        {
            bindGrid();
        }

        protected void dtGrid_OnPageIndexChanging(object sender, DataGridPageChangedEventArgs e)
        {
            dtGrid.CurrentPageIndex = e.NewPageIndex;
            bindGrid();
        }

        private void bindGrid()
        {
            using (var client = new HttpClient())
            {
                string serviceUrl = System.Configuration.ConfigurationManager.AppSettings.Get("ServiceUrl");
                client.BaseAddress = new Uri(serviceUrl);
                var response = client.GetAsync("SarfDetails/Get").Result;
                var data = response.Content.ReadAsStringAsync();
                var dt = JsonConvert.DeserializeObject<DataTable>(data.Result);
                if (response.IsSuccessStatusCode)
                {
                    dtGrid.DataSource = dt;
                    dtGrid.DataBind();
                }
            }
        }
    }
}
