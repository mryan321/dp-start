#!/bin/bash
set -e

project_path="$HOME/workspace/methods/ons";
session_name="ons-dev";
window_number=1;

startProcess() {
  # check if you have these settings and adjust if necessary:
  #   set -g base-index 1         # start windows numbering at 1
  #   setw -g pane-base-index 1   # make pane numbering consistent with windows
  window_identity="$session_name:$window_number";
  application_path="$project_path/$1";
  echo "$window_identity $application_path"
  if [ $window_number -gt 1 ]
  then
    tmux new-window -t $window_identity -n $1;
  fi
  # no split
  tmux send-keys -t "$window_identity" "cd $application_path && $2" Enter
  # with split
  # tmux split-window -h -t $window_identity;
  # tmux send-keys -t "$window_identity.1" "cd $application_path && $2" Enter
  # tmux send-keys -t "$window_identity.2" "cd $application_path" Enter
  window_number=$(($window_number + 1))
}

# https://man7.org/linux/man-pages/man1/tmux.1.html

tmux new-session -d -s $session_name -t $session_name;

# deps
startProcess 'dp-compose' 'docker-compose up -d';
startProcess 'babbage' './run.sh';
startProcess 'zebedee' './run-reader.sh';
startProcess 'sixteens' './run.sh';
sleep 30
startProcess 'dp-frontend-renderer' 'make debug';
startProcess 'dp-frontend-dataset-controller' 'make debug';
startProcess 'dp-frontend-cookie-controller' 'make debug';
startProcess 'dp-frontend-filter-dataset-controller' 'make debug';
startProcess 'dp-frontend-geography-controller' 'make debug';
startProcess 'dp-frontend-homepage-controller' 'make debug';
sleep 30
# florence?
# frontend
startProcess 'dp-frontend-router' 'make debug';
# startProcess 'dp-table-renderer' 'cd ~/go/src/github.com/onsdigital/dp-table-renderer && make debug';
# backend
# startProcess 'dp-api-router' 'make debug';
# startProcess 'dp-filter-api' 'make debug';
# startProcess 'dp-dataset-api' 'make debug';
# startProcess 'dp-code-list-api' 'make debug';
# startProcess 'dp-hierarchy-api' 'make debug';
# startProcess 'dp-search-api' 'make debug';
# startProcess 'dp-dataset-exporter' 'make debug';
# startProcess 'dp-dataset-exporter-xlsx' 'make debug';
# startProcess 'dp-download-service' 'make debug';
# startProcess 'dp-image-api' 'make debug';

# todo add some healthcheck curls...new function

tmux select-window -t $session_name:1;
tmux attach-session -t $session_name;
