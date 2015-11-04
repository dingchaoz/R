# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Start the matlab server on the same machine or on another machine. This
# code will *not* halt and wait for Matlab to get started so you make sure
# you wait long enough for the server to get up and running before you
# make the client try to connect (the client will by default try once a
# second for 30 seconds before giving up).
#
# Internally this code basically calls (in the background)
#
#   matlab -nodesktop -nosplash -r MatlabServer 
#
# The Windows version of Matlab does not seem to support the /r flag (one
# person reported a problem with this);
#
#   matlab /nodesktop /nosplash /r MatlabServer 
#
# So it might be that you have to start matlab and the the MatlabServer
# code "by hand":
#
#   matlab /nodesktop /nosplash 
#   >> MatlabServer 
#
# For this to work, the MatlabServer.m file and the 
# InputStreamByteWrapper.class file (and InputStreamByteWrapper.java ?) 
# has to be in the current working directory of Matlab. You will find
# these files under $R_HOME (or $R_LIBS) under library/R.matlab/data/ 
# (or type print(R.matlab$dataPath) in R to get the path).
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# options(matlab="matlab6.5")
Matlab$startServer()


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Example of the R standard output when starting Matlab from R prompt:
#
# > Matlab$startServer()
# > Warning: No window system found.  Java option 'nodesktop' ignored.
#  
#    			 < M A T L A B >
#  		     Copyright 1984-2002 The MathWorks, Inc.
#  			 Version 6.5.0.180913a Release 13
#  				   Jun 18 2002
#  
#  
#    To get started, type one of these: helpwin, helpdesk, or demo.
#    For product information, visit www.mathworks.com.
#  
#  ----------------------
#  Matlab server started!
#  ----------------------
#  Server socket created.
# >
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Start the matlab client on this machine and connect to the specified
# host (any where on the web so watch out if you are not behind a 
# firewall!). If no host is specified, "localhost" is assumed.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Create a Matlab client
matlab <- Matlab(host="localhost")

# Connect to the Matlab server
if (!open(matlab))
  throw("Matlab server is not running: waited 30 seconds.")

# Run Matlab expressions on the Matlab server
res <- evaluate(matlab, "A=1+2;", "B=ones(2,20);")

# Get Matlab variables
data <- getVariable(matlab, c("A", "B"))
cat("Recieved variables:\n")
str(data)

# Set variables in Matlab
ABCD <- matrix(rnorm(10000), ncol=100)
str(ABCD)
setVariable(matlab, ABCD=ABCD)

# Retrieve what we just set
data <- getVariable(matlab, "ABCD")
cat("Recieved variables:\n")
str(data)

# Create a function (M-file) on the Matlab server
setFunction(matlab, "          \
  function [win,aver]=dice(B)  \
  %Play the dice game B times  \
  gains=[-1,2,-3,4,-5,6];      \
  plays=unidrnd(6,B,1);        \
  win=sum(gains(plays));       \
  aver=win/B;                  \
");

evaluate(matlab, "[w,a]=dice(1000);")
res <- getVariable(matlab, c("w", "a"))
print(res)

# When done, close the Matlab client, which will also shutdown
# the Matlab server and the connection to it.
close(matlab)
