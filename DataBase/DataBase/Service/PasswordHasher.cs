using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace DataBase.Service
{
    public static class PasswordHasher
    {
        public static string GenerateSalt() 
        {
            byte[] saltBytes = new byte[16];
            using(var rng = RandomNumberGenerator.Create()) 
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToHexString(saltBytes);
        }
        public static string HashPassword(string? password, string? salt) 
        {
            using(SHA256 sha256 = SHA256.Create()) 
            {
                string saltedPassword = password + salt;
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(saltedPassword));
                return Convert.ToHexString(bytes);
            }
        }
    }
}
