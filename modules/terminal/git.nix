{user, ...}: {
  user-manage.programs.git = {
    enable = true;

    settings = {
      user.name = user.name;
      user.email = user.mail;
      init.defaultBranch = "main";
      core.editor = "code --wait"; # Used for git rebase -i and squash commits
    };
  };
}
