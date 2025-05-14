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
    public class ManagerTechServicesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? Id { get; set; }
        public int? EmployeeId { get; set; }
        public int? VehicleId { get; set; }
        public int? Mileage { get; set; }
        public string? CarriedAt { get; set; }

        // Конструктор
        public ManagerTechServicesVM()
        {
            // Установим значение по умолчанию
            CarriedAt = DateTime.Now.ToString("yyyy-MM-dd");
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
                INSERT INTO TechServices 
                (EmployeeId, VehicleId, Mileage, CarriedAt) 
                VALUES 
                (@EmployeeId, @VehicleId, @Mileage, @CarriedAt)";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@CarriedAt", CarriedAt);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE TechServices 
                SET 
                    EmployeeId = @EmployeeId,
                    VehicleId = @VehicleId,
                    Mileage = @Mileage,
                    CarriedAt = @CarriedAt
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Mileage", Mileage);
                    command.Parameters.AddWithValue("@CarriedAt", CarriedAt);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM TechServices WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы TechServices
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM TechServices", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
