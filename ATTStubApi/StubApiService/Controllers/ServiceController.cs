using ApiServiceTes.Mock;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using System.Web.Http.Cors;

namespace ApiServiceTes.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class ServiceController : ApiController
    {      

        [HttpGet]
        [Route("api/service/GetSearchRings")]
        public HttpResponseMessage GetSearchRings()
        {
            AtollData atoll = new AtollData();
            var resp = atoll.getSearchRings();
            JsonConvert.SerializeObject(resp);
            return Request.CreateResponse(HttpStatusCode.OK, resp);

        }
        [HttpGet]
        [Route("api/service/GetSearchRing/{id}")]
        public HttpResponseMessage GetSearchRings(string id)
        {
            AtollData atoll = new AtollData();
            var resp = atoll.getSearchRings(id);
            JsonConvert.SerializeObject(resp);
            return Request.CreateResponse(HttpStatusCode.OK, resp);

        }
        [HttpGet]
        [Route("api/service/GetAtollInfo/{id}")]
        public HttpResponseMessage GetAtoll(string id)
        {
            AtollData atoll = new AtollData();
            var resp = atoll.getAtollInfo(id);
            JsonConvert.SerializeObject(resp);
            return Request.CreateResponse(HttpStatusCode.OK, resp);

        }

        [HttpGet]
        [Route("api/service/GetOraclePTN/{iplanJobNumber}/{faLocationCode}")]
        public HttpResponseMessage GetOraclePTN(string iplanJobNumber, string faLocationCode)
        {
            AtollData atoll = new AtollData();
            var resp = atoll.getOraclePTN(iplanJobNumber, faLocationCode);
            JsonConvert.SerializeObject(resp);
            return Request.CreateResponse(HttpStatusCode.OK, resp);


        }
        // POST api/service
        public void Post([FromBody]string value)
        {
        }

        // PUT api/service/5
        public void Put(int id, [FromBody]string value)
        {
        }
        // DELETE api/service/5
        public void Delete(int id)
        {
        }

    }
}