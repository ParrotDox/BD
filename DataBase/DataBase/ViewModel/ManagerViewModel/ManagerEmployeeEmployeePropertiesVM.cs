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
    public class ManagerEmployeeEmployeePropertiesVM : ManagerBaseVM
    {
        // Свойства для данных, которые будут отображаться в UI
        public int? EmployeeId { get; set; }
        public int? PropertyId { get; set; }
        public string? Val { get; set; }

        // Конструктор
        public ManagerEmployeeEmployeePropertiesVM()
        {
            // Установим значения по умолчанию
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
                INSERT INTO EmployeesEmployeeProperties 
                (EmployeeId, PropertyId, Val) 
                VALUES 
                (@EmployeeId, @PropertyId, @Val)";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    command.Parameters.AddWithValue("@Val", Val);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE EmployeesEmployeeProperties 
                SET 
                    Val = @Val 
                WHERE 
                    EmployeeId = @EmployeeId AND PropertyId = @PropertyId";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    command.Parameters.AddWithValue("@Val", Val);
                    break;

                case "DELETE":
                    command.CommandText = @"
                DELETE FROM EmployeesEmployeeProperties 
                WHERE EmployeeId = @EmployeeId AND PropertyId = @PropertyId";

                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId);
                    command.Parameters.AddWithValue("@PropertyId", PropertyId);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных из таблицы EmployeesEmployeeProperties
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM EmployeesEmployeeProperties", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }
}
