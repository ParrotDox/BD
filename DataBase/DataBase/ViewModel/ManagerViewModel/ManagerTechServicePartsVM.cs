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
    public class ManagerTechServicePartsVM : ManagerBaseVM
    {
        // Свойства для привязки
        public int? Id { get; set; }
        public int? TechServiceId { get; set; }
        public int? PartId { get; set; }

        // Конструктор
        public ManagerTechServicePartsVM()
        {
            QueryTable = FormTable();
        }

        // Метод для формирования SQL команды (INSERT, UPDATE, DELETE)
        public override SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();

            switch (queryType)
            {
                case "INSERT":
                    command.CommandText = @"
                INSERT INTO TechServiceParts (TechServiceId, PartId) 
                VALUES (@TechServiceId, @PartId)";

                    command.Parameters.AddWithValue("@TechServiceId", TechServiceId);
                    command.Parameters.AddWithValue("@PartId", PartId);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE TechServiceParts 
                SET TechServiceId = @TechServiceId, PartId = @PartId
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@TechServiceId", TechServiceId);
                    command.Parameters.AddWithValue("@PartId", PartId);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM TechServiceParts WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        // Метод для формирования SQL команды для получения всех данных
        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM TechServiceParts", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
