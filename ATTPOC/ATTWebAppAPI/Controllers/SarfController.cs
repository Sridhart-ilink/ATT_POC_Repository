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
    public class SarfController : BaseApiController
    {
        SarfDao sarfDao = null;
        static long transId = 0;
        static bool isValidArea = true;
        static int nodeOfNodes = 0;
        public SarfController()
        {
            sarfDao = new SarfDao();
        }

        [HttpPost]
        [Route("api/Sarf/Post")]
        public HttpResponseMessage PostSarf([FromBody] Sarf sarf)
        {
            try
            {
                sarf.CreatedDate = DateTime.Now;
                transId = sarfDao.SaveSarf(sarf);
                isValidArea = sarf.IsValidArea;
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

        [HttpPost]
        [Route("api/UpdateSarfStatus")]
        public HttpResponseMessage UpdateSarfStatus([FromBody] Sarf sarf)
        {
            try
            {
                sarfDao.UpdateSarfStatus(sarf);
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
        [Route("api/GetStatusByID/{id}")]
        public string GetSarfStatusByID(int id)
        {
            try
            {
                return sarfDao.GetSarfStatusByID(id);
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
                polygon.SarfId = (int)transId;
                nodeOfNodes = GenerateNodesAndHubs(polygon, isValidArea);
                return WrapObjectToHttpResponse(nodeOfNodes);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/GetAllPolygon/Get")]
        public DataTable GetAllPolygons()
        {
            try
            {
                return sarfDao.GetAllPolygons();
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

        [HttpGet]
        [Route("api/Node/Get/{nodeId}")]
        public HttpResponseMessage GetNodeByID(int nodeId)
        {
            try
            {
                var result = sarfDao.GetNodeByID(nodeId);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/Hub/Get/{hubId}")]
        public HttpResponseMessage GetHubByID(int hubId)
        {
            try
            {
                var result = sarfDao.GetHubByID(hubId);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/GetNodesBySarfID/{sarfID}")]
        public HttpResponseMessage GetNodesBySarfID(int sarfID)
        {
            try
            {
                var result = sarfDao.GetNodesBySarfID(sarfID);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpGet]
        [Route("api/GetHubsBySarfID/{sarfID}")]
        public HttpResponseMessage GetHubsBySarfID(int sarfID)
        {
            try
            {
                var result = sarfDao.GetHubsBySarfID(sarfID);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpPost]
        [Route("api/Node/Post")]
        public HttpResponseMessage SaveNode([FromBody]Node node)
        {
            try
            {
                var result = sarfDao.SaveNode(node);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }

        [HttpPost]
        [Route("api/Hub/Post")]
        public HttpResponseMessage SaveHub([FromBody]Hub hub)
        {
            try
            {
                var result = sarfDao.SaveHub(hub);
                return WrapObjectToHttpResponse(result);
            }
            catch (Exception ex)
            {
                throw new Exception("Error : " + ex.Message);
            }
        }
    }
}
