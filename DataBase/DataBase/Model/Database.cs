using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

//For SQL connection
using Microsoft.Data.SqlClient;

namespace DataBase.Model
{
    public static class Database
    {
        public static SqlConnection connection = new SqlConnection(@"Data Source=DESKTOP-JL5R5PS\SQLEXPRESS;Initial Catalog=MTEDatabase;Integrated Security=True;TrustServerCertificate=True");
        public static DataTable LogTable = GetLogTableData();
        public static void OpenConnection() 
        {
            if(connection.State == System.Data.ConnectionState.Closed) 
            {
                connection.Open();
            }
        }
        public static void CloseConnection()
        {
            if (connection.State == System.Data.ConnectionState.Open)
            {
                connection.Close();
            }
        }
        public static SqlConnection GetConnection() 
        {
            return connection;
        }
        public static DataTable ExecuteQueryReturnTable(SqlCommand? cmd)
        {
            DataTable tempTable = new();
            if (cmd == null)
            {
                return tempTable;
            }

            try
            {
                cmd.Connection = Database.GetConnection();
                Database.OpenConnection();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    tempTable.Load(reader);
                }
                return tempTable;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при выполнении запроса: {ex.Message}",
                              "Ошибка базы данных",
                              MessageBoxButton.OK,
                              MessageBoxImage.Error);
                return tempTable;
            }
            finally
            {
                Database.CloseConnection();
            }
        }

        public static int ExecuteNonQueryCommand(SqlCommand cmd)
        {
            if (cmd == null) return 0;

            try
            {
                cmd.Connection = Database.GetConnection();
                Database.OpenConnection();
                int lines = cmd.ExecuteNonQuery();
                GetLogTableData();
                return lines;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при выполнении команды: {ex.Message}",
                              "Ошибка базы данных",
                              MessageBoxButton.OK,
                              MessageBoxImage.Error);
                return 0;
            }
            finally
            {
                Database.CloseConnection();
            }
        }
        public static DataTable GetLogTableData()
        {
            SqlCommand cmd = new("Select * FROM ChangeLogs",Database.GetConnection());
            DataTable tempTable = new();
            if (cmd == null)
            {
                return tempTable;
            }
            cmd.Connection = Database.GetConnection();
            Database.OpenConnection();
            SqlDataReader reader = cmd.ExecuteReader();
            tempTable.Load(reader);
            Database.CloseConnection();
            return tempTable;
        }
    }
}
