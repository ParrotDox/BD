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
    public class ManagerVehiclesVM : ManagerBaseVM
    {
        public int? Id { get; set; }
        public int? TypeId { get; set; }
        public int? StatusId { get; set; }
        public int? PathWayId { get; set; }
        public int? AssetId { get; set; }
        public string? LicensePlate { get; set; }
        public string? VehicleMake { get; set; }
        public string? VehicleModel { get; set; }
        public int? Capacity { get; set; }
        public string? IntroducedAt { get; set; }
        public string? WriteOffAt { get; set; }
        public ManagerVehiclesVM()
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
                    INSERT INTO Vehicles 
                    (TypeId, StatusId, PathWayId, AssetId, LicensePlate, 
                     VehicleMake, VehicleModel, Capacity, IntroducedAt, WriteOffAt) 
                    VALUES 
                    (@TypeId, @StatusId, @PathWayId, @AssetId, @LicensePlate, 
                     @VehicleMake, @VehicleModel, @Capacity, @IntroducedAt, @WriteOffAt)";

                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@StatusId", StatusId);
                    command.Parameters.AddWithValue("@PathWayId", PathWayId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@AssetId", AssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@LicensePlate", LicensePlate);
                    command.Parameters.AddWithValue("@VehicleMake", VehicleMake);
                    command.Parameters.AddWithValue("@VehicleModel", VehicleModel);
                    command.Parameters.AddWithValue("@Capacity", Capacity);
                    command.Parameters.AddWithValue("@IntroducedAt", IntroducedAt);
                    command.Parameters.AddWithValue("@WriteOffAt",
                        string.IsNullOrEmpty(WriteOffAt) ? (object)DBNull.Value : WriteOffAt);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                    UPDATE Vehicles 
                    SET 
                        TypeId = @TypeId,
                        StatusId = @StatusId,
                        PathWayId = @PathWayId,
                        AssetId = @AssetId,
                        LicensePlate = @LicensePlate,
                        VehicleMake = @VehicleMake,
                        VehicleModel = @VehicleModel,
                        Capacity = @Capacity,
                        WriteOffAt = @WriteOffAt
                    WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@StatusId", StatusId);
                    command.Parameters.AddWithValue("@PathWayId", PathWayId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@AssetId", AssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@LicensePlate", LicensePlate);
                    command.Parameters.AddWithValue("@VehicleMake", VehicleMake);
                    command.Parameters.AddWithValue("@VehicleModel", VehicleModel);
                    command.Parameters.AddWithValue("@Capacity", Capacity);
                    command.Parameters.AddWithValue("@WriteOffAt",
                        string.IsNullOrEmpty(WriteOffAt) ? (object)DBNull.Value : WriteOffAt);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Vehicles WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Vehicles", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }
}
