using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ATTWebAppAPI.Models
{
    public class Polygon
    {
        public int Id { set; get; }
        public int SarfId { set; get; }
        public string Vertices { set; get; }
        public string AreaInSqKm { set; get; }
        public DateTime? CreatedDate { set; get; }
        public DateTime? ModifiedDate { set; get; }
    }
}