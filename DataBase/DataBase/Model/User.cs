using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataBase.Model
{
    public static class User
    {
        private static string? _role = "Employee";
        public static string? Role 
        {
            get { return _role; }
            set { _role = value; }
        }
    }
}
