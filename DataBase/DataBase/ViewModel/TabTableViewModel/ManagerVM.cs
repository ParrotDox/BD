using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Core;
using System.Windows.Input;
using System.Windows;
using DataBase.ViewModel.ManagerViewModel;
using DataBase.ViewModel.ProcedureViewModel;

namespace DataBase.ViewModel.TabTableViewModel
{
    public class ManagerVM : BaseVM
    {
        private List<ManagerBaseVM> _cachedProceduresVM;
        private ManagerBaseVM? _selectedVM;
        private string? _currentTabTag = "Employees";
        public string? CurrentTabTag 
        {
            get { return _currentTabTag; }
            set 
            { 
                _currentTabTag = value;
                UpdateView(value);
                OnPropertyChanged();
            }
        }
        public ManagerBaseVM? SelectedVM
        {
            get { return _selectedVM; }
            set { _selectedVM = value; OnPropertyChanged(); }
        }
        public ManagerVM()
        {
            _cachedProceduresVM = new() {
                new ManagerEmployeesVM(),
                new ManagerVehiclesVM(),
                new ManagerAssetsVM(),
                new ManagerRoutesVM(),
                new ManagerBrigadesVM(),
                new ManagerTechServicesVM(),
                new ManagerPartsVM(),
                new ManagerEmployeePropertiesVM(),
                new ManagerEmployeeEmployeePropertiesVM(),
                new ManagerVehiclePropertiesVM(),
                new ManagerVehicleVehiclePropertiesVM(),
                new ManagerEmployeeVehiclesVM(),
                new ManagerTransitsVM(),
                new ManagerAssetTypesVM(),
                new ManagerTechServicePartsVM()
            };
            SelectedVM = _cachedProceduresVM[0];
        }
        private void UpdateView(object? param)
        {
            if (param is null)
            {
                return;
            }
            switch (param.ToString())
            {
                case "Employees":
                    {
                        SelectedVM = _cachedProceduresVM[0];
                        break;
                    }
                case "Vehicles":
                    {
                        SelectedVM = _cachedProceduresVM[1];
                        break;
                    }
                case "Assets":
                    {
                        SelectedVM = _cachedProceduresVM[2];
                        break;
                    }
                case "Routes":
                    {
                        SelectedVM = _cachedProceduresVM[3];
                        break;
                    }
                case "Brigades":
                    {
                        SelectedVM = _cachedProceduresVM[4];
                        break;
                    }
                case "TechServices":
                    {
                        SelectedVM = _cachedProceduresVM[5];
                        break;
                    }
                case "Parts":
                    {
                        SelectedVM = _cachedProceduresVM[6];
                        break;
                    }
                case "EmployeeProperties":
                    {
                        SelectedVM = _cachedProceduresVM[7];
                        break;
                    }
                case "EmployeeEmployeeProperties":
                    {
                        SelectedVM = _cachedProceduresVM[8];
                        break;
                    }
                case "VehicleProperties":
                    {
                        SelectedVM = _cachedProceduresVM[9];
                        break;
                    }
                case "VehicleVehicleProperties":
                    {
                        SelectedVM = _cachedProceduresVM[10];
                        break;
                    }
                case "EmployeeVehicle":
                    {
                        SelectedVM = _cachedProceduresVM[11];
                        break;
                    }
                case "Transits":
                    {
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                case "AssetTypes":
                    {
                        SelectedVM = _cachedProceduresVM[13];
                        break;
                    }
                case "TechServiceParts":
                    {
                        SelectedVM = _cachedProceduresVM[14];
                        break;
                    }
                case "15":
                    {
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                case "16":
                    {
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                case "17":
                    {
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                case "18":
                    {
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                default:
                    {
                        MessageBox.Show("ManagerVM index parameter is incorrect(App error).", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        break;
                    }
            }
        }
    }
}
