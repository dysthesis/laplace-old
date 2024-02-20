{config, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"
      audio_output {
        type            "pipewire"
        name            "PipeWire Sound Server"
      }

      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
      audio_output {
      	type		            "httpd"
      	name		            "lossless"
      	encoder		          "flac"
      	port		            "8000"
      	max_client	        "8"
      	mixer_type	        "software"
      	format		          "44100:16:2"
      }
    '';
    network.startWhenNeeded = true;
  };

  imports = [
    ./ncmpcpp.nix
  ];
}
