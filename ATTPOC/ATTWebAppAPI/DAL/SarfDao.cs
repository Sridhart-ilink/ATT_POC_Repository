using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;
using System.Configuration; 
using System.Data;
using ATTWebAppAPI.Models;

namespace ATTWebAppAPI.DAL
{
    public class SarfDao
    {
        static string connString = ConfigurationManager.ConnectionStrings["default"].ConnectionString;

        public DataTable GetSarfDetails()
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT S.SARFID,S.SARFNAME,S.ProcessInstanceID, S.SarfStatus, S.AtollSiteName, S.RF_Design_Engineer_ATTUID, P.Vertices,P.AreaInSqKm FROM SARF S JOIN Polygon P ON S.SarfId=P.SarfId order by S.DateCreated desc;";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public long SaveSarf(Sarf sarf)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    long id = 0;
                    string query = "INSERT INTO SARF(SarfName,DateCreated,ProcessInstanceID, "+
                        "SarfStatus, AtollSiteName, FA_Code, Search_Ring_ID, iPlan_Job, " +
                        "Pace, Market, County, FA_Type, Market_Cluster, Region, RF_Design_Engineer_ATTUID) VALUES(" +
                        "?SarfName,?DateCreated,?ProcessInstanceID, ?SarfStatus, "+
                        "?AtollSiteName, ?FA_Code, ?Search_Ring_ID, ?iPlan_Job, ?Pace, ?Market,"+
                        "?County, ?FA_Type, ?Market_Cluster, ?Region, ?RF_Design_Engineer_ATTUID);";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {                           
                        cmd.Parameters.Add("?SarfName", MySqlDbType.VarChar).Value = sarf.SarfName;
                        cmd.Parameters.Add("?DateCreated", MySqlDbType.DateTime).Value = sarf.CreatedDate;
                        cmd.Parameters.Add("?ProcessInstanceID", MySqlDbType.VarChar).Value = sarf.ProcessInstanceID;
                        cmd.Parameters.Add("?SarfStatus", MySqlDbType.VarChar).Value = sarf.SarfStatus;
                        cmd.Parameters.Add("?AtollSiteName", MySqlDbType.VarChar).Value = sarf.AtollSiteName;
                        cmd.Parameters.Add("?FA_Code", MySqlDbType.VarChar).Value = sarf.FACode;
                        cmd.Parameters.Add("?Search_Ring_ID", MySqlDbType.VarChar).Value = sarf.SearchRingId;
                        cmd.Parameters.Add("?iPlan_Job", MySqlDbType.VarChar).Value = sarf.IPlanJob;
                        cmd.Parameters.Add("?Pace", MySqlDbType.VarChar).Value = sarf.PaceNumber;
                        cmd.Parameters.Add("?Market", MySqlDbType.VarChar).Value = sarf.Market;
                        cmd.Parameters.Add("?County", MySqlDbType.VarChar).Value = sarf.County;
                        cmd.Parameters.Add("?FA_Type", MySqlDbType.VarChar).Value = sarf.FAType;
                        cmd.Parameters.Add("?Market_Cluster", MySqlDbType.VarChar).Value = sarf.MarketCluster;
                        cmd.Parameters.Add("?Region", MySqlDbType.VarChar).Value = sarf.Region;
                        cmd.Parameters.Add("?RF_Design_Engineer_ATTUID", MySqlDbType.VarChar).Value = sarf.RFDesignEnggId;
                        cmd.ExecuteNonQuery();
                        id = cmd.LastInsertedId;

                    }
                    return id;
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }
        
        public long SaveNode(Node node)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    long id = 0;
                    string query = "INSERT INTO NODE(SarfId,Latitude,Longitude, AtollSiteName," +
                        "iPlanJobNumber, PaceNumber, DateCreated, DateModified) VALUES" +
                        "(?SarfId,?Latitude,?Longitude, ?AtollSiteName,?iPlanJobNumber, " +
                        "?PaceNumber, ?DateCreated, ?DateModified);";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        cmd.Parameters.Add("?SarfId", MySqlDbType.Int32).Value = node.SarfId;
                        cmd.Parameters.Add("?Latitude", MySqlDbType.Decimal).Value = node.Latitude;
                        cmd.Parameters.Add("?Longitude", MySqlDbType.Decimal).Value = node.Longitude;
                        cmd.Parameters.Add("?AtollSiteName", MySqlDbType.VarChar).Value = node.AtollSiteName;

