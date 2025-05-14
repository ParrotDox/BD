using DataBase.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using DataBase.ViewModel.ProcedureViewModel;
using System.Windows;
using System.Data;
namespace DataBase.ViewModel.TabTableViewModel
{
    public class ProceduresVM : BaseVM
    {
        private List<ProcedureBaseVM> _cachedProceduresVM;
        private ProcedureBaseVM? _selectedVM;
        private DataTable _queryTable;
        public ProcedureBaseVM? SelectedVM
        {
            get { return _selectedVM; }
            set { _selectedVM = value; OnPropertyChanged(); }
        }
        public DataTable QueryTable
        {
            get { return _queryTable; }
            set { _queryTable = value; OnPropertyChanged(); }
        }
        public ICommand ButtonOptionPressedCommand { get; set; }
        public ICommand ExecuteProcedureCommand { get; set; }
        public ProceduresVM()
        {
            _cachedProceduresVM = new() {
                new GetTransportPathWaysVM(),
                new GetVehicleAcquisitionDisposalVM(),
                new GetCargoTransportHistoryVM(),
                new GetDriversByVehicleVM(),
                new GetDriverVehicleDistributionVM(),
                new GetEmployeeHierarchyVM(),
                new GetGarageFacilitiesReportVM(),
                new GetRepairCostAnalysisVM(),
                new GetSpecialistWorkReportVM(),
                new GetTeamMembersVM(),
                new GetVehicleFleetDataVM(),
                new GetVehicleMileageReportVM(),
                new GetVehiclePartsUsageVM()
            };
            SelectedVM = _cachedProceduresVM[0];
            ButtonOptionPressedCommand = new RelayCommand(ChangeOption ,null);
            ExecuteProcedureCommand = new RelayCommand(ExecuteProcedure, null);
            QueryTable = new DataTable();
        }
        private void ChangeOption(object? param) 
        {
            if(param is null) 
            {
                return;
            }
            switch (param.ToString())
            {
                case "0": 
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[0];
                        break;
                    }
                case "1":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[1];
                        break;
                    }
                case "2":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[2];
                        break;
                    }
                case "3":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[3];
                        break;
                    }
                case "4":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[4];
                        break;
                    }
                case "5":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[5];
                        break;
                    }
                case "6":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[6];
                        break;
                    }
                case "7":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[7];
                        break;
                    }
                case "8":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[8];
                        break;
                    }
                case "9":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[9];
                        break;
                    }
                case "10":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[10];
                        break;
                    }
                case "11":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[11];
                        break;
                    }
                case "12":
                    {
                        QueryTable = new();
                        SelectedVM = _cachedProceduresVM[12];
                        break;
                    }
                default: 
                    {
                        MessageBox.Show("ProcedureVM index parameter is incorrect(App error).", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        break;
                    }
            }
        }
        private void ExecuteProcedure(object? param) 
        {
            DataTable? tempTable = SelectedVM.ExecuteQuery();
            if(tempTable == null) 
            {
                MessageBox.Show("Query is null.\nPlease check all fields before execution.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
            }
            else 
            {
                QueryTable = tempTable;
            }
        }
    }
}
