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
                    string query = "SELECT S.SARFID,S.SARFNAME,S.ProcessInstanceID,P.Vertices,P.AreaInSqKm FROM SARF S JOIN Polygon P ON S.SarfId=P.SarfId ;";
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
                    string query = "INSERT INTO SARF(SarfName,DateCreated,ProcessInstanceID) VALUES(?SarfName,?DateCreated,?ProcessInstanceID);";
                    cn.Open();
                    using (MySqlCommand cmd = new MySqlCommand(query, cn))
                    {                           
                        cmd.Parameters.Add("?SarfName", MySqlDbType.VarChar).Value = sarf.SarfName;
                        cmd.Parameters.Add("?DateCreated", MySqlDbType.DateTime).Value = sarf.CreatedDate;
                        cmd.Parameters.Add("?ProcessInstanceID", MySqlDbType.VarChar).Value = sarf.ProcessInstanceID;
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

        public DataTable GetAllSarfDetails(int sarfId)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT SarfName,FA_Code,Search_Ring_ID,iPlan_Job,Pace,Market,County,FA_Type,Market_Cluster,Region,RF_Design_Engineer_ATTUID FROM SARF WHERE SARFID=" + sarfId + ";";
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

        public DataTable SarfDetailsByTaskID(string taskID)
        {
            using (MySqlConnection cn = new MySqlConnection(connString))
            {
                try
                {
                    string query = "SELECT s.SarfName,s.FA_Code,s.Search_Ring_ID,s.iPlan_Job, s.Pace,s.Market,s.County,s.FA_Type,s.Market_Cluster,s.Region,s.RF_Design_Engineer_ATTUID, p.AreaInSqKm FROM SARF s INNER JOIN Polygon p ON s.SarfId = p.SarfId WHERE ProcessInstanceID='" + taskID + "';";
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
                        query = "INSERT INTO Polygon(Vertices,SarfId, AreaInSqKm, DateCreated,DateModified) VALUES(?Vertices, ?SarfId, ?AreaInSqKm, ?DateCreated,?DateModified);";
                        using (MySqlCommand cmd = new MySqlCommand(query, cn))
                        {
                            cmd.Parameters.Add("?SarfId", MySqlDbType.Int32).Value = sarfId;
                            cmd.Parameters.Add("?Vertices", MySqlDbType.VarChar).Value = polygon.Vertices;
                            cmd.Parameters.Add("?AreaInSqKm", MySqlDbType.Decimal).Value = Convert.ToDecimal(polygon.AreaInSqKm);
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
                    string query = "SELECT P.Vertices FROM SARF S JOIN Polygon P ON S.SarfId=P.SarfId ;";
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