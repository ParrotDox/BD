using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace DataBase.ViewModel.ProcedureViewModel
{
    public class GetDriversByVehicleVM : ProcedureBaseVM
    {
        public string? Id { get; set; }
        public override SqlCommand? FormQuery()
        {
            int id = 0;
            bool isIdCorrect = int.TryParse(Id, out id);
            SqlCommand command = new("EXEC sp_GetDriversByVehicle @VehicleId");

            if (isIdCorrect)
            {
                SqlParameter idParameter = new("@VehicleId", SqlDbType.Int);
                idParameter.Value = id;
                command.Parameters.Add(idParameter);
            }
            else
            {
                if (Id.IsNullOrEmpty())
                {
                    SqlParameter idParameter = new("@VehicleId", SqlDbType.Int);
                    idParameter.Value = DBNull.Value;
                    command.Parameters.Add(idParameter);
                }
                else
                {
                    MessageBox.Show("Id parameter is incorrect", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return null;
                }
            }

            return command;
        }
    }
}
