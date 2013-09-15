% Parameters
% ----------
% 
% It is possible to pass the program parameters by running "KlustaKwik FILE n
% params" etc.  All parameters have default values. Here are the parameters you can
% use:
%  
% -help
% Prints a short message and then the default parameter values.
%  
% -MinClusters n   (default 20)
% The random intial assignment will have no less than n clusters.  The final
% number may be different, since clusters can be split or deleted during the
% course of the algorithm
%  
% -MaxClusters n   (default 30)
% The random intial assignment will have no more than n clusters.
%  
% -nStarts n       (default 1)
% The algorithm will be started n times for each inital cluster count between
% MinClusters and MaxClusters.
%  
% -SplitEvery n    (default 50)
% Test to see if any clusters should be split every n steps. 0 means don't split.
%  
% -MaxPossibleClusters n   (default 100)
% Cluster splitting can produce no more than n clusters.
%  
% -RandomSeed n    (default 1)
% Specifies a seed for the random number generator
%  
% -UseFeatures STRING   (default 11111111111100001)
% Specifies a subset of the input features to use.  STRING should consist of 1s
% and 0s with a 1 indicating to use the feature and a 0 to leave it out.  NB The
% default value for this parameter is 11111111111100001 (because this is what we
% use in the lab) - so if you have more than 12 dimensions you will need to change
% it.
%  
% -StartCluFile STRING   (default "")
% Treats the specified cluster file as a "gold standard".  If it can't find a
% better cluster assignment, it will output this.
%  
% -DistThresh d    (default 6.907755)
% Time-saving paramter.  If a point has log likelihood more than d worse for a
% given class than for the best class, the log likelihood for that class is not
% recalculated.  This saves an awful lot of time.
%  
% -FullStepEvery n (default 10)
% All log-likelihoods are recalculated every n steps (see DistThresh)
%  
% -ChangedThresh f (default 0.05)
% All log-likelihoods are recalculated if the fraction of instances changing class
% exeeds f (see DistThresh)
%  
% -MaxIter n       (default 500)
% Don't try more than n iterations from any starting point.
%  
% -Log             (default 1)
%  
% Produces .klg log file (default is yes, to switch off do -Log 0)
%  
% -Screen          (default 1)
%  
% Produces parameters and progress information on the console. Set to 0 to suppress
% output in batches.
%  
% -Debug           (default 0)
% Miscellaneous debugging information (not recommended)
%  
% -DistDump        (default 0)
% Outputs a ridiculous amount of debugging information (definately not recommended).