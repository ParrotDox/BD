using DataBase.Model;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase.ViewModel.ManagerViewModel
{
    public class ManagerRoutesVM : ManagerBaseVM
    {
        public int? Id { get; set; }
        public int? TypeId { get; set; }
        public int? LengthOfPathWay { get; set; }
        public string? StartLocation { get; set; }
        public string? EndLocation { get; set; }
        public ManagerRoutesVM()
        {
            QueryTable = FormTable();
        }
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                    INSERT INTO PathWay 
                    (TypeId, LengthOfPathWay, StartLocation, EndLocation) 
                    VALUES 
                    (@TypeId, @LengthOfPathWay, @StartLocation, @EndLocation)";

                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@LengthOfPathWay", LengthOfPathWay);
                    command.Parameters.AddWithValue("@StartLocation", StartLocation);
                    command.Parameters.AddWithValue("@EndLocation", EndLocation);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                    UPDATE PathWay 
                    SET 
                        TypeId = @TypeId, 
                        LengthOfPathWay = @LengthOfPathWay, 
                        StartLocation = @StartLocation, 
                        EndLocation = @EndLocation
                    WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@LengthOfPathWay", LengthOfPathWay);
                    command.Parameters.AddWithValue("@StartLocation", StartLocation);
                    command.Parameters.AddWithValue("@EndLocation", EndLocation);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM PathWay WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM PathWay", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
