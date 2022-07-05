public with sharing class UserInfoList {

      public string sDepartment{get;set;}
      public string sCurrentUserDepartment
      {
            get;
            set;
      }
      public List<User> CurrentListofUsers
      {
            get;
            set;
      }
      public integer iUserCount
      {
            get{return CurrentListofUsers.size();}
            set;
      }
      public List<selectOption> lstDepartmentOptions
      {
            get;
            set{lstDepartmentOptions = value;}
      }
            
      public pageReference SwitchList()
      {
            
                  sDepartment = sCurrentUserDepartment;
           
            return null;
      }
}