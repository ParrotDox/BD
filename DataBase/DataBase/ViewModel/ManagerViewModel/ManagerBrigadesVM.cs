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
    public class ManagerBrigadesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? Id { get; set; }
        public int? AssetId { get; set; }
        public int? EmployeeId { get; set; }
        public string? FormedAt { get; set; }

        // Конструктор
        public ManagerBrigadesVM()
        {
            // Установим значение по умолчанию для даты
            QueryTable = FormTable();
            FormedAt = DateTime.Now.ToString("yyyy-MM-dd");
        }

        // Переопределяем метод для создания SQL-команд
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                INSERT INTO Brigades 
                (AssetId, EmployeeId, FormedAt) 
                VALUES 
                (@AssetId, @EmployeeId, @FormedAt)";

                    command.Parameters.AddWithValue("@AssetId", AssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@FormedAt", FormedAt);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE Brigades 
                SET 
                    AssetId = @AssetId,
                    EmployeeId = @EmployeeId,
                    FormedAt = @FormedAt
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@AssetId", AssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@FormedAt", FormedAt);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Brigades WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы Brigades
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Brigades", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
