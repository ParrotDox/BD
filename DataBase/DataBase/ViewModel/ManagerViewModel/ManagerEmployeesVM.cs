using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Model;
namespace DataBase.ViewModel.ManagerViewModel
{
    public class ManagerEmployeesVM : ManagerBaseVM
    {
        public int? Id { get; set; }
        public string? Forename { get; set; }
        public string? Surname { get; set; }
        public string? Patronymic { get; set; }
        public int? PositionId { get; set; }
        public int? ManagerId { get; set; } // Nullable для необязательного поля
        public int? BrigadeId { get; set; } // Nullable для необязательного поля
        public ManagerEmployeesVM()
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
                    INSERT INTO Employees 
                    (Forename, Surname, Patronymic, PositionId, ManagerId, BrigadeId) 
                    VALUES 
                    (@Forename, @Surname, @Patronymic, @PositionId, @ManagerId, @BrigadeId)";

                    command.Parameters.AddWithValue("@Forename", Forename ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Surname", Surname ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Patronymic", Patronymic ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@PositionId", PositionId);

                    // Обработка nullable int параметров
                    command.Parameters.AddWithValue("@ManagerId", ManagerId.HasValue ? (object)ManagerId.Value : DBNull.Value);
                    command.Parameters.AddWithValue("@BrigadeId", BrigadeId.HasValue ? (object)BrigadeId.Value : DBNull.Value);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                    UPDATE Employees 
                    SET 
                        Forename = @Forename,
                        Surname = @Surname,
                        Patronymic = @Patronymic,
                        PositionId = @PositionId,
                        ManagerId = @ManagerId,
                        BrigadeId = @BrigadeId
                    WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@Forename", Forename ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Surname", Surname ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@Patronymic", Patronymic ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@PositionId", PositionId);

                    // Обработка nullable int параметров
                    command.Parameters.AddWithValue("@ManagerId", ManagerId.HasValue ? (object)ManagerId.Value : DBNull.Value);
                    command.Parameters.AddWithValue("@BrigadeId", BrigadeId.HasValue ? (object)BrigadeId.Value : DBNull.Value);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM Employees WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM Employees", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }
}

//Id,Forename,Surname,Patronymic,PositionId,ManagerId,BrigadeId