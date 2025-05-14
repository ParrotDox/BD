using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace DataBase.ViewModel.ProcedureViewModel
{
    public class GetTeamMembersVM : ProcedureBaseVM
    {
        public string? EmployeeId { get; set; }

        public override SqlCommand? FormQuery()
        {
            int employeeId = 0;
            bool isEmployeeIdCorrect = int.TryParse(EmployeeId, out employeeId);
            SqlCommand command = new("EXEC sp_GetTeamMembers @EmployeeId");

            if (isEmployeeIdCorrect)
            {
                SqlParameter idParameter = new("@EmployeeId", SqlDbType.Int);
                idParameter.Value = employeeId;
                command.Parameters.Add(idParameter);
            }
            else
            {
                MessageBox.Show("Employee Id is incorrect or not inputted", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                return null;
            }

            return command;
        }
    }
}
