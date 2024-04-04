{pkgs, ...}: {
  home.packages = [
    (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "2.0.9";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-dyuqLjh6q+TyQLz0Kqjx+QeGuC0FB1dyt3lH5CYFsZA=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        python311Packages.aiofiles
        poetry
      ];
      doCheck = false;
    })
    pkgs.btop
  ];

  home.file.".config/hypr/pyprland.toml".text = ''
    [pyprland]
    plugins = [
    	"scratchpads",
    	"magnify"
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "wezterm start --class=term"
    class = "term"
    size = "75% 60%"

    [scratchpads.btop]
    animation = "fromTop"
    command = "wezterm start --class=btop -- btop"
    class = "btop"
    size = "75% 60%"

    [scratchpads.music]
    animation = "fromRight"
    command = "wezterm start --class=music -- ncmpcpp"
    class = "music"
    size = "40% 60%"

    [scratchpads.irc]
    animation = "fromTop"
    command = "wezterm start --class=irc -- weechat"
    class = "irc"
    size = "75% 60%"

    [scratchpads.signal]
    animation = "fromTop"
    command = "signal-desktop"
    class = "Signal"
    size = "75% 60%"



  '';
}
