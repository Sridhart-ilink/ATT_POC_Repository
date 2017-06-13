using ApiServiceTes.Mock;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace ApiServiceTes.Controllers
{
    public class AtollRefreshController : ApiController
    {
        // GET api/atollrefresh
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/atollrefresh/2
        public object Get(string id)
        {
            AtollData atoll = new AtollData();
            var resp = atoll.getAtollInfo(id);
            JsonConvert.SerializeObject(resp);
            return Request.CreateResponse(HttpStatusCode.OK, resp);
        }

        // POST api/atollrefresh
        public void Post([FromBody]string value)
        {
        }

        // PUT api/atollrefresh/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/atollrefresh/5
        public void Delete(int id)
        {
        }
    }
}