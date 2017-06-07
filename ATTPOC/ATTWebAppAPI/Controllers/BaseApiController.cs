using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Web.Http;
using ATTWebAppAPI.Models;
using ATTWebAppAPI.DAL;
using System.Drawing;
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

        private bool isPointInside(List<decimal> point, List<List<decimal>> vertices)
        {
            var x = point[0];
            var y = point[1];

            var inside = false;
            for (int i = 0, j = vertices.Count - 1; i < vertices.Count; j = i++)
            {
                var xi = vertices[i][0];
                var yi = vertices[i][1];
                var xj = vertices[j][0];
                var yj = vertices[j][1];

                var intersect = ((yi > y) != (yj > y))
                    && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
                if (intersect) inside = !inside;
            }

            return inside;
        }

        private List<List<decimal>> GeneratePolyArray(string vertices)
        {
            try
            {
                List<List<decimal>> polyArray = new List<List<decimal>>();
                List<string> array = vertices.Split(';').ToList();
                array.RemoveAll(l => l.Trim().Length == 0);
                foreach (string vertex in array)
                {
                    var coordinates = vertex.Split(',');
                    List<decimal> decVertex = new List<decimal>();
                    decVertex.Add(Convert.ToDecimal(coordinates[0]));
                    decVertex.Add(Convert.ToDecimal(coordinates[1]));
                    polyArray.Add(decVertex);
                }
                return polyArray;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        protected bool GenerateNodesAndHubs(Polygon polygon)
        {
            try
            {
                return GenerateHubs(polygon);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        protected bool GenerateHubs(Polygon polygon)
        {
            try
            {
                return GenerateNodes(polygon);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        protected bool GenerateNodes(Polygon polygon)
        {
            try
            {
                var polyArray = GeneratePolyArray(polygon.Vertices);
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
                for (int latDivider = 3, longDivider = 2;
                    latDivider <= 6 && longDivider <= 5;
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
                sarfDao = new SarfDao();
                foreach (var item in latLongs)
                {
                    List<decimal> point = new List<decimal>();
                    point.Add(item.Longitude);
                    point.Add(item.Latitude);
                    bool isValid = isPointInside(point, polyArray);
                    if (isValid)
                    {
                        Node node = null;
                        Random random = new Random(1000);
                        var randomNumber = random.Next(9999).ToString();
                        node = new Node
                        {
                            SarfId = polygon.SarfId,
                            Latitude = point[1],// decMaxLat,
                            Longitude = point[0], //decMaxLong,
                            AtollSiteName = "SITE SF-" + polygon.SarfId + "-0" + randomNumber,
                            iPlanJobNumber = "WR-RWOR-" + polygon.SarfId + "-0" + randomNumber,
                            PaceNumber = "MRGE000" + polygon.SarfId + "-0" + randomNumber
                        };
                        sarfDao.SaveNode(node);
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
