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
    public class ManagerVehiclePropertiesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? Id { get; set; }
        public string? PropertyName { get; set; }

        // Конструктор
        public ManagerVehiclePropertiesVM()
        {
            PropertyName = string.Empty;
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
                INSERT INTO VehicleProperties 
                (PropertyName) 
                VALUES 
                (@PropertyName)";

                    command.Parameters.AddWithValue("@PropertyName", PropertyName);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE VehicleProperties 
                SET 
                    PropertyName = @PropertyName 
                WHERE 
                    Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@PropertyName", PropertyName);
                    break;

                case "DELETE":
                    command.CommandText = @"
                DELETE FROM VehicleProperties 
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы VehicleProperties
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM VehicleProperties", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
