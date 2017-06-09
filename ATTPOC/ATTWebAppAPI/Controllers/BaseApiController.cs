﻿using System;
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
        int currentSarfId = 0;

        List<string> latlongList = null;
        List<string> longList = null;
        List<string> latList = null;
        List<decimal> point = null;
        List<List<decimal>> pointsToDraw = null;
        List<List<decimal>> pointsToReject = null;
        List<Node> nodes = null;
        List<Hub> hubs = null;
        List<long> hubIDList = null;

        string minLat = String.Empty;
        string maxLat = String.Empty;
        string minLong = String.Empty;
        string maxLong = String.Empty;

        decimal decMinLat;
        decimal decMaxLat;
        decimal decMinLong;
        decimal decMaxLong;
        
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

        private void SetCoordinates(string vertices)
        {
            vertices = vertices.Replace(';', ',');
            latlongList = vertices.Split(',').ToList();
            latlongList.RemoveAll(l => l.Trim().Length == 0);
            longList = latlongList.Where(l => l.StartsWith("-")).ToList();
            latList = latlongList.Where(l => !l.StartsWith("-")).ToList();
            minLat = latList.Min();
            maxLat = latList.Max();
            minLong = longList.Min();
            maxLong = longList.Max();

            decimal.TryParse(minLat, out decMinLat);
            decimal.TryParse(maxLat, out decMaxLat);
            decimal.TryParse(minLong, out decMinLong);
            decimal.TryParse(maxLong, out decMaxLong);
        }

        private void SaveHubs(List<List<decimal>> points, Polygon polygon)
        {
            List<decimal> vertex = new List<decimal>();
            pointsToReject = new List<List<decimal>>();
            hubs = new List<Hub>();
            hubIDList = new List<long>();
            int midIndex = points.Count / 2;
            if (points.Count == 1)
            {
                Hub hub = null;
                Random random = new Random(1000);
                var randomNumber = random.Next(9999).ToString();
                vertex = points[0];
                pointsToReject.Add(vertex);
                hub = new Hub
                {
                    SarfId = currentSarfId,
                    Latitude = vertex[1],// decMaxLat,
                    Longitude = vertex[0], //decMaxLong,
                    Address = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                    DateCreated = DateTime.Now
                };
                hubs.Add(hub);
            }
            else 
            {
                Hub hub = null;
                Random random = new Random(1000);
                var randomNumber = random.Next(9999).ToString();
                vertex = points[0];
                pointsToReject.Add(vertex);
                hub = new Hub
                {
                    SarfId = currentSarfId,
                    Latitude = vertex[1],// decMaxLat,
                    Longitude = vertex[0], //decMaxLong,
                    Address = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                    DateCreated = DateTime.Now
                };
                hubs.Add(hub);

                if (midIndex > 1)
                {
                    randomNumber = random.Next(9999).ToString();
                    vertex = points[midIndex];
                    pointsToReject.Add(vertex);
                    hub = new Hub
                    {
                        SarfId = currentSarfId,
                        Latitude = vertex[1],// decMaxLat,
                        Longitude = vertex[0], //decMaxLong,
                        Address = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                        DateCreated = DateTime.Now
                    };
                    hubs.Add(hub);
                }

                randomNumber = random.Next(9999).ToString();
                vertex = points[points.Count - 1];
                pointsToReject.Add(vertex);
                hub = new Hub
                {
                    SarfId = currentSarfId,
                    Latitude = vertex[1],// decMaxLat,
                    Longitude = vertex[0], //decMaxLong,
                    Address = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                    DateCreated = DateTime.Now
                };
                hubs.Add(hub);
            }
            foreach (var hubItem in hubs)
            {
                hubIDList.Add(sarfDao.SaveHub(hubItem));
            }
            GenerateNodes(polygon);
        }

        private void SaveNodes(List<List<decimal>> points)
        {
            List<decimal> vertex = new List<decimal>();
            nodes = new List<Node>();
            if (points.Count == 1)
            {
                Node node = null;
                Random random = new Random(1000);
                var randomNumber = random.Next(9999).ToString();
                vertex = points.First();
                node = new Node
                {
                    SarfId = currentSarfId,
                    HubId = (int)hubIDList[0],
                    Latitude = vertex[1],// decMaxLat,
                    Longitude = vertex[0], //decMaxLong,
                    AtollSiteName = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                    iPlanJobNumber = "WR-RWOR-" + currentSarfId + "-0" + randomNumber,
                    PaceNumber = "MRGE000" + currentSarfId + "-0" + randomNumber,
                    DateCreated = DateTime.Now
                };
                nodes.Add(node);
            }
            else
            {
                List<List<decimal>> mappedList = new List<List<decimal>>();
                List<List<decimal>> notMappedList = new List<List<decimal>>();
                int filterLength = points.Count * 3 / 4;
                mappedList.AddRange(points.Take(10).ToList());
                notMappedList.AddRange(points.Skip(mappedList.Count).Take(points.Count - mappedList.Count).ToList());
                int midIndex = mappedList.Count / 3;
                int hubCount = 0;
                Node node = null;
                int checkCount = 0;

                //adding nodes with mapping hub
                for (var count = 0; count < mappedList.Count; count++)
                {
                    checkCount++;
                    Random random = new Random(1000);
                    var randomNumber = random.Next(9999).ToString();
                    vertex = mappedList[count];
                    node = new Node
                    {
                        SarfId = currentSarfId,
                        HubId = (int)hubIDList[hubCount],
                        Latitude = vertex[1],// decMaxLat,
                        Longitude = vertex[0], //decMaxLong,
                        AtollSiteName = "SITE SF-" + currentSarfId + (int)hubIDList[hubCount] + "-0" + randomNumber,
                        iPlanJobNumber = "WR-RWOR-" + currentSarfId + (int)hubIDList[hubCount] + "-0" + randomNumber,
                        PaceNumber = "MRGE000" + currentSarfId + (int)hubIDList[hubCount] + "-0" + randomNumber,
                        DateCreated = DateTime.Now
                    };
                    nodes.Add(node);
                    if (checkCount == midIndex)
                    {
                        hubCount++;
                        checkCount = 0;
                        if (hubCount >= hubIDList.Count)
                        {
                            hubCount = hubIDList.Count - 1;
                        }
                    }
                }

                //adding nodes without mapping hub
                for (var count = 0; count < notMappedList.Count; count++)
                {
                    Random random = new Random(1000);
                    var randomNumber = random.Next(9999).ToString();
                    vertex = notMappedList[count];
                    node = new Node
                    {
                        SarfId = currentSarfId,
                        HubId = 0,
                        Latitude = vertex[1],// decMaxLat,
                        Longitude = vertex[0], //decMaxLong,
                        AtollSiteName = "SITE SF-" + currentSarfId + "-0" + randomNumber,
                        iPlanJobNumber = "WR-RWOR-" + currentSarfId + "-0" + randomNumber,
                        PaceNumber = "MRGE000" + currentSarfId + "-0" + randomNumber,
                        DateCreated = DateTime.Now
                    };
                    nodes.Add(node);
                }
            }
            
            foreach (var nodeItem in nodes)
            {
                sarfDao.SaveNode(nodeItem);
            }
        }

        protected bool GenerateNodesAndHubs(Polygon polygon)
        {
            try
            {
                currentSarfId = polygon.SarfId;
                return GenerateHubs(polygon);
            }
            catch (Exception ex)
            {
                return false;
            }
        }

        private bool GenerateHubs(Polygon polygon)
        {
            try
            {
                var polyArray = GeneratePolyArray(polygon.Vertices);
                SetCoordinates(polygon.Vertices);
                List<LatLong> latLongs = new List<LatLong>();

                decimal hubLat;
                decimal hubLong;
                decimal latAddSub;
                decimal longAddSub;
                decimal decMidLat = (decMinLat + decMaxLat) / 2;
                decimal decMidLong = (decMinLong + decMaxLong) / 2;

                //for (decimal latDivider = 0.1M, longDivider = 0.1M;
                //latDivider <= 0.9M && longDivider <= 0.9M;
                //latDivider += 0.15M, longDivider += 0.15M)
                for (decimal latDivider = 0.1M; latDivider <= 0.6M; latDivider += 0.2M)
                {
                    for (decimal longDivider = 0.2M; longDivider <= 0.8M; longDivider += 0.3M)
                    {
                        //Top Left
                        latAddSub = (decMaxLat - decMidLat) * latDivider;
                        longAddSub = (decMaxLong - decMidLong) * longDivider;
                        hubLat = decMidLat + latAddSub;
                        hubLong = decMidLong + longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        //Botton Left
                        latAddSub = (decMidLat - decMinLat) * latDivider;
                        hubLat = decMidLat - latAddSub;
                        longAddSub = (decMaxLong - decMidLong) * longDivider;
                        hubLong = decMidLong + longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        //Botton Right
                        latAddSub = (decMidLat - decMinLat) * latDivider;
                        hubLat = decMidLat - latAddSub;
                        longAddSub = (decMidLong - decMinLong) * longDivider;
                        hubLong = decMidLong - longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        ////Top Right
                        //latAddSub = (decMidLat - decMinLat) * latDivider;
                        //hubLat = decMidLat + latAddSub;
                        //longAddSub = (decMidLong - decMinLong) * longDivider;
                        //hubLong = decMidLong - longAddSub;
                        //latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong }); 
                    }
                }

                for (decimal latDivider = 0.4M; latDivider <= 0.9M; latDivider += 0.3M)
                {
                    for (decimal longDivider = 0.3M; longDivider <= 0.9M; longDivider += 0.35M)
                    {
                        //Top Left
                        latAddSub = (decMaxLat - decMidLat) * latDivider;
                        longAddSub = (decMaxLong - decMidLong) * longDivider;
                        hubLat = decMidLat + latAddSub;
                        hubLong = decMidLong + longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        //Botton Left
                        //latAddSub = (decMidLat - decMinLat) * latDivider;
                        //hubLat = decMidLat - latAddSub;
                        //longAddSub = (decMaxLong - decMidLong) * longDivider;
                        //hubLong = decMidLong + longAddSub;
                        //latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        //Botton Right
                        latAddSub = (decMidLat - decMinLat) * latDivider;
                        hubLat = decMidLat - latAddSub;
                        longAddSub = (decMidLong - decMinLong) * longDivider;
                        hubLong = decMidLong - longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });

                        //Top Right
                        latAddSub = (decMidLat - decMinLat) * latDivider;
                        hubLat = decMidLat + latAddSub;
                        longAddSub = (decMidLong - decMinLong) * longDivider;
                        hubLong = decMidLong - longAddSub;
                        latLongs.Add(new LatLong() { Latitude = hubLat, Longitude = hubLong });
                    }
                }

                sarfDao = new SarfDao();
                pointsToDraw = new List<List<decimal>>();
                var sortedList = new List<List<decimal>>();
                foreach (var item in latLongs)
                {
                    point = new List<decimal>();
                    point.Add(item.Longitude);
                    point.Add(item.Latitude);
                    bool isValid = isPointInside(point, polyArray);
                    if (isValid)
                    {
                        pointsToDraw.Add(point);
                        
                    }
                }
                sortedList = pointsToDraw.OrderBy(p => p[0]).ToList();
                pointsToDraw = sortedList;
                SaveHubs(pointsToDraw, polygon);
                return true;
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
                SetCoordinates(polygon.Vertices);
                var nodePoints = pointsToDraw.Except(pointsToReject).ToList();
                SaveNodes(nodePoints);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
