{ config, pkgs, ... }:

{
  # Set your username and home directory
  home.username = "david";
  home.homeDirectory = "/Users/david";

  # Enable Home Manager
  programs.home-manager.enable = true;

  # Specify the state version for compatibility
  home.stateVersion = "21.05"; 

  # Define additional file configurations if necessary
  home.file = {
    # Example:
    # ".zshrc".text = ''
    #   export PATH=$HOME/.local/bin:$PATH
    #   # Add more custom configurations here
    # '';
  };

  # Define session variables if needed
  home.sessionVariables = {
    # Example:
     EDITOR = "nvim";
    # Add more environment variables here
  };
}

