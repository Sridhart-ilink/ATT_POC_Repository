using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ATTWebAppAPI.Models
{
    public class Node
    {
        public int NodeId { get; set; }
        public int SarfId { get; set; }
        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }
        public string AtollSiteName { get; set; }
        public string iPlanJobNumber { get; set; }
        public string PaceNumber { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
    }
}