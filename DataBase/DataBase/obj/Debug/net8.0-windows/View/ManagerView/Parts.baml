   M S B A M L   `   `   `  ����C  ?DataBase, Version=1.0.0.0, Culture=neutral, PublicKeyToken=nullE'clr-namespace:DataBase.View.ManagerViewDataBase.View.ManagerView  5      %    DataBase.View.ManagerView.Parts   5      W SPresentationCore, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=8.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      9local'clr-namespace:DataBase.View.ManagerView     5      .��5	      �   � RowDefinitions  5
   
   �� 5      $
��Auto �6   �� 5      $��* �6    � ColumnDefinitions 5   
   �� 5      $��* �6   �� 5      $��* �6   �� 5      $��* �6   .+�5   
   �� $��0��6   $��5q�6%   .+�5      �� $��INSERT��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5      $��PartName (Necessarily)��6   �� 5      $��0 0 0 5q�60   ��6   �� *
PartName+60   �� 5      $��Price (>=0)��6   �� 5      $��0 0 0 5q�6-   ��6   �� *Price+6-   �� 5      $��Execute insert��6   $��INSERT��5       $	��150��5!      $��Center=�5"      $��0 20 0 0q�5#      ��5      �� *ExecuteQueryCommand+5#      5$      �� 5'   
   $��1��6   $��5q�6%   .+�5(      �� $��UPDATE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5*      $��Id (Necessarily)��6   �� 5+      $��0 0 0 5q�6*   ��6   �� *Id+6*   �� 5-      $��PartName (Necessarily)��6   �� 5.      $��0 0 0 5q�60   ��6   �� *
PartName+60   �� 50      $��Price (>=0)��6   �� 51      $��0 0 0 5q�6-   ��6   �� *Price+6-   �� 53      $��Execute update��6   $��UPDATE��55      $	��150��56      $��Center=�57      $��0 20 0 0q�58      ��54      �� *ExecuteQueryCommand+58      59      �� 5<   
   $��2��6   $��5q�6%   .+�5=      �� $��DELETE��6   $��Center=�6%   $��18(�6B   $
��Bold"�6P   �� 5?      $��Id (Necessarily)��6   �� 5@      $��0 0 0 5q�6*   ��6   �� *Id+6*   �� 5B      $��Execute delete��6   $��DELETE��5D      $	��150��5E      $��Center=�5F      $��0 20 0 0q�5G      ��5C      �� *ExecuteQueryCommand+5G      5H      &   System.Windows.Controls.DataGrid  5K   
   $��1��6   $��3��5L         AutoGenerateColumns$
 True��5N         
IsReadOnly$
 True��5O      $��5q�5P      ��5M      �� *
QueryTable+5P      5Q      5R      