   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:DataBase.View.ManagerViewDataBase.View.ManagerView  5      (    "DataBase.View.ManagerView.Brigades   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9local'clr-namespace:DataBase.View.ManagerView     5      .��5	      � $��10q�6     � RowDefinitions  5
   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��5q�6%   .+�5      �� $��INSERT��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   $��0 0 0 10q�6b   �� 5      $��AssetId (Nullable)��6   �� 5      $��0 0 0 5q�6/   ��6   �� *	AssetId+6/   �� 5      $��EmployeeId (Nullable)��6   �� 5      $��0 0 0 5q�62   ��6   �� *
EmployeeId+62   �� 5      $��FormedAt (yyyy-MM-dd)��6   �� 5      $��0 0 0 5q�60   ��6   �� *
FormedAt+60   �� 5!      $��Execute insert��6   $��INSERT��5#      $	��150��5$      $��Center=�5%      $��0 20 0 0q�5&      ��5"      �� *ExecuteQueryCommand+5&      5'      �� 5*   
   $��1��6   $��5q�6%   .+�5+      �� $��UPDATE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   $��0 0 0 10q�6b   �� 5-      $��Id (Necessarily)��6   �� 5.      $��0 0 0 5q�6*   ��6   �� *Id+6*   �� 50      $��AssetId (Nullable)��6   �� 51      $��0 0 0 5q�6/   ��6   �� *	AssetId+6/   �� 53      $��EmployeeId (Nullable)��6   �� 54      $��0 0 0 5q�62   ��6   �� *
EmployeeId+62   �� 56      $��FormedAt (yyyy-MM-dd)��6   �� 57      $��0 0 0 5q�60   ��6   �� *
FormedAt+60   �� 59      $��Execute update��6   $��UPDATE��5;      $	��150��5<      $��Center=�5=      $��0 20 0 0q�5>      ��5:      �� *ExecuteQueryCommand+5>      5?      �� 5B   
   $��2��6   $��5q�6%   .+�5C      �� $��DELETE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   $��0 0 0 10q�6b   �� 5E      $��Id (Necessarily)��6   �� 5F      $��0 0 0 5q�6*   ��6   �� *Id+6*   �� 5H      $��Execute delete��6   $��DELETE��5J      $	��150��5K      $��Center=�5L      $��0 20 0 0q�5M      ��5I      �� *ExecuteQueryCommand+5M      5N      &   System.Windows.Controls.DataGrid  5Q   
   $��1��6   $��3��5R         AutoGenerateColumns$
 True��5T         
IsReadOnly$
 True��5U      $��5q�5V      ��5S      �� *
QueryTable+5V      5W      5X      