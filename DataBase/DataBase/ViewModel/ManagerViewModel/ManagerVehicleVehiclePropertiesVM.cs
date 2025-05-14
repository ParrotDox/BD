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
    public class ManagerVehicleVehiclePropertiesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? VehicleId { get; set; }
        public int? PropertyId { get; set; }
        public string? Val { get; set; }

        // Конструктор
        public ManagerVehicleVehiclePropertiesVM()
        {
            VehicleId = 0;
            PropertyId = 0;
            Val = string.Empty;
            QueryTable = FormTable();
        }

        // Метод для формирования SQL-команд (INSERT, UPDATE, DELETE)
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                INSERT INTO VehicleVehicleProperties 
                (VehicleId, PropertyId, Val) 
                VALUES 
                (@VehicleId, @PropertyId, @Val)";

                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    command.Parameters.AddWithValue("@Val", Val);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE VehicleVehicleProperties 
                SET 
                    VehicleId = @VehicleId,
                    PropertyId = @PropertyId,
                    Val = @Val
                WHERE 
                    VehicleId = @VehicleId AND PropertyId = @PropertyId";

                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    command.Parameters.AddWithValue("@Val", Val);
                    break;

                case "DELETE":
                    command.CommandText = @"
                DELETE FROM VehicleVehicleProperties 
                WHERE VehicleId = @VehicleId AND PropertyId = @PropertyId";

                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы VehicleVehicleProperties
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM VehicleVehicleProperties", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
