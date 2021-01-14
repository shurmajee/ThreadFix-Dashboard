# ThreadFix-Dashboard

This is a quick and dirty script to extract data from a ThreadFix server. Threadfix organises vulnerabililty related data for various applications listed under a common team name. It is possible to have multiple teams in Threadfix. The team is the root node of the data structure. In order to use this script one needs to have the following information:

- Threadfix server URL and API key
- Team Name

The script generates a simple html report which mimics the dashboard that one may see as they log in to threadfix web portal. 

# What is the point of this script?

ThreadFix does not allow efficient high level tracking of issues over long periods of time. For example, you need to see how overall numbers for a certain team have varied over the past 12 months, you would need to know how the dashboard looked like a few months back. For cases such as this the script can be used to extract data on a monthly basis and the output can be written to a folder which is synced to cloud (onedrive. box etc.). This would allow you to go back in time ato previous versions of the dashboard and generate data patterns based on that. 

I had to come up with this dirty hack because I had to keep track of how the numbers are changing over time and Threadfix does not provide an efficient way to do the same.
