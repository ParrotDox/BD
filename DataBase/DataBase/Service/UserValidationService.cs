using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Model;

namespace DataBase.Service
{
    public static class UserValidationService
    {
        public static bool CheckUser(string login)
        {
            string query = "SELECT UserLogin FROM Register WHERE UserLogin=@login";

            SqlCommand command = new();
            command.CommandText = query;
            command.Parameters.AddWithValue("@login", login);
            command.Connection = Database.GetConnection();

            SqlDataAdapter adapter = new(command);
            DataTable table = new();

            adapter.Fill(table);

            if (table.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        public static bool IsOnlyEnglishAndDigits(string input)
        {
            return input.All(c =>
                (c >= 'a' && c <= 'z') ||
                (c >= 'A' && c <= 'Z') ||
                char.IsDigit(c)
            );
        }
        public static bool HasAtLeastTwoLetters(string input)
        {
            int letterCount = input.Count(c => char.IsLetter(c));
            return letterCount >= 2;
        }
    }
}
