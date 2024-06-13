The scripts in this directory were created to modify all subfolder permissions within a targetted folder. The first script applies the folder permissions while the second script changes the permissions back to what they were before. 

When the first script runs, parameters are set to determine which groups would get the appropriate folder permissions. Then the inheritence of each child folder had to be broken in order for the new permissions to be set. 

When the second script runs, it does the same thing as the first script except it defines how the permissions were set before the change took effect.