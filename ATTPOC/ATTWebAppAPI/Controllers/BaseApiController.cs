using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web.Http;
using ATTWebAppAPI.Models;
using ATTWebAppAPI.DAL;
namespace ATTWebAppAPI.Controllers
{
    public class BaseApiController : ApiController
    {
        SarfDao sarfDao = null;
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

        protected bool GenerateNodesByVertices(Polygon polygon)
        {
            try
            {
                polygon.Vertices = polygon.Vertices.Replace(';', ',');
                List<string> latlongList = polygon.Vertices.Split(',').ToList();
                latlongList.RemoveAll(l => l.Trim().Length == 0);
                List<string> longList = latlongList.Where(l => l.StartsWith("-")).ToList();
                List<string> latList = latlongList.Where(l => !l.StartsWith("-")).ToList();
                string minLat = latList.Min();
                string maxLat = latList.Max();
                string minLong = longList.Min();
                string maxLong = longList.Max();

                decimal decMinLat;
                decimal.TryParse(minLat, out decMinLat);
                decimal decMaxLat;
                decimal.TryParse(maxLat, out decMaxLat);
                decimal decMinLong;
                decimal.TryParse(minLong, out decMinLong);
                decimal decMaxLong;
                decimal.TryParse(maxLong, out decMaxLong);

                decimal decMidLat = (decMinLat + decMaxLat) / 2;
                decimal decMidLong = (decMinLong + decMaxLong) / 2;

                List<LatLong> latLongs = new List<LatLong>();
                decimal nodeLat;
                decimal nodeLong;
                decimal latAddSub;
                decimal longAddSub;
                for (int latDivider = 2, longDivider = 2;
                    latDivider <= 5 && longDivider <= 5;
                    latDivider++, longDivider++)
                {
                    //Top Left
                    latAddSub = (decMaxLat - decMidLat) / latDivider;
                    nodeLat = decMidLat + latAddSub;
                    longAddSub = (decMaxLong - decMidLong) / longDivider;
                    nodeLong = decMidLong + longAddSub;

                    latLongs.Add(new LatLong() { Latitude = nodeLat, Longitude = nodeLong });

                    //Botton Left
                    latAddSub = (decMidLat - decMinLat) / latDivider;
                    nodeLat = decMidLat - latAddSub;
                    longAddSub = (decMaxLong - decMidLong) / longDivider;
                    nodeLong = decMidLong + longAddSub;

                    latLongs.Add(new LatLong() { Latitude = nodeLat, Longitude = nodeLong });

                    //Botton Right
                    latAddSub = (decMidLat - decMinLat) / latDivider;
                    nodeLat = decMidLat - latAddSub;
                    longAddSub = (decMidLong - decMinLong) / longDivider;
                    nodeLong = decMidLong - longAddSub;

                    latLongs.Add(new LatLong() { Latitude = nodeLat, Longitude = nodeLong });

                    //Top Right
                    latAddSub = (decMidLat - decMinLat) / latDivider;
                    nodeLat = decMidLat + latAddSub;
                    longAddSub = (decMidLong - decMinLong) / longDivider;
                    nodeLong = decMidLong - longAddSub;

                    latLongs.Add(new LatLong() { Latitude = nodeLat, Longitude = nodeLong });
                }
                

                //bool isValid = centerOfLat > decMinLat && centerOfLat < decMaxLat &&
                //    centerOfLong < decMinLong && centerOfLong > decMaxLong;
                bool isValid = true;
                if (isValid)
                {
                    List<Node> nodes = new List<Node>();

                    Random random = new Random(1000);
                    var randomNumber = random.Next(9999).ToString();
                    nodes.Add(new Node
                    {
                        SarfId = polygon.SarfId,
                        Latitude = latLongs[1].Latitude,// decMaxLat,
                        Longitude = latLongs[1].Longitude, //decMaxLong,
                        AtollSiteName = "SITE A",
                        iPlanJobNumber = "WR-RWOR-14-0" + randomNumber,
                        PaceNumber = "MRGE00014" + randomNumber
                    });
                    nodes.Add(new Node
                    {
                        SarfId = polygon.SarfId,
                        Latitude = latLongs[8].Latitude,
                        Longitude = latLongs[8].Longitude,
                        AtollSiteName = "SITE B",
                        iPlanJobNumber = "WR-RWOR-15-0" + randomNumber,
                        PaceNumber = "MRGE00015" + randomNumber
                    });
                    nodes.Add(new Node
                    {
                        SarfId = polygon.SarfId,
                        Latitude = latLongs[14].Latitude,
                        Longitude = latLongs[14].Longitude,
                        AtollSiteName = "SITE C",
                        iPlanJobNumber = "WR-RWOR-16-0" + randomNumber,
                        PaceNumber = "MRGE00016" + randomNumber
                    });
                    sarfDao = new SarfDao();
                    foreach (var node in nodes)
                    {
                        sarfDao.SaveNode(node);
                    }
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
