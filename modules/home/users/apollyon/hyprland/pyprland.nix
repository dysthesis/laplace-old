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
    command = "alacritty --class term"
    class = "term"
    size = "75% 60%"

    [scratchpads.btop]
    animation = "fromTop"
    command = "alacritty --class btop -e btop"
    class = "btop"
    size = "75% 60%"

    [scratchpads.music]
    animation = "fromRight"
    command = "alacritty --class music -e ncmpcpp"
    class = "music"
    size = "40% 60%"
  '';
}
