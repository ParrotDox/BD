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
    public class ManagerAssetTypesVM : ManagerBaseVM
    {
        public int? Id { get; set; }
        public string? TypeName { get; set; }
        public ManagerAssetTypesVM()
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
                INSERT INTO AssetTypes (TypeName) 
                VALUES (@TypeName)";

                    command.Parameters.AddWithValue("@TypeName", TypeName ?? (object)DBNull.Value);
                    break;

                case "UPDATE":
                    command.CommandText = @"
                UPDATE AssetTypes 
                SET TypeName = @TypeName
                WHERE Id = @Id";

                    command.Parameters.AddWithValue("@Id", Id);
                    command.Parameters.AddWithValue("@TypeName", TypeName ?? (object)DBNull.Value);
                    break;

                case "DELETE":
                    command.CommandText = "DELETE FROM AssetTypes WHERE Id = @Id";
                    command.Parameters.AddWithValue("@Id", Id);
                    break;

                default:
                    return null;
            }

            return command;
        }

        public override DataTable FormTable()
        {
            SqlCommand cmd = new("SELECT * FROM AssetTypes", Database.GetConnection());
            return Database.ExecuteQueryReturnTable(cmd);
        }
    }

}
