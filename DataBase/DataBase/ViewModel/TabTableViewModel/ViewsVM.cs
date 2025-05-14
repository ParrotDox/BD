using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Core;
using Microsoft.Data.SqlClient;
using DataBase.Model;
using System.CodeDom;

namespace DataBase.ViewModel.TabTableViewModel
{
    public class ViewsVM : BaseVM
    {
        private string _currentTabTag = "Assets";
        private DataTable _queryTable;
        public DataTable QueryTable 
        {
            get { return _queryTable; }
            set { _queryTable = value;  OnPropertyChanged(); }
        }
        public string CurrentTabTag
        {
            get { return _currentTabTag; }
            set
            {
                if (_currentTabTag != value)
                {
                    _currentTabTag = value;
                    UpdateView(value);
                    OnPropertyChanged();
                }
            }
        }

        public ViewsVM()
        {
            QueryTable = new DataTable();
            UpdateView(_currentTabTag);
        }
        public void UpdateView(string tag)
        {
            if (tag == null)
            {
                return;
            }
            switch (tag)
            {
                case "Assets":
                    {
                        SqlCommand command = new("SELECT * FROM V_Assets;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Vehicles":
                    {
                        SqlCommand command = new("SELECT * FROM V_VehicleFleet;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Routes":
                    {
                        SqlCommand command = new("SELECT * FROM V_Pathways;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Employees":
                    {
                        SqlCommand command = new("SELECT * FROM V_Employees;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "EmployeePositions": 
                    {
                        SqlCommand command = new("SELECT * FROM V_EmployeePositions;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "AssetTypes":
                    {
                        SqlCommand command = new("SELECT * FROM V_AssetTypes;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Parts":
                    {
                        SqlCommand command = new("SELECT * FROM V_Parts;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "VehicleTypes": 
                    {
                        SqlCommand command = new("SELECT * FROM V_VehicleTypes;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "VehicleStatuses": 
                    {
                        SqlCommand command = new("SELECT * FROM V_VehicleStatuses;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Brigades": 
                    {
                        SqlCommand command = new("SELECT * FROM V_Brigades;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "EmployeeProperties":
                    {
                        SqlCommand command = new("SELECT * FROM V_EmployeeProperties;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "VehicleProperties": 
                    {
                        SqlCommand command = new("SELECT * FROM V_VehicleProperties;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "VehicleVehicleProperties":
                    {
                        SqlCommand command = new("SELECT * FROM V_VehicleVehicleProperties;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "EmployeeEmployeeProperties":
                    {
                        SqlCommand command = new("SELECT * FROM V_EmployeeEmployeeProperties;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "TechServices": 
                    {
                        SqlCommand command = new("SELECT * FROM V_TechServices;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "TechServicesParts":
                    {
                        SqlCommand command = new("SELECT * FROM V_TechServicesParts;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "RouteTypes":
                    {
                        SqlCommand command = new("SELECT * FROM V_RouteTypes;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                case "Transits":
                    {
                        SqlCommand command = new("SELECT * FROM V_Transits;");
                        QueryTable = Database.ExecuteQueryReturnTable(command);
                        break;
                    }
                default:
                    {
                        QueryTable = new();
                        break;
                    }
            }
        }
    }
}
