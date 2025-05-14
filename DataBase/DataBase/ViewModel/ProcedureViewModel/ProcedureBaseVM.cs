using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using DataBase.Core;
using DataBase.Model;
using Microsoft.Data.SqlClient;
namespace DataBase.ViewModel
{
    public class ProcedureBaseVM : ObservableObject
    {
        public SqlCommand? FormedCommand { get; set; }
        public ProcedureBaseVM()
        {
            
        }
        public DataTable? ExecuteQuery() 
        {
            FormedCommand = FormQuery();
            if(FormedCommand == null || FormedCommand.CommandText == null) 
            {
                MessageBox.Show("FormedCommand is null or text for procedure is null", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return null;
            }
            else 
            {
                return Database.ExecuteQueryReturnTable(FormedCommand);
            }
        }
        public virtual SqlCommand FormQuery() 
        {
            SqlCommand command = new();
            return command;
        }
    }
}
