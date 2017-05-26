using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ATTWebAppAPI.Models
{
    public class Sarf
    {
        public int Id { set; get; }
        public string SarfName { set; get; }
        public DateTime? CreatedDate { set; get; }
        public string ProcessInstanceID { set; get; }
        public string FACode { set; get; }
        public string SearchRingId { set; get; }
        public string IPlanJob { set; get; }
        public string PaceNumber { set; get; }
        public string Market { set; get; }
        public string County { set; get; }
        public string FAType { set; get; }
        public string MarketCluster { set; get; }
        public string Region { set; get; }
        public string RFDesignEnggId { set; get; }
        public decimal AreaSqKm { set; get; }

    }
}