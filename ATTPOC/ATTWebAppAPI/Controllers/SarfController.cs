using ATTWebAppAPI.DAL;
using ATTWebAppAPI.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web.Http;
using System.Web.Http.Cors;

namespace ATTWebAppAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class SarfController : ApiController
    {
        SarfDao sarfDao = null;
        static long transId = 0;
        public SarfController()
        {
            sarfDao = new SarfDao();
        }

        protected HttpResponseMessage WrapObjectToHttpResponse<T>(T responseData)
        {
            IContentNegotiator negotiator = this.Configuration.Services.GetContentNegotiator();
            ContentNegotiationResult result = negotiator.Negotiate(typeof(T), this.Request, this.Configuration.Formatters);
            return new HttpResponseMessage()
            {
                Content = new ObjectContent(typeof(T),
                    responseData, // What we are serializing
                    result.Formatter, // The media formatter
                    result.MediaType.MediaType), // The MIME type
                StatusCode = HttpStatusCode.OK,
                RequestMessage = this.Request
            };
        }

        [HttpPost]
        [Route("api/Sarf/Post")]
        public HttpResponseMessage PostSarf([FromBody] Sarf sarf)
        {
            try
            {
                sarf.CreatedDate = DateTime.Now;
                transId = sarfDao.SaveSarf(sarf);
                return WrapObjectToHttpResponse(transId);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpPost]
        [Route("api/UpdateSarf/Post")]
        public HttpResponseMessage UpdateSarf([FromBody] Sarf sarf)
        {
            try
            {
                sarf.CreatedDate = DateTime.Now;
                sarfDao.UpdateSarf(sarf);
                return WrapObjectToHttpResponse(1);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/SarfDetails/Get")]
        public DataTable GetSarfDetails()
        {
            try
            {
                return sarfDao.GetSarfDetails();
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/AllSarfDetails/Get/{sarfID}")]
        public DataTable GetAllSarfDetails(int sarfID)
        {
            try
            {
                return sarfDao.GetAllSarfDetails(sarfID);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/SarfDetailsByTaskID/Get/{taskID}")]
        public DataTable SarfDetailsByTaskID(string taskID)
        {
            try
            {
                return sarfDao.SarfDetailsByTaskID(taskID);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpPost]
        [Route("api/Polygon/Post")]
        public HttpResponseMessage PostPolygon([FromBody] Polygon polygon)
        {
            try
            {
                polygon.ModifiedDate = DateTime.Now;
                long polyId = sarfDao.SavePolygon(polygon, transId);
                return WrapObjectToHttpResponse(polyId);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/Test/Get")]
        public HttpResponseMessage TestGet()
        {
            try
            {
                long transId = 1;
                return WrapObjectToHttpResponse(transId);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }
    }
}
