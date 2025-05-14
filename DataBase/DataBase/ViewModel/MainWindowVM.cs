using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Core;
using DataBase.Model;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Windows.Input;
using DataBase.ViewModel.TabTableViewModel;
using DataBase.Model;
namespace DataBase.ViewModel
{
    public class MainWindowVM : ObservableObject
    {
        private List<BaseVM> cachedVM;
        private BaseVM? _selectedVM;
        private string _currentTabTag = "Views";
        public BaseVM? SelectedVM 
        {
            get { return _selectedVM; }
            set { _selectedVM = value; LogTable = Database.GetLogTableData(); OnPropertyChanged(); }
        }
        public string CurrentTabTag 
        {
            get { return _currentTabTag; }
            set 
            { 
                if(_currentTabTag != value) 
                {
                    _currentTabTag = value;
                    UpdateView(value);
                    LogTable = Database.GetLogTableData();
                    OnPropertyChanged();
                }
            }
        }
        private DataTable _logTable;
        public DataTable LogTable 
        {
            get { return _logTable; }
            set 
            {
                _logTable = value;
                OnPropertyChanged();
            }
        }
        public string Role { get; set; }
        //Доступ к функционалу в зависимости от роли
        public bool IsEmployee { get; set; }
        public bool IsManager { get; set; }
        public bool IsAdmin { get; set; }
        public string AreLogsHidden { get; set; }
        public MainWindowVM()
        {
            cachedVM = new() { new ViewsVM(), new ProceduresVM(), new ManagerVM(), new AdminVM() };
            SelectedVM = cachedVM[0];
            Role = Model.User.Role;
            LogTable = Database.LogTable;

            IsEmployee = User.Role == "Employee" || User.Role == "Manager" || User.Role == "Admin" ? true : false;
            IsManager = User.Role == "Manager" || User.Role == "Admin" ? true : false;
            IsAdmin = User.Role == "Admin" ? true : false;
            if(User.Role == "Employee") 
            {
                AreLogsHidden = "Hidden";
            }
            if (User.Role == "Manager")
            {
                AreLogsHidden = "Hidden";
            }
            if (User.Role == "Admin")
            {
                AreLogsHidden = "Visible";
            }
        }
        public void UpdateView(string tag) 
        {
            if(tag == null) 
            {
                return;
            }
            switch (tag) 
            {
                case "Views": 
                    {
                        SelectedVM = cachedVM[0];
                        break;
                    }
                case "Procedures":
                    {
                        SelectedVM = cachedVM[1];
                        break;
                    }
                case "Manager":
                    {
                        SelectedVM = cachedVM[2];
                        break;
                    }
                case "Admin": 
                    {
                        SelectedVM = cachedVM[3];
                        break;
                    }
                default: 
                    {
                        SelectedVM = cachedVM[0];
                        break;
                    }
            }

        }
    }
}
