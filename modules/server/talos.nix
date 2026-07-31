{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  environment.sessionVariables = {
    CONTROL_PLANE_IP="192.168.88.153";
    WORKER_IP_1="192.168.88.154";
    WORKER_IP_2="192.168.88.155";
    CLUSTER_NAME="fishstall";
    KUBECONFIG="/home/lem0nbleach/dev/talos/alternative-kubeconfig";
  };
}
