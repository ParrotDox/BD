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
    public class ManagerEmployeeVehiclesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? EmployeeId { get; set; }
        public int? VehicleId { get; set; }

        public ManagerEmployeeVehiclesVM()
        {
            QueryTable = FormTable();
        }
        // Переопределяем метод для создания SQL-команд
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                INSERT INTO EmployeeVehicles (EmployeeId, VehicleId) 
                VALUES (@EmployeeId, @VehicleId)";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE EmployeeVehicles 
                SET 
                    EmployeeId = @EmployeeId,
                    VehicleId = @VehicleId
                WHERE EmployeeId = @EmployeeId AND VehicleId = @VehicleId";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    break;

                case "DELETE":
                    command.CommandText = @"
                DELETE FROM EmployeeVehicles 
                WHERE EmployeeId = @EmployeeId AND VehicleId = @VehicleId";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы EmployeeVehicles
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM EmployeeVehicles", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
