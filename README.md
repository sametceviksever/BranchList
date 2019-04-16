Project Name: BranchList

BranchList app shows bank's branches info. App has three screen. Region List, Branch List at region and Branch Detail.  
Application calls branch list from API at launch and stores branch data in the files. First screen shows all data from API.
Second screen will open when one of the regions selected at first screen. Second screen shows branches list.
Third screen shows branch detail.

App has a few singleton classes for handle file operations, call and store data on executing and network calling.

  - AppHelper: Calls all country requests and stores data. Notifies its delegates when an error occurres or data changes.
  - File: All file operation executes on it. It checks file for data and data's validitity and decides whether the data is valid or need a new api call.
  - Network: It takes request and executes with URLSession.

All screens had developed with table view. First one uses default UITableViewCell. 
It removes empty cells and shows error when AppHelper notifies it with an error.
Second one uses custom cell. First and Second screens store selected index paths for remove selection on did appear. 
This provides user to see which one of them selected. 
Third screen uses grouped table view style and custom cell. 
Because default UITableViewCell doesn't support dynamic height with multi row key and value labels.
It has two section. First one shows non optional infos. Second one is shown when one of optional value not empty.
