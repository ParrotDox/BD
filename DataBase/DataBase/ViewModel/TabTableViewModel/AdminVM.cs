using DataBase.Core;
using DataBase.Model;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Data;

namespace DataBase.ViewModel.TabTableViewModel
{
    public class AdminVM : BaseVM
    {
        private string _sqlCommand;
        private string _resultText;
        private DataTable _queryTable;
        public string SqlCommand
        {
            get => _sqlCommand;
            set
            {
                _sqlCommand = value;
                OnPropertyChanged();
            }
        }

        public string ResultText
        {
            get => _resultText;
            set
            {
                _resultText = value;
                OnPropertyChanged();
            }
        }
        public DataTable QueryTable
        {
            get { return _queryTable; }
            set
            {
                _queryTable = value;
                OnPropertyChanged();
            }
        }
        public ICommand ExecuteCommand { get; }

        public AdminVM()
        {
            ExecuteCommand = new RelayCommand(ExecuteSqlCommand, null);
            QueryTable = new();
        }

        private void ExecuteSqlCommand(object? sender)
        {
            if (string.IsNullOrWhiteSpace(SqlCommand))
            {
                ResultText = "Введите команду SQL.";
                return;
            }

            try
            {
                var cmd = new SqlCommand(SqlCommand);
                DataTable result = Database.ExecuteQueryReturnTable(cmd);  // Вызываем метод из твоего класса
                if (result.Rows.Count > 0)
                {
                    QueryTable = result;
                }
                else
                {
                    ResultText = "Запрос выполнен успешно.";
                }
            }
            catch (Exception ex)
            {
                ResultText = $"Ошибка: {ex.Message}";
            }
        }
    }
}
