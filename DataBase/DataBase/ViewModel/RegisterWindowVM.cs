using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Input;
using DataBase.Core;
using DataBase.Service;
using DataBase.Model;
using Microsoft.Data.SqlClient;
using System.Data;
namespace DataBase.ViewModel
{
    public class RegisterWindowVM : ObservableObject
    {
        private Window _window;
        private Dictionary<int, string> roles = new Dictionary<int, string>() { { 0, "Employee" }, { 1, "Manager"}, { 2, "Admin"} };
        private int _selectedIndex = 0;
        private string? _login = "";
        private string? _password = "";
        public int SelectedIndex 
        {
            get 
            {
                return _selectedIndex;
            }
            set 
            {
                _selectedIndex = value;
                OnPropertyChanged();
            }
        } 
        public string? Login 
        {
            get 
            {
                return _login;
            }
            set 
            {
                _login = value;
                OnPropertyChanged();
            }
        }
        public string? Password 
        {
            get 
            {
                return _password;
            }
            set 
            {
                _password = value;
                OnPropertyChanged();
            }
        }
        public ICommand CreateUserCommand { get; set; }
        public RegisterWindowVM(Window window)
        {
            _window = window;
            CreateUserCommand = new RelayCommand(CreateUser, null);
        }
        private void CreateUser(object? param) 
        {
            if(_login is null || _password is null) 
            {
                MessageBox.Show("Input all fields before registration", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            if (_login.Length < 5 || _password.Length < 5)
            {
                MessageBox.Show("Login and password length should be 5 or more", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            if (!UserValidationService.IsOnlyEnglishAndDigits(_login) || !UserValidationService.IsOnlyEnglishAndDigits(_password)) 
            {
                MessageBox.Show("Use only English letters and digits", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            if (!UserValidationService.HasAtLeastTwoLetters(_login) || !UserValidationService.HasAtLeastTwoLetters(_password))
            {
                MessageBox.Show("Use at least two letters", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }


            bool IsUserAlreadyExists = UserValidationService.CheckUser(_login.ToLower());
            if (IsUserAlreadyExists) 
            {
                MessageBox.Show("User already exists", "Error", MessageBoxButton.OK);
                return;
            }
            else 
            {
                string query = "INSERT INTO Register(UserLogin, UserPasswordHash, UserSalt, UserRole) VALUES (@login, @passwordHash, @salt, @role)";
                string salt = PasswordHasher.GenerateSalt();
                string hashedPassword = PasswordHasher.HashPassword(_password, salt);
                string role = roles[_selectedIndex];

                SqlCommand command = new(query, Database.GetConnection());
                command.Parameters.AddWithValue("@login", _login.ToLower());
                command.Parameters.AddWithValue("@passwordHash", hashedPassword);
                command.Parameters.AddWithValue("@salt", salt);
                command.Parameters.AddWithValue("@role", role);

                Database.OpenConnection();
                if (command.ExecuteNonQuery() == 1) 
                {
                    MessageBox.Show("Account has been created", "Notification", MessageBoxButton.OK);
                    Database.CloseConnection();
                    _window.DialogResult = true;
                    _window.Close();
                }
                else 
                {
                    MessageBox.Show("Error occured during creation", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    Database.CloseConnection();
                }
            }
        }
    }
}
