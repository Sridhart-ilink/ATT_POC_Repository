 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using ATTWebAppAPI.Models;
using Newtonsoft.Json.Linq;

namespace ATTWebAppAPI.Controllers
{
    public class BPMWorkFlowController : ApiController
    {
        // GET api/task
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/task")]
        public string GetAllWorkFlowTask()
        {

            var serverName = System.Configuration.ConfigurationManager.AppSettings.Get("serverName");
            var client = new RestClient();
            client.EndPoint = @"http://"+serverName+":8080/engine-rest/task"; 
            client.Method = HttpVerb.GET;
            string strJson = client.MakeRequest();
            return strJson;
        }

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [Route("api/task-by-process-instance/{id}")]
        public string GetActivityInstance(string id)
        {
            var serverName = System.Configuration.ConfigurationManager.AppSettings.Get("serverName");
            var client = new RestClient();
            client.EndPoint = @"http://" + serverName + ":8080/engine-rest/task/?processInstanceId=" + id;
            client.Method = HttpVerb.GET;
            string strJson = client.MakeRequest();
            return strJson;
        }

        // GET api/products/5
        public string Get(int id)
        {
            return "value";
        }

        //public void StartProcess(string name,[FromBody]string value)
        // POST process-definition/key/{key}/start
        [Route("api/process-definition")]
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        public string StartProcess(JObject jsonData)        
        {
            var serverName = System.Configuration.ConfigurationManager.AppSettings.Get("serverName");
            dynamic json = jsonData;
            var endPoint = @"http://"+serverName+":8080/engine-rest/process-definition/key/" + json.key + "/start";
            var method = HttpVerb.POST;
            JObject variables = json.variables;
            string PostData = "{}";
            if (variables != null && variables.Count > 0)
            {
                var jsonObject = new JObject();
                jsonObject.Add("variables", variables);
                PostData = Convert.ToString(jsonObject);
            }
            var client = new RestClient(endPoint, method, PostData, "application/json");
            string strJson = client.MakeRequest();
            return strJson;            
        }

        // POST task{id}/complete
        [Route("api/taskcomplete")]
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        public string TaskComplete(JObject jsonData)
        {
            var serverName = System.Configuration.ConfigurationManager.AppSettings.Get("serverName");
            dynamic json = jsonData;
            var endPoint = @"http://"+serverName+":8080/engine-rest/task/" + json.id + "/complete";
            var method = HttpVerb.POST;
            JObject variables = json.variables;
            string PostData  = "{}";
            if (variables != null && variables.Count > 0)
            {
                var jsonObject = new JObject();
                jsonObject.Add("variables", variables);
                PostData = Convert.ToString(jsonObject);
            }
            var client = new RestClient(endPoint, method, PostData, "application/json");
            string strJson = client.MakeRequest();
            return strJson;
        }

        // PUT api/products/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/products/5
        public void Delete(int id)
        {
        }
    }
}
