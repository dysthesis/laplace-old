{
  accounts.calendar = {
    basePath = "kalendar";
    accounts.apollyon = {
      primary = true;
      khal = {
        enable = true;
        color = "light green";
        glob = "*";
        priority = 10;
        readOnly = false;
        type = "calendar";
      };
      vdirsyncer = {
        enable = true;
        collections = ["from a" "from b"];
        metadata = ["color" "displayname"];
        conflictResolution = "remote wins";
      };
      local = {
        type = "filesystem";
        fileExt = ".ics";
      };
      remote = {
        type = "caldav";
        url = "https://my.unsw.edu.au/cal/pttd/HjNK7qhBjh.ics";
      };
      primaryCollection = "apollyon"; # workaround
    };
  };
  programs.khal = {
    enable = true;
    locale = {
      # Format strings are for Python strftime, similarly to strftime(3).
      dateformat = "%x";
      datetimeformat = "%c";
      default_timezone = "AEST";
      # Monday is 0, Sunday is 6
      firstweekday = 0;
      longdateformat = "%x";
      longdatetimeformat = "%c";
      timeformat = "%X";
      unicode_symbols = true;
    };
    settings = {
      default = {
        default_calendar = "apollyon";
        timedelta = "5d";
      };
      view = {
        agenda_event_format = "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{reset}";
      };
    };
  };
}
