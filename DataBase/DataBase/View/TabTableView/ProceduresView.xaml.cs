using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using DataBase.ViewModel.TabTableViewModel;

namespace DataBase.View.TabTableView
{
    /// <summary>
    /// Interaction logic for ProceduresView.xaml
    /// </summary>
    public partial class ProceduresView : UserControl
    {
        public ProceduresView()
        {
            ProceduresVM VM = new();
            this.DataContext = VM;
            InitializeComponent();
        }
    }
}
