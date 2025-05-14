using DataBase.Core;
using DataBase.Model;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;

namespace DataBase.ViewModel.ManagerViewModel
{
    public class ManagerBaseVM : ObservableObject
    {
        public SqlCommand? FormedCommand { get; set; }
        private DataTable _queryTable;
        public DataTable QueryTable 
        {
            get { return _queryTable; }
            set 
            { 
                _queryTable = value;
                OnPropertyChanged();
            }
        }
        public ICommand ExecuteQueryCommand { get; set; }
        public ManagerBaseVM()
        {
            _queryTable = new();
            ExecuteQueryCommand = new RelayCommand(ExecuteQuery, null);
        }
        public void ExecuteQuery(object? queryType)
        {
            if(queryType == null) 
            {
                return;
            }
            FormedCommand = FormNonQuery(queryType.ToString());
            if (FormedCommand == null || FormedCommand.CommandText == null)
            {
                MessageBox.Show("FormedCommand is null or text for procedure is null", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            else
            {
                int lines = Database.ExecuteNonQueryCommand(FormedCommand);
                QueryTable = FormTable();
                MessageBox.Show($"{lines} lines affected","Notify", MessageBoxButton.OK, MessageBoxImage.Information);
                Database.LogTable = Database.GetLogTableData();
            }
        }
        public virtual SqlCommand? FormNonQuery(string? queryType)
        {
            SqlCommand command = new();
            return command;
        }
        public virtual DataTable FormTable() 
        {
            return new();
        }
    }
}
