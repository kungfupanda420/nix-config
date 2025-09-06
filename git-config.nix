{config, pkgs, ...}:

{
    programs.git={
        enable=true;
        config={
            user.name="kungfupanda420";
            user.email="pratheek18183@gmail.com";
            core.editor="code --wait";
            init.defaultBranch="main";
        };
    };
}
