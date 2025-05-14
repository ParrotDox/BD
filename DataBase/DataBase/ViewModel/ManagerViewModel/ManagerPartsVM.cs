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
    public class ManagerPartsVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? Id { get; set; }
        public string? PartName { get; set; }
        public int? Price { get; set; }

        // Конструктор
        public ManagerPartsVM()
        {
            // Установим значения по умолчанию
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
                INSERT INTO Parts 
                (PartName, Price) 
                VALUES 
                (@PartName, @Price)";

                    command.Parameters.AddWithValue("@PartName", PartName);
                    command.Parameters.AddWithValue("@Price", Price);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE Parts 
                SET 
                    PartName = @PartName,
                    Price = @Price
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@PartName", PartName);
                    command.Parameters.AddWithValue("@Price", Price);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Parts WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы Parts
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Parts", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
