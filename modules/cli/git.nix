{
  programs.git = {
    enable = true;
    userName = "Stefan Bondzulic";
    userEmail = "stefanbondzulic@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      featch.prune = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
    };
  };
}