                        cmd.Parameters.Add("?iPlanJobNumber", MySqlDbType.VarChar).Value = node.iPlanJobNumber;
                        cmd.Parameters.Add("?PaceNumber", MySqlDbType.VarChar).Value = node.PaceNumber;
                        cmd.Parameters.Add("?DateCreated", MySqlDbType.Datetime).Value = DateTime.Now;
                        cmd.Parameters.Add("?DateModified", MySqlDbType.Datetime).Value = DateTime.Now;
                        cmd.ExecuteNonQuery();
                        id = cmd.LastInsertedId;

                    }
                    return id;
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public DataTable GetNodeByID(int nodeId)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT * from NODE WHERE NodeId=" + nodeId + ";";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }
        
        public DataTable GetNodesBySarfID(int sarfId)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT * from NODE WHERE SarfId=" + sarfId + ";";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public void UpdateSarf(Sarf sarf)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "update sarf set SarfName='" + sarf.SarfName + "',FA_Code='" + 
                        sarf.FACode + "',Search_Ring_ID='" + sarf.SearchRingId + "',iPlan_Job='" + 
                        sarf.IPlanJob + "',Pace='" + sarf.PaceNumber + "',Market='" + sarf.Market + 
                        "',County='" + sarf.County + "',FA_Type='" + sarf.FAType + 
                        "',Market_Cluster='" + sarf.MarketCluster + "',Region='" + sarf.Region + 
                        "',RF_Design_Engineer_ATTUID='" + sarf.RFDesignEnggId + "' where SarfId='" + 
                        sarf.Id + "';";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public void UpdateSarfStatus(Sarf sarf)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "update sarf set SarfStatus='" + sarf.SarfStatus + 
                        "' where SarfId='" + sarf.Id + "';";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public DataTable GetAllSarfDetails(int sarfId)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT s.SarfName,s.FA_Code,s.Search_Ring_ID,s.iPlan_Job, " +
                        "s.Pace,s.Market,s.County,s.FA_Type,s.Market_Cluster,s.Region," +
                        "s.RF_Design_Engineer_ATTUID, s.SarfStatus, s.AtollSiteName, p.AreaInSqKm " +
                        "FROM SARF s INNER JOIN Polygon p ON s.SarfId = p.SarfId WHERE " + 
                        "s.SarfId=" + sarfId + ";";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public string GetSarfStatusByID(int id)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT SarfStatus from SARF WHERE SarfId=" + id + ";";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        var status = cmd.ExecuteScalar().ToString();
                        return status;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public DataTable SarfDetailsByTaskID(string taskID)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT s.SarfName,s.FA_Code,s.Search_Ring_ID,s.iPlan_Job, s.Pace,s.Market,s.County,s.FA_Type,s.Market_Cluster,s.Region,s.RF_Design_Engineer_ATTUID, s.SarfStatus, s.AtollSiteName, p.AreaInSqKm FROM SARF s INNER JOIN Polygon p ON s.SarfId = p.SarfId WHERE ProcessInstanceID='" + taskID + "';";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public int SavePolygon(Polygon polygon, long sarfId)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    long id = 0;
                    string query = "INSERT INTO SARF(SarfName,DateCreated) VALUES(?SarfName,?DateCreated);";
                    cn.Open();
                    if (sarfId > 0)
                    {
                        decimal area;
                        decimal.TryParse(polygon.AreaInSqKm, out area);

                        query = "INSERT INTO Polygon(Vertices,SarfId, AreaInSqKm, DateCreated,DateModified) VALUES(?Vertices, ?SarfId, ?AreaInSqKm, ?DateCreated,?DateModified);";
                        using (MySqlCommand cmd = new MySqlCommand(query, cn))
                        {
                            cmd.Parameters.Add("?SarfId", MySqlDbType.Int32).Value = sarfId;
                            cmd.Parameters.Add("?Vertices", MySqlDbType.VarChar).Value = polygon.Vertices;
                            cmd.Parameters.Add("?AreaInSqKm", MySqlDbType.Decimal).Value = area;
                            cmd.Parameters.Add("?DateCreated", MySqlDbType.DateTime).Value = DateTime.Now;
                            cmd.Parameters.Add("?DateModified", MySqlDbType.DateTime).Value = DateTime.Now;
                            return cmd.ExecuteNonQuery();
                        }
                    }
                    return 0;
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }

        public DataTable GetAllPolygons()
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT P.Vertices FROM SARF S JOIN Polygon P ON S.SarfId=P.SarfId order by S.DateCreated desc;";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {
                        MySqlDataAdapter returnVal = new MySqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        returnVal.Fill(dt);
                        return dt;
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception("Data Error : " + ex.Message);
                }
                finally
                {
                    if (cn.State == System.Data.ConnectionState.Open)
                    {
                        cn.Close();
                    }
                }
            }
        }
    }
}