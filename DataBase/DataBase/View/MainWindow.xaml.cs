using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using DataBase.View;
using DataBase.ViewModel;
using DataBase.Model;

namespace DataBase;

/// <summary>
/// Interaction logic for MainWindow.xaml
/// </summary>
public partial class MainWindow : Window
{
    public MainWindow()
    {
        LoginWindow loginWindow = new();
        if (loginWindow.ShowDialog() == true) 
        {
            MainWindowVM VM = new();
            this.DataContext = VM;
            InitializeComponent();
        }
        else 
        {
            this.Close();
        }
    }
}