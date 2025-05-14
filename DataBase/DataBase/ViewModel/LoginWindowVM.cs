using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataBase.Core;
using DataBase.Service;
using DataBase.Model;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Windows.Input;
using System.Windows;
using DataBase.View;

namespace DataBase.ViewModel
{
    public class LoginWindowVM : ObservableObject
    {
        private Window _window;
        private string? _login = "";
        private string? _password = "";
        private bool _isAuthorized = false;
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
        public bool IsAuthorized 
        {
            get 
            {
                return _isAuthorized;
            }
            set 
            {
                _isAuthorized = value;
                OnPropertyChanged();
                if(_isAuthorized == true) 
                {
                    _window.DialogResult = true;
                    _window.Close();
                }
                else 
                {
                    MessageBox.Show("Password is incorrect", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
        public ICommand LoginUserCommand { get; set; }
        public LoginWindowVM(LoginWindow window)
        {
            _window = window;
            LoginUserCommand = new RelayCommand(LoginUser, null);
        }
        private void LoginUser(object? param)
        {
            if (_login is null || _password is null)
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


            bool IsUserExists = UserValidationService.CheckUser(_login.ToLower());
            if (IsUserExists)
            {
                string query = "SELECT UserPasswordHash, UserSalt, UserRole FROM Register WHERE @login=UserLogin";

                SqlCommand command = new(query, Database.GetConnection());
                command.Parameters.AddWithValue("@login", _login.ToLower());

                Database.OpenConnection();
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    string? storedHash = reader["UserPasswordHash"].ToString();
                    string? storedSalt = reader["UserSalt"].ToString();

                    string inputHashedPassword = PasswordHasher.HashPassword(_password, storedSalt);
                    User.Role = reader["UserRole"].ToString();
                    IsAuthorized = inputHashedPassword == storedHash ? true : false;
                    Database.CloseConnection();
                    return;
                }
                Database.CloseConnection();
                return;
            }
            else
            {
                MessageBox.Show("User with entered login doesn't exist", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
        }
    }
}
