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
    public class ManagerTransitsVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? Id { get; set; }
        public int? VehicleId { get; set; }
        public int? CargoQuantity { get; set; }
        public string? StartedAt { get; set; }
        public string? EndedAt { get; set; }

        // Конструктор
        public ManagerTransitsVM()
        {
            // Установим значения по умолчанию для дат
            StartedAt = DateTime.Now.ToString("yyyy-MM-dd");
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
                INSERT INTO Transits 
                (VehicleId, CargoQuantity, StartedAt, EndedAt) 
                VALUES 
                (@VehicleId, @CargoQuantity, @StartedAt, @EndedAt)";

                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    command.Parameters.AddWithValue("@CargoQuantity", CargoQuantity);
                    command.Parameters.AddWithValue("@StartedAt", StartedAt);
                    command.Parameters.AddWithValue("@EndedAt", EndedAt);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE Transits 
                SET 
                    VehicleId = @VehicleId,
                    CargoQuantity = @CargoQuantity,
                    StartedAt = @StartedAt,
                    EndedAt = @EndedAt
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@VehicleId", VehicleId);
                    command.Parameters.AddWithValue("@CargoQuantity", CargoQuantity);
                    command.Parameters.AddWithValue("@StartedAt", StartedAt);
                    command.Parameters.AddWithValue("@EndedAt", EndedAt);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Transits WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы Transits
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Transits", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
