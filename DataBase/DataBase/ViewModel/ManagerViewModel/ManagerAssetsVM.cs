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
    public class ManagerAssetsVM : ManagerBaseVM
    {
        // Поля данных, соответствующие таблице Assets
        public int Id { get; set; }
        public int TypeId { get; set; }
        public int? EmployeeId { get; set; }
        public int? ParentAssetId { get; set; } // Самореференциальный ключ
        public string Address { get; set; }
        public ManagerAssetsVM()
        {
            QueryTable = FormTable();
        }
        // Метод для формирования SQL-запроса в зависимости от типа операции (INSERT, UPDATE, DELETE)
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                INSERT INTO Assets 
                (TypeId, EmployeeId, ParentAssetId, Address) 
                VALUES 
                (@TypeId, @EmployeeId, @ParentAssetId, @Address)";

                    // Привязка параметров для INSERT
                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ParentAssetId", ParentAssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Address", Address);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE Assets 
                SET 
                    TypeId = @TypeId,
                    EmployeeId = @EmployeeId,
                    ParentAssetId = @ParentAssetId,
                    Address = @Address
                WHERE Id = @Id";

                    // Привязка параметров для UPDATE
                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@TypeId", TypeId);
                    command.Parameters.AddWithValue("@EmployeeId", EmployeeId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ParentAssetId", ParentAssetId ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Address", Address);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Assets WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для получения данных в таблице
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Assets", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
